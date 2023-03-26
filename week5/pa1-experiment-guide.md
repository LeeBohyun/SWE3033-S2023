# PA1: Improve TpmC by changing IO related InnoDB parameters

## Overview
- For the assignment, your task is to change/add the I/O related InnoDB parameters in my.cnf to improve TpmC.
- By looking at MySQL source code and MySQL document, investigate which parameter affects I/O operation process in InnoDB and how you can improve the TpmC by readjusting it/them. You can add/modify multiple InnoDB options. 
- After achieving performance gain, present an experiment result before and after changing my.cnf.
- Then, elaborate the reason why it leads to performance improvement based on MySQL source code and document.

## Instructions

1. First, start MySQL server using the ``my.cnf`` file below. If you are using DB less than 20 warehouse, change the buffer pool size as 10% of your DB size.

```bash
$ vi my.cnf

#
# The MySQL database server configuration file
#
[client]
user    = root
port    = 3306
socket  = /tmp/mysql.sock

[mysql]
prompt  = \u:\d>\_

[mysqld_safe]
socket  = /tmp/mysql.sock

[mysqld]
# Basic settings
default-storage-engine = innodb
pid-file        = /path/to/datadir/mysql.pid
socket          = /tmp/mysql.sock
port            = 3306
datadir         = /path/to/datadir/
log-error       = /path/to/datadir/mysql_error.log

#
# Innodb settings
#
# Page size
innodb_page_size=16KB

# Buffer pool settings
innodb_buffer_pool_size=256M
innodb_buffer_pool_instances=8

# Transaction log settings
innodb_log_file_size=100M
innodb_log_files_in_group=2
innodb_log_buffer_size=32M

# Log group path (iblog0, iblog1)
# If you separate the log device, uncomment and correct the path
#innodb_log_group_home_dir=/path/to/logdir/

# Flush settings (SSD-optimized)
# 0: every 1 seconds, 1: fsync on commits, 2: writes on commits
innodb_flush_log_at_trx_commit=0
innodb_flush_neighbors=0
innodb_flush_method=O_DIRECT
```
- Start a MySQL server

```bash
$ ./bin/mysqld_safe --defaults-file=/path/to/my.cnf
```

2. Run the TPC-C benchmark
- Run the TPC-C benchmark for 30 minutes. Using performance metrics shown by ``iostat`` or ``show engnine innodb status`` query can help you compare the performance.
```bash
$ ./tpcc_start -h 127.0.0.1 -S /tmp/mysql.sock -d tpcc -u root -p "yourPassword" -w 20 -c 8 -r 10 -l 1200 | tee tpcc-vanilla-result.txt
```

3. Next, run the same experiment with modified ``my.cnf`` to improve the performance. Reopen MySQL server with the modified ``my.cnf`` file, and run the same TPC-C benchmark.

4. Compare various performance metrics, mainly TpmC, read/s, write/s, and such. Then, **analyze the reason why it leads to performance improvement** on your report based on MySQL source code and [MySQL document](https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html). 

## Submission Requirement
Your report should include:
- Screenshot of tpmC result of both experiments 
- Anaylsis on the experiment result including reason why it leads to performance improvement

You should also submit two ``my.cnf`` files for me to test.

## Grading Policy
- Performance improvement: 40%
- Result analysis: 60%

Let me remind you that any kind of forging is unaccepted, and you will get zero marks. 






 
