# QIIME2 - Calculate multiple diversity metrics
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Calculate multiple diversity metrics"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"
diversity_metrics_folder="${results_folder}/s07_diversity_metrics"

# Calculate a whole bunch of diversity metrics 
# Select the sampling-depth as the minimal count of non-chimeric reads (see output of step 4)
qiime diversity core-metrics-phylogenetic \
--i-table "${results_folder}/s04_table_dada2.qza" \
--i-phylogeny "${results_folder}/s05_rooted_tree.qza" \
--p-sampling-depth ENTER_THE_DEPTH_HERE \
--m-metadata-file "samples.txt" \
--output-dir "${diversity_metrics_folder}"

# Export some results out of QIIME2 format to explore
# (these files can be used for analysis outsede of QIIME2)

# Alpha-diversity metrics
qiime tools export \
  --input-path "${diversity_metrics_folder}/observed_features_vector.qza" \
  --output-path "${diversity_metrics_folder}/observed_features_vector"

qiime tools export \
  --input-path "${diversity_metrics_folder}/faith_pd_vector.qza" \
  --output-path "${diversity_metrics_folder}/faith_pd_vector"

qiime tools export \
  --input-path "${diversity_metrics_folder}/evenness_vector.qza" \
  --output-path "${diversity_metrics_folder}/evenness_vector"

qiime tools export \
  --input-path "${diversity_metrics_folder}/shannon_vector.qza" \
  --output-path "${diversity_metrics_folder}/shannon_vector"

# Beta-diversity metrics
qiime tools export \
  --input-path "${diversity_metrics_folder}/unweighted_unifrac_distance_matrix.qza" \
  --output-path "${diversity_metrics_folder}/unweighted_unifrac_distance_matrix"

qiime tools export \
  --input-path "${diversity_metrics_folder}/weighted_unifrac_distance_matrix.qza" \
  --output-path "${diversity_metrics_folder}/weighted_unifrac_distance_matrix"

qiime tools export \
  --input-path "${diversity_metrics_folder}/jaccard_distance_matrix.qza" \
  --output-path "${diversity_metrics_folder}/jaccard_distance_matrix"

qiime tools export \
  --input-path "${diversity_metrics_folder}/bray_curtis_distance_matrix.qza" \
  --output-path "${diversity_metrics_folder}/bray_curtis_distance_matrix"

# Completion message
echo ""
echo "Done"
date
