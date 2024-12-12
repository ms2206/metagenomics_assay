# QIIME2 - Denoise
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Denoise"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"

# Denoise (default --p-n-reads-learn 1000000)
# In this example we do not aditionally trim data by quality (both trunc-len = 0)
# because the data quality is good from the beginning to the end of the reads.  
# Setting the number of threads to 0 requests all cores available on PC. 
# This is OK when you use a personal laptop, but should be changed for HPC.  
qiime dada2 denoise-paired \
--i-demultiplexed-seqs "${results_folder}/s03_pe_dmx_trim.qza" \
--p-trunc-len-f 0 \
--p-trunc-len-r 0 \
--p-n-threads 0 \
--o-table "${results_folder}/s04_table_dada2.qza" \
--o-denoising-stats "${results_folder}/s04_stats_dada2.qza" \
--o-representative-sequences "${results_folder}/s04_rep_seqs_dada2.qza" \
--verbose

# Summarise feature table
qiime feature-table summarize \
--i-table "${results_folder}/s04_table_dada2.qza" \
--o-visualization "${results_folder}/s04_table_dada2.qzv"

# Visualise statistics
qiime metadata tabulate \
--m-input-file "${results_folder}/s04_stats_dada2.qza" \
--o-visualization "${results_folder}/s04_stats_dada2.qzv"

# Tabulate representative sequences
qiime feature-table tabulate-seqs \
--i-data "${results_folder}/s04_rep_seqs_dada2.qza" \
--o-visualization "${results_folder}/s04_rep_seqs_dada2.qzv"

# Completion message
echo ""
echo "Done"
date
