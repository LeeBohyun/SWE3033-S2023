#!/bin/bash

        ./db_bench -db=/home/vldb/CNS --benchmarks=fillrandom --bytes_per_sync=2097152\
                -use_direct_reads -key_size=16 -value_size=800   -level0_file_num_compaction_trigger=4 -disable_wal=on -wal_size_limit_MB=2\
                -use_direct_io_for_flush_and_compaction \
                -max_bytes_for_level_multiplier=4 -write_buffer_size=2147483648  -min_write_buffer_number_to_merge=2 -max_write_buffer_number=4\
                -base_background_compactions=4 -max_background_compactions=4 -max_background_flushes=4 -writable_file_max_buffer_size=2097152 \
                -target_file_size_multiplier=1 -duration=1800 -threads=48  \
                -max_background_jobs=32  -statistics=true -stats_level=5 \
                -stats_interval_seconds=60 
                
                
        ./db_bench -db=/home/vldb/CNS --benchmarks=fillrandom --bytes_per_sync=2097152\
                -use_direct_reads -key_size=16 -value_size=800   -level0_file_num_compaction_trigger=4 -disable_wal=on -wal_size_limit_MB=2\
                -use_direct_io_for_flush_and_compaction \
                -max_bytes_for_level_multiplier=4 -write_buffer_size=2147483648  -min_write_buffer_number_to_merge=2 -max_write_buffer_number=4\
                -base_background_compactions=4 -max_background_compactions=4 -max_background_flushes=4 -writable_file_max_buffer_size=2097152 \
                -target_file_size_multiplier=1 -duration=1800 -threads=48  \
                -max_background_jobs=32  -statistics=true -stats_level=5 \
                -stats_interval_seconds=60 

                
        ./db_bench -db=/home/vldb/CNS --benchmarks=fillrandom --bytes_per_sync=2097152\
                -use_direct_reads -key_size=16 -value_size=800   -level0_file_num_compaction_trigger=4 -disable_wal=on -wal_size_limit_MB=2\
                -use_direct_io_for_flush_and_compaction \
                -max_bytes_for_level_multiplier=4 -write_buffer_size=2147483648  -min_write_buffer_number_to_merge=2 -max_write_buffer_number=4\
                -base_background_compactions=4 -max_background_compactions=4 -max_background_flushes=4 -writable_file_max_buffer_size=2097152 \
                -target_file_size_multiplier=1 -duration=1800 -threads=48  \
                -max_background_jobs=32  -statistics=true -stats_level=5 \
                -stats_interval_seconds=60 
