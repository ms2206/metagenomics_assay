# QIIME2 - Apply rarefaction
# Matthew Spriggs: 13Dec24
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub script.sh

# PBS directives
#---------------

#PBS -N s06b_q2_apply_rarefactation
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

# Load required modules
module load QIIME2/2022.8

# Start message
echo "QIIME2: Apply rarefaction"
date
echo ""

# Base folder 
base_folder="/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics"

# Folders
results_folder="${base_folder}/results"

# Rarefaction
# Select the sampling-depth as the minimal count of non-chimeric reads (see output of step 4)
qiime feature-table rarefy \
--i-table "${results_folder}/s04_table_dada2.qza" \
--p-sampling-depth 14107 \
--o-rarefied-table "${results_folder}/s06b_rarefied_table.qza"

# Completion message
echo ""
echo "Done"
date

## Tidy up the log directory
## =========================
rm $PBS_O_WORKDIR/$PBS_JOBID
