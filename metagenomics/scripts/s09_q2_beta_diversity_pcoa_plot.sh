# QIIME2 - PCOA plot
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: PCOA plot"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"
diversity_metrics_folder="${results_folder}/s07_diversity_metrics"

# Use the weighted unifrac distances (custom-axes parameter can be used to specific any column from your metadata file)
qiime emperor plot \
--i-pcoa "${diversity_metrics_folder}/weighted_unifrac_pcoa_results.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s09_beta_weighted_unifrac_emperor_pcoa.qzv"

# Use the bray curtis distances (custom-axes parameter can be used to specific any column from your metadata file)
qiime emperor plot \
--i-pcoa "${diversity_metrics_folder}/bray_curtis_pcoa_results.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s09_beta_bray_curtis_emperor_pcoa.qzv"

# Completion message
echo ""
echo "Done"
date
