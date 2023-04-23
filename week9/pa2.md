# PA2: Measure Space and Write Amplification in RocksDB and ways to Mitigate Space Amplification


## Overview
- Measure the write amplification and space amplification in RocksDB by varying compaction strategies: leveled compaction and universal compaction.
- Choose one compaction strategy and mitigate space amplification in RocksDB by changing db_bench parameters.
- Analyze the reason why changing such parameter values mitigates space amplification and how it affects write amplification accordingly.



## Experiment Guide
- Refer to this link for how to run db_bench, how to change compaction style, and how to checkout write amplification. [Link[(https://github.com/LeeBohyun/RocksDB/blob/main/measure_SAF.md)
- Once you measured required metrics, remove all the files in ``/path/to/datadir`` and change the db_bench option in order to improve space amplification and how it affects write amplification.
- Refer to this link for details of db_bench options: [Link](https://github.com/EighteenZi/rocksdb_wiki/blob/master/Benchmarking-tools.md).


## PA2 Report and Submission
- Submit 2-page report containing the screenshot of all three results
- Elaborate on the reason why the changed parameter value mitigates space amplification
- Also contain db_bench options that you ran for each experiment in  
