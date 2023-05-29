# Configuring Checkpoints in SQLite and Evaluate with Androbench

## Overview

This week you will learn how to configure checkpoint on SQLite database engine using androbench.

> NOTE: This lab is based on the Linux environment. If you don't have a Linux machine, use [VirturalBox](https://www.virtualbox.org/). (Recommend Ubuntu 18.04)

## Prerequisite
 
### Install SQLite Library
- Skip this process if you already installed SQLite library.

```bash
# go to the SQLite build directory 

cd {PATH}/sqlite-src-3360000/build
make -j
sudo make install -j 

# you can use SQLite database in any directory (check the sqlite version with one of the commands below)
cd ~
sqlite3 --version 
sqlite --version

```

### Run Androbench

### 2. Record and analyze the SQLite trace file 
- Configure the SQLite environent setup
- Evaluate execution time and record `real` time
- [androbench.sql](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week14/androbench.sql)

```bash
vldb@NVDIMM:~/SWE3033/sqlite-src-3360000/build$ time ./sqlite3 /home/vldb/ssd/androbench.db < androbench.sql &> /dev/null

real    0m10.947s
user    0m0.546s
sys     0m0.362s
```

### 3. Change the SQLite environment and repeat step 2

- Change the SQLite environment setup using `PRAGMA` command in `androbench.sql` file  
- Change the wal_autocheckpoint : `1`, `2`, `4`, `8`, and `16`
```
/* SQLite environment setup 
* (jhpark): environment setup using PRAGMA command
*/

/* change this value */ 
PRAGMA wal_autocheckpoint=1;
/******************************/
```


## Report Submission

1. Run TPC-C benchmark for four values:
  - Change value of `wal_autocheckpoint`:  `1`, `2`, `4`, `8`, and `16`

2. Observe how TPS (txn/s) changes 
  - Record the run time of androbench
  
3. Present experimental results

4. Analyze the results
  - The `wal_autocheckpoint` value determines the ~~ when using WAL for journaling in SQLite.
  - hint. Invoking checkpoint frequently can cause the performance degradation due to ~~~ . 

Organize the results and your answer into a single report and submit it. 
Follow the [submission guide](../report-submission-guide.md) for your report.


### References
- [Python TPC-C](https://github.com/apavlo/py-tpcc)
- [Journal mode](https://www.sqlite.org/pragma.html#pragma_journal_mode)
- Jonghyeok Park
