#!/bin/bash
# FastQC & MiltiQC
# Alexey Larionov, 08Dec2024
# Requires FastQC and MultiQC in environment

# Stop at runtime errors
set -e

# Start message
echo "FastQC & MultiQC"
date
echo ""

# Folders
# base_folder="..."
data_folder="${base_folder}/data" # should exist and contain fastq files

# Go to data folder
cd "${data_folder}"

# List of fastq files in data folder
fastq_files=$(ls *.fastq)

# Run FastQC for all fastq files
fastqc $fastq_files

# Run MultiQC in the current folder
multiqc .

# Completion message
echo "Done"
date
