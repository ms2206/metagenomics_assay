#!/bin/bash
# Download files from NCBI SRA
# Alexey Larionov, 08Dec2024

# Stop at runtime errors
set -e

# Start message
echo "Started downloading FASTQ files from SRA"
date
echo ""

# Folders
#base_folder="..."
sra_folder="${base_folder}/tools/sratoolkit.x.y.z-ubuntu64/bin" # update x.y.z 
data_folder="${base_folder}/data" # may exist, but should not contain the data

# List of SRA IDs 
# The next line of code reads the first colimn from the samples.txt file,   
# omitting the header line, and saves it to the variable sra_ids.  
# It ames that the samples file is in the same folder as the script.  
sra_ids=$(awk 'NR > 1 {print $1}' samples.txt)

# Loop over SRA IDs and use fasterq-dump to download the data
for id in $sra_ids
do
  echo "${id}"
  "${sra_folder}/fasterq-dump" $id --split-files --skip-technical --outdir "${data_folder}"
  echo ""
done

# Completion message
echo ""
echo "Done"
date
