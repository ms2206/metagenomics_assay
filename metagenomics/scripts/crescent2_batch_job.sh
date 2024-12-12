#!/bin/bash
# Minimal set of Crescent2 batch submission instructions 
# Matthew Spriggs: 12Dec24

# Crescent2 script
# Note: this script should be run on a compute node
# qsub script.sh

# PBS directives
#---------------

#PBS -N test
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

# --- Your code starts here --- #

# Stop at runtime errors
set -e

# Load required modules (this is an example, change it!)
module load FastQC/0.11.9-Java-11
module load MultiQC/1.12-foss-2021b
fastqc --version
multiqc --version

# Base folder (this is an example, change it!)
base_folder="/mnt/beegfs/home/s430452/metagenomics_assay/metagenomics/"

# Start message (this is an example, change it!)
echo "Started test script"
date
echo ""

# Do not forget to update the header and PBS directives:
# job name (!), num of cores, required time and cluster queue, put your e-mail address
# Also, do not to forget to load and check the required modules.

# You may continue your bash script here.  

# Alternatively, ou may source your script here, e.g.:
# source s02_qc.sh

# Completion message
echo "Done"
date

# --- Your code ends here --- #

## Tidy up the log directory
## =========================
rm $PBS_O_WORKDIR/$PBS_JOBID
