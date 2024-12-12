# add header to source_files_local.txt
awk 'NR==1 {OFS=" "; print $0}' source_files.txt > source_files_local.txt

# bash one liner to update source_files.txt
awk 'NR > 1 {print $1}' "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/scripts/source_files.txt" | xargs -I {} sh -c 'echo {} $(find "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/data" -name {}_1.fastq) $(find "/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/data" -name {}_2.fastq)' | tr ' ' '\t' >> source_files_local.txt
