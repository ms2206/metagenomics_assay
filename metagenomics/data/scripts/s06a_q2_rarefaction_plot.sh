# QIIME2 - Rarefaction plot
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Rarefaction plot"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"

# Alpha rarefaction
# Max-depth based on max non-chimeric reads in s04_stats_dada2.qzv
# Download csv from qiime2view to get exact numeric rarefaction thresholds
qiime diversity alpha-rarefaction \
--i-table "${results_folder}/s04_table_dada2.qza" \
--i-phylogeny "${results_folder}/s05_rooted_tree.qza" \
--p-max-depth 30559 \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s06a_alpha_rarefaction.qzv" 

# Completion message
echo ""
echo "Done"
date
