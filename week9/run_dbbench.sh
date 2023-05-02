#!/bin/bash

# level compaction
./db_bench --benchmarks="fillrandom" -disable_wal=true\
        -db="/home/lbh/rocksdb-data" \
        -use_direct_io_for_flush_and_compaction=true \
        -use_direct_reads=true \
        -compaction_style=0\
        -target_file_size_base=2097152 \
        -write_buffer_size=2097152 \
        -max_bytes_for_level_base=33554432 \
        -max_bytes_for_level_multiplier=3 \
        -num=10000000 \
        -key_size=16 -value_size=240\
        -statistics \
        -stats_dump_period_sec=30 \
        -stats_interval_seconds=10 2>&1 | tee result.txt
                
# universal compaction                
./db_bench --benchmarks="fillrandom" -disable_wal=true\
        -db="/home/lbh/rocksdb-data" \
        -use_direct_io_for_flush_and_compaction=true \
        -use_direct_reads=true \
        -compaction_style=1\
        -target_file_size_base=2097152 \
        -write_buffer_size=2097152 \
        -max_bytes_for_level_base=33554432 \
        -max_bytes_for_level_multiplier=3 \
        -num=10000000 \
        -key_size=16 -value_size=240\
        -statistics \
        -stats_dump_period_sec=30 \
        -stats_interval_seconds=10 2>&1 | tee result1.txt

# modified version that mitigates space amplification                
./db_bench --benchmarks="fillrandom" -disable_wal=true\
        -db="/home/lbh/rocksdb-data" \
        -use_direct_io_for_flush_and_compaction=true \
        -use_direct_reads=true \
        -compaction_style=0\
        -target_file_size_base=2097152 \
        -write_buffer_size=2097152 \
        -max_bytes_for_level_base=33554432 \
        -max_bytes_for_level_multiplier=3 \
        -num=10000000 \
        -key_size=16 -value_size=240\
        -statistics \
        -stats_dump_period_sec=30 \
        -stats_interval_seconds=10 2>&1 | tee result2.txt
