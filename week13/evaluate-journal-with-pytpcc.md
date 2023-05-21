# Week 13 Install Pytpcc and Evaluate Journal Mode

## Overview

This week you will learn how to evaluate performance between two journal mode (RBJ and WAL) on SQLite database engine using TPC-C benchmark (`pytpcc`).

> NOTE: This lab is based on the Linux environment. If you don't have a Linux machine, use [VirturalBox](https://www.virtualbox.org/). (Recommend Ubuntu 18.04)

## Prerequisite
 
### Install SQLite Library
- Skip this process if you already installed SQLite library

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

### Install python

```bash
sudo apt-get install python
```

## Build `pytpcc` benchmark

### 1. Setup `pytpcc` benchmark

```bash

# 1. Clone SWE3033-F2021 github repository
git clone https://github.com/meeeejin/SWE3033-F2021.git
cd week-13

# 2. Unzip pytpcc
unzip pytpcc

# 3. Prepare the SQLite configuration file
cd pytpcc
python tpcc.py --print-config sqlite &> sqlite.config

# 4. Open sqlite.config file and modify the database path (./tpcc.db)
vim sqltie.config
```

```
# SqliteDriver Configuration File
# Created 2021-11-21 02:46:44.486741
[sqlite]

# The path to the SQLite database
database             = ./tpcc.db
```

### 2. Load TPC-C database (Warehouse 10)

```bash
# loading
python tpcc.py --warehouse=10 --config=./sqlite.config --no-execute sqlite
```

- `warehouse`: The number of warehouse 
- `config` : Configuration file path
- `no-execute` : Loading only version (no execute)

```bash
# change database file name for backup
cp tpcc.db backup.db
```

### 3. Run TPC-C benchmark

- For each run, prepare the same database file (copy `backup.db` database file)
- To minimize the impact of the performance interference, flush all caches in the system using `vm.drop_caches=3` command.
- Run TPC-C benchmark for 1800 sec

```bash

# prepare the database file
cp backup.db tpcc.db

# flush all cache
sudo sysctl vm.drop_caches=3

# run
python tpcc.py --warehouse=10 --config=./sqlite.config --no-load --duration=1800 --journal=wal sqlite

```
- `warehouse`: The number of warehouse 
- `config` : Configuration file path
- `no-load` : Running only version (no loading phase)
- `duration` : Total execution time (N seconds)

- Example output
```bash
vldb@NVDIMM:~/SWE3033/py-tpcc/pytpcc$ python tpcc.py --warehouse=10 --config=./sqlite.config --no-load --duration=1800 --journal=wal sqlite

11-21-2021 03:17:44 [<module>:234] INFO : Initializing TPC-C benchmark using SqliteDriver
11-21-2021 03:17:44 [execute:056] INFO : Executing benchmark for 1800 seconds
==================================================================
Execution Results after 1800 seconds
------------------------------------------------------------------
                  Executed        Time (µs)       Rate
  DELIVERY        86              21259987.8311   4.05 txn/s
  NEW_ORDER       1043            161138629.436   6.47 txn/s
  ORDER_STATUS    76              18683.1951141   4067.83 txn/s
  PAYMENT         982             117047047.377   8.39 txn/s
  STOCK_LEVEL     95              210156.917572   452.04 txn/s
------------------------------------------------------------------
  TOTAL           2282            299674504.757   7.61 txn/s
```

### 4. Change the journal mode and repeat step 2

- Change the `journal` mode of the SQLite database engine 
- Compare two different journal: `delete` and `wal` modes
  - Configure three different values for `--journal` 

## Report Submission

1. Run TPC-C benchmark for two journal modes
  - Change journal mode to **delete** and **wal**

2. Observe how TPS (txn/s) changes 
  - Record and analyze the TPS for each transaction (`DELIVERY`, `NEW_ORDER`, `ORDER_STATUS`, `PAYMENT`, `STOCK_LEVEL`)

3. Present experimental results

4. Analyze the results
  - hint. The root cause of the performance gap between `delete` mode and `wal` is xxx.

Organize the results and your answer into a single report and submit it. 
Follow the [submission guide](../report-submission-guide.md) for your report.


### References
- [Python TPC-C](https://github.com/apavlo/py-tpcc)
- [Journal mode](https://www.sqlite.org/pragma.html#pragma_journal_mode)
- Jonghyeok Park
