# QIIME2 - Alpha-diversity box-plots
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Alpha-diversity box-plots"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"
diversity_metrics_folder="${results_folder}/s07_diversity_metrics"

# Visualize relationships between alpha diversity and study metadata
# (uses some files created at the previous step)
qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/faith_pd_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_faith_pd_per_group.qzv"

qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/evenness_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_evenness_per_group.qzv"

qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/shannon_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_shannon_per_group.qzv"

# Completion message
echo ""
echo "Done"
date
