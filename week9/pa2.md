# PA2: Measure Space and Write Amplification in RocksDB and ays to Mitigate Space Amplification


## Overview
- Measure the write amplification and space amplification in RocksDB by varying compaction strategies: leveled compaction and universal compaction.
- Choose one compaction strategy and mitigate space amplification in RocksDB by changing db_bench parameters.
- Analyze the reason why changing such parameter values mitigates space amplification and how it affects write amplification accordingly.



## Experiment Guide
- Refer to this link for how to run db_bench, how to change compaction style, and how to checkout write amplification. [Link](https://github.com/LeeBohyun/RocksDB/blob/main/measure_SAF.md)
- Once you measured required metrics, remove all the files in ``/path/to/datadir`` and change the db_bench option in order to improve space amplification and how it affects write amplification.
- Refer to this link for details of db_bench options: [Link](https://github.com/EighteenZi/rocksdb_wiki/blob/master/Benchmarking-tools.md).


## PA2 Report and Submission
- Submit 2-page report containing the screenshot of all three experiments.
- Elaborate on the reason why the changed parameter value mitigates space amplification in your report.
- Submit run_dbbench.sh file that contains ``./db_bench`` commands for your experiments. Refer to this file to see the example of ``run_dbbench.sh``. [File](https://github.com/LeeBohyun/SWE3033-S2023/blob/main/week9/run_dbbench.sh)
