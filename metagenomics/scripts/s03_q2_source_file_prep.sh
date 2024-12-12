# bash one liner to update source_files.txt
awk 'NR > 1 {print $1}' "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/scripts/source_files.txt" | xargs -I {} sh -c 'echo {} $(find "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/data" -name {}_1.fastq) $(find "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/data" -name {}_2.fastq)'
