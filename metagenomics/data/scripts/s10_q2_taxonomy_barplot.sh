# QIIME2 - Taxonomy barplot
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Assumes that the resources folder contains the claccifier recommended by QIIME2 for 515F/806R 16S region. 
# The classifier was trained on Greengenes 13.8 99% OTUs ( see https://docs.qiime2.org/2022.8/data-resources/ )
# The classifier was downloaded once using the code like this: 
# cd "${resources_folder}"
# wget https://data.qiime2.org/2022.8/common/gg-13-8-99-515-806-nb-classifier.qza

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Taxonomy barplot"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"
resources_folder="${base_folder}/resources"

# Assign taxonomy to sequences
qiime feature-classifier classify-sklearn \
--i-classifier "${resources_folder}/gg-13-8-99-515-806-nb-classifier.qza" \
--i-reads "${results_folder}/s04_rep_seqs_dada2.qza" \
--o-classification "${results_folder}/s10_taxonomy.qza"

# Show taxonimies assigned to each ASV
qiime metadata tabulate \
--m-input-file "${results_folder}/s10_taxonomy.qza" \
--o-visualization "${results_folder}/s10_taxonomy.qzv"

# Make taxonomy barplot
qiime taxa barplot \
--i-table "${results_folder}/s06b_rarefied_table.qza" \
--i-taxonomy "${results_folder}/s10_taxonomy.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s10_taxa_bar_plot.qzv"

# Completion message
echo ""
echo "Done"
date
