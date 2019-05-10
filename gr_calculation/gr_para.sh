#!/usr/bin/bash
# first create a .pbs file (then I don't have to change .pbs and .sh separately"
# change [-N] to disired job name
# change [-q] and [-l] accrdingly
# mail [-m] when aborted(a) and existing(e)
# change [-M] to the email that recieves notification
# [-j] transfers output(o) and error(e) messages
# [-o] specifies the name of output/error files

# cd [working directory]
# append time of start and jobID and some job information to log file
# copy line in double quotation in Ln.40 to Ln.36 to ensure correct output
# commands for running job on clusters

# -------- information above will be printed to *.pbs files for quening --------#

# submit *.pbs files to quene. change [template.pbs] according to the last line. the names need to be consisitent.
# print some basic information on sctreen for double check 
# print some basic information to log file upon submission
### check if job function and # of parameters in Ln.50 consistent when editting this file to ensure correct output

echo "
#PBS -N gr_para
#PBS -q iw-shared-6
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=4
#PBS -l pmem=24gb
#PBS -l mem=24gb
#PBS -m ae
#PBS -M ylin369@gatech.edu
#PBS -j oe
#PBS -o $(pwd)/\$PBS_JOBID.err
 
cd $(pwd)
now = \$(date +\"%D %T\")
echo \"\$PBS_JOBID
groft_para(\${INPUT1},\${INPUT2},\${INPUT3},\${INPUT4},\${INPUT5},\${INPUT6},\${INPUT7})
start: \$now
====================================================================\" >> log
module load matlab/r2015a
matlab -nodisplay -r \"groft_para(\${INPUT1},\${INPUT2},\${INPUT3},\${INPUT4},\${INPUT5},\${INPUT6},\${INPUT7})\"
" > gr_para.pbs


jobID="$(qsub -v INPUT1=$1,INPUT2=$2,INPUT3=$3,INPUT4=$4,INPUT5=$5,INPUT6=$6,INPUT7=$7 gr_para.pbs)"
echo "$jobID"
echo "groft_para, L=$1, x0=$2, n0=$3, D=$4, rs=$5, Ti=$6, Tf=$7"
now=$(date +"%D %T")
echo "$jobID
groft_para, L=$1, x0=$2, n0=$3, D=$4, rs=$5, Ti=$6, Tf=$7
submit: $now
====================================================================" >> log

