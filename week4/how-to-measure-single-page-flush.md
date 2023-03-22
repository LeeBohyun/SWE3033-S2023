# Quantifying the Cost of a Single Page Flush

## Overview
This week, you will quantify the cost of a single page flush. You will first add some codes to measure the wait time of a single page flush. After running TPC-C with modified MySQL, calculate the average time and the total time it took to perform single page flushes. If you have any questions, please feel free to contact me via email.


## Instructions

1. First, add the codes that log the response time of single page flush.
- In ```mysql-5.7.33/storage/innobase/buf/buf0flu.cc``` file, find a funcion named ``buf_flush_single_page_from_LRU()``.
- Add the time variable and fprintf code like the below example.
```bash
/******************************************************************//**
This function picks up a single page from the tail of the LRU
list, flushes it (if it is dirty), removes it from page_hash and LRU
list and puts it on the free list. It is called from user threads when
they are unable to find a replaceable page at the tail of the LRU
list i.e.: when the background LRU flushing in the page_cleaner thread
is not fast enough to keep pace with the workload.
@return true if success. */
bool
buf_flush_single_page_from_LRU(
/*===========================*/
	buf_pool_t*	buf_pool)	/*!< in/out: buffer pool instance */
{
	ulint		scanned;
	buf_page_t*	bpage;
	ibool		freed;

	buf_pool_mutex_enter(buf_pool);

	for (bpage = buf_pool->single_scan_itr.start(), scanned = 0,
	     freed = false;
	     bpage != NULL;
	     ++scanned, bpage = buf_pool->single_scan_itr.get()) {

		ut_ad(buf_pool_mutex_own(buf_pool));

		buf_page_t*	prev = UT_LIST_GET_PREV(LRU, bpage);

		buf_pool->single_scan_itr.set(prev);

		BPageMutex*	block_mutex;

		block_mutex = buf_page_get_mutex(bpage);

		mutex_enter(block_mutex);

		if (buf_flush_ready_for_replace(bpage)) {
			/* block is ready for eviction i.e., it is
			clean and is not IO-fixed or buffer fixed. */
			mutex_exit(block_mutex);

			if (buf_LRU_free_page(bpage, true)) {
				buf_pool_mutex_exit(buf_pool);
				freed = true;
				break;
			}

		} else if (buf_flush_ready_for_flush(
				   bpage, BUF_FLUSH_SINGLE_PAGE)) {

			ib_time_monotonic_ms_t	single_page_flush_start_time = ut_time_monotonic_ms(); //added line

			/* Block is ready for flush. Try and dispatch an IO
			request. We'll put it on free list in IO completion
			routine if it is not buffer fixed. The following call
			will release the buffer pool and block mutex.

			Note: There is no guarantee that this page has actually
			been freed, only that it has been flushed to disk */

			freed = buf_flush_page(
				buf_pool, bpage, BUF_FLUSH_SINGLE_PAGE, true);

			ib_time_monotonic_ms_t	single_page_flush_end_time = ut_time_monotonic_ms();	//added line

			fprintf(stderr, "single page flush response time: %d\n", single_page_flush_end_time-single_page_flush_start_time); //added line

			if (freed) {
				break;
			}

			mutex_exit(block_mutex);
		} else {
			mutex_exit(block_mutex);
		}

		ut_ad(!mutex_own(block_mutex));
	}

	if (!freed) {
		/* Can't find a single flushable page. */
		ut_ad(!bpage);
		buf_pool_mutex_exit(buf_pool);
	}

	if (scanned) {
		MONITOR_INC_VALUE_CUMULATIVE(
			MONITOR_LRU_SINGLE_FLUSH_SCANNED,
			MONITOR_LRU_SINGLE_FLUSH_SCANNED_NUM_CALL,
			MONITOR_LRU_SINGLE_FLUSH_SCANNED_PER_CALL,
			scanned);
	}

	ut_ad(!buf_pool_mutex_own(buf_pool));

	return(freed);
}

```

2. Then rebuild MySQL 

```bash
$ cd /path/to/mysql-basedir
$ make -j install
```

3. Start a MySQL server
- Set ``innodb_buffer_pool_size`` as 10% of your DB size. 
- e.g., if you are using 20 warehouses(i.e., 2GB), you can set your ``innodb_buffer_pool_size`` as 200MB. 
```bash
$ ./bin/mysqld_safe --defaults-file=/path/to/my.cnf
```

4. Run the TPC-C benchmark
Run the benchmark by modifying the experimental parameters to match your system specifications. For example:
```bash
$ ./tpcc_start -h 127.0.0.1 -S /tmp/mysql.sock -d tpcc -u root -p "yourPassword" -w 20 -c 8 -r 10 -l 1200 | tee tpcc-result.txt
```

5. You can check if MySQL has been rebuilt successfully by looking at the ``/path/to/test-data/mysql_error.log``. 
```bash
$ cd /path/to/test-data/
$ cat mysql_error.log
...
single page flush response time: 1
single page flush response time: 4
single page flush response time: 10
...
```

6. Calculate the **average response time **of single page flushes and the **total wait time** of user threads waiting for a single page flushes. You can use ``awk`` command and ``grep`` command to easily parse the required information.

7. To give you an example on how to analyze the result, here is one way to do so.
- The response time of a single page flush is 4.86ms, on average.
- Single page flush occured 634,524 times during the couse of 30 minute experiment.
- Since we ran TPC-C with 8 user threads, each user thread waited 385 seconds for a single page flush to be finished.

## Report Requirements
- The report should include a screenshot of the following command.
```bash
tail /path/to/test-data/mysql_eror.log
```
- The report should contain the **average response time** of single page flushes and the **total wait time** of user threads waiting for a single page flushes.

