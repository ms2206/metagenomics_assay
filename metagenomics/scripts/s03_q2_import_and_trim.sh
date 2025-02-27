# QIIME2 - Import and trim
# Matthew Spriggs: 12Dec24# Requires environment with QIIME2: Use module spider qiime2 to find QIIME2 module in apps2
# Requires file "source_files.txt" 
# (update the provided "source_files.txt" example by changing the path to files !)

#PBS -N s03_q2_import_and_trim
#PBS -l nodes=1:ncpus=12
#PBS -l walltime=00:30:00
#PBS -q half_hour
#PBS -m abe
#PBS -M matthew.spriggs.452@cranfield.ac.uk

#===============
#PBS -j oe
#PBS -v "CUDA_VISIBLE_DEVICES="
#PBS -W sandbox=PRIVATE
#PBS -k n
ln -s $PWD $PBS_O_WORKDIR/$PBS_JOBID
## Change to working directory
cd $PBS_O_WORKDIR
## Calculate number of CPUs and GPUs
export cpus=`cat $PBS_NODEFILE | wc -l`
## Load production modules
module use /apps2/modules/all
## =============

# Stop at runtime errors
set -e

# Load required modules (this is an example, change it!)
module load QIIME2/2022.8

# Base folder (this is an example, change it!)
base_folder="/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics"

# Start message
echo "QIIME2: Import and Trim"
date
echo ""

# Folders
# base_folder="..."
results_folder="${base_folder}/results"

# make results folder
mkdir -p "${results_folder}"

# source_files.txt filepath
source_filepath="${base_folder}/scripts/source_files_local.txt"

# Importing data to QIIME2. For more details: qiime tools import --help
# Note that file "source_files.txt" should be prepared before you run this script!
qiime tools import \
--type "SampleData[PairedEndSequencesWithQuality]" \
--input-path "${source_filepath}" \
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

## Tidy up the log directory
## =========================
rm $PBS_O_WORKDIR/$PBS_JOBID
