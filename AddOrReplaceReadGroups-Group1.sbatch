#!/bin/bash
#SBATCH --job-name=AddOrReplaceReadGroups.Group1
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --mem=240G
#SBATCH --cpus-per-task=40
#SBATCH --image=broadinstitute/picard:latest
#SBATCH --chdir=/home/rita.soares/scratch/ 
#SBATCH --exclude=compute-[1,5,9,13,17,21]

path="/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung"

# Run gatk SortSamSpark
process_dir="$path/MergeBamAlignment"
process_dir2="$path/AddOrReplaceReadGroups"

    ##determine file prefix
    s=${sample}

    pf=$(echo ${s%.merged.bam*})
    s2=${pf#*/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/MergeBamAlignment/} 
    echo "s2 is $s2"
    echo "pf is $pf"
    BASE="$process_dir2/$s2"

 echo "AddOrReplaceReadGroups (Picard)"
 READGROUPS="$BASE.readgroups.bam"

 echo "ReadGroups bam will be $READGROUPS"
 echo "srun shifter java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar AddOrReplaceReadGroups I=$s O=$READGROUPS RGID=4 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=2"
 srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar AddOrReplaceReadGroups I=$s O=$READGROUPS RGID=4 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=2


# Job statistics (like elapsed time and memory usage)
sacct --format="JOBID,Start,End,Elapsed,CPUTime,AveDiskRead,AveDiskWrite,MaxRSS" -j $SLURM_JOB_ID
