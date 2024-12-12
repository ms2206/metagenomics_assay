# QIIME2 - Phylogenetic tree
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2 

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Phylogenetic tree"
date
echo ""

# Folders
#base_folder="..."
results_folder="${base_folder}/results"

# Perform multiple alignments and build phylogenetic trees
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences "${results_folder}/s04_rep_seqs_dada2.qza" \
  --o-alignment "${results_folder}/s05_aligned_rep_seqs.qza" \
  --o-masked-alignment "${results_folder}/s05_masked_aligned_rep_seqs.qza" \
  --o-tree "${results_folder}/s05_unrooted_tree.qza" \
  --o-rooted-tree "${results_folder}/s05_rooted_tree.qza"

# --- Export tree dta for plotting outside QIIME2 --- #

# Tree files are stored in a separate sub-folder in Results folder.
# They can be used to plot trees in several online tree viewers.
# For instance, tree.nwk file can be viewed using NCBI tree viewer
# https://www.ncbi.nlm.nih.gov/tools/treeviewer/
# 
# NCBI tree viewer upload link:
# https://www.ncbi.nlm.nih.gov/projects/treeview/tv.html?appname=ncbi_tviewer&renderer=radial&openuploaddialog 

# Export tree as tree.nwk
qiime tools export \
  --input-path "${results_folder}/s05_rooted_tree.qza" \
  --output-path "${results_folder}/s05_phylogenetic_tree"

# Export masked alignment as aligned-dna-sequences.fasta
# this fasta is not used by NCBI tree viewer, but may be used by other viewers
qiime tools export \
  --input-path "${results_folder}/s05_masked_aligned_rep_seqs.qza" \
  --output-path "${results_folder}/s05_phylogenetic_tree"

# Completion message
echo ""
echo "Done"
date
