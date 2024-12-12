# QIIME2 - Apply rarefaction
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Apply rarefaction"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"

# Rarefaction
# Select the sampling-depth as the minimal count of non-chimeric reads (see output of step 4)
qiime feature-table rarefy \
--i-table "${results_folder}/s04_table_dada2.qza" \
--p-sampling-depth ENTER_THE_DEPTH_HERE \
--o-rarefied-table "${results_folder}/s06b_rarefied_table.qza"

# Completion message
echo ""
echo "Done"
date
