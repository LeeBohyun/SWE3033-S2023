# SWE3033-S2023
SKKU Database Project Spring 2023

- Instructor: Prof. Sang-Won Lee (swlee@skku.edu)
- TA: Bo-Hyun Lee (lia323@skku.edu)

## Introduction

Almost every important computer application must manage, update, and query databases using a database system(s) that best fits its workload. In this course, you will learn the three most popular database systems and their major workloads:

- MySQL and TPC-C (*OLTP workload*)
- RocksDB and YCSB (*Key-value store workload*)
- SQLite and AndroBench (*Mobile workload*)

From these three projects, you can learn how each database system works and understand the characteristics of popular workloads. You can also learn how to measure key (performance-related) metrics and analyze their impacts on performance.

## Schedule

| Week # | Topic              | Contents    | TA     |
| :----: | :----------------- |:----------- | :----: |
| 1      | | [Install TPC-C and MySQL](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week1/experiment-guide.md) | Bo-Hyun Lee |
| 2      | TPC-C on MySQL  | [Load & run TPC-C, measure tpmC, and key metrics and analyze the results](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week1/experiment-guide.md) | Bo-Hyun Lee |
| 3      | TPC-C on MySQL  |[Measuring buffer hit rate while varying the buffer size](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week3/measuring-performance-while-varying-buffer-size.md)| Bo-Hyun Lee |
| 4      | TPC-C on MySQL |[Quantifying the cost of single page flush](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week4/how-to-measure-single-page-flush.md)| Bo-Hyun Lee |
| 5      | TPC-C on MySQL |[Project #1 MySQL](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week5/pa1-experiment-guide.md) | Bo-Hyun Lee |
| 6      | RocksDB |[Introduction to RocksDB and DBBench](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week6/how-to-install-and-run-rocksdb-dbbench.md) | Bo-Hyun Lee |
| 7      | RocksDB | RocksDB Compaction Styles | Bo-Hyun Lee |
| 8      | | **Mid-term exam** |  |
| 9      | RocksDB | [PA2: Space Amplification in RocksDB](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week9/pa2.md) | Bo-Hyun Lee |
| 10     | RocksDB | RocksDB Compaction Details | Bo-Hyun Lee |
| 11     | Androbench on SQLite | [SQLite and Androbench Installation Guide](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week11/sqlite-intro-and-androbench.md)| Bo-Hyun Lee |
| 12     | Androbench on SQLite | [Transaction Management in SQLite](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week12/experiment.md) | Bo-Hyun Lee |
| 13     | Androbench on SQLite | TBD | [Journal Modes in SQLite](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week13/evaluate-journal-with-pytpcc.md) |
| 14     | Androbench on SQLite | TBD | Bo-Hyun Lee |
| 15     | | **Final exam** |  |

## Course Overview
- Lecture video and experiment guide uploaded every Monday: recommend you to watch the videos before Wednesday
- Offline Q&A lab every Wednesday: Ask questions and try to end the experiments during that time
- Submit 2-page report before Sunday. Report format: [Link](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/report-submission-guide.md)

## Contact

- If you have any questions about this course, please contact the teaching assistant: Bo-Hyun Lee (lia323@skku.edu).
- You must attend Q & A session every Wednesday 18:00PM - 19:00PM at 제2공학관, 2nd Engineering building, 26515.

