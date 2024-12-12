# QIIME2 - Import and trim
# Alexey Larionov, 08Dec2024
# Requires environment with QIIME2: Use module spider qiime2 to find QIIME2 module in apps2
# Requires file "source_files.txt" 
# (update the provided "source_files.txt" example by changing the path to files !)

# Stop at runtime errors
set -e

# Start message
echo "QIIME2: Import and Trim"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"

# Importing data to QIIME2. For more details: qiime tools import --help
# Note that file "source_files.txt" should be prepared before you run this script!
qiime tools import \
--type "SampleData[PairedEndSequencesWithQuality]" \
--input-path "source_files.txt" \
--input-format "PairedEndFastqManifestPhred33V2" \
--output-path "${results_folder}/s03_pe_dmx.qza"

# Trim primers (https://docs.qiime2.org/2022.11/plugins/available/cutadapt/)
# This example shows the case when fragments are longer than reads 
# (e.g. ~300bp PCR products sequenced with 150PE Illumina sequencing)
# You should use different approach when reads are longer than PCR fragments
# (e.g. ~300bp PCR productd sequenced with 500PE Illumina sequencing)
qiime cutadapt trim-paired \
--p-front-f ^GTGCCAGCMGCCGCGGTAA \
--p-front-r ^GGACTACHVGGGTWTCTAAT \
--p-match-read-wildcards \
--i-demultiplexed-sequences "${results_folder}/s03_pe_dmx.qza" \
--o-trimmed-sequences "${results_folder}/s03_pe_dmx_trim.qza" 

# Make visualisation file (to view at https://view.qiime2.org/)
qiime demux summarize \
--i-data "${results_folder}/s03_pe_dmx_trim.qza" \
--o-visualization "${results_folder}/s03_pe_dmx_trim.qzv"

# Completion message
echo ""
echo "Done"
date
