#!/bin/bash
#SBATCH --job-name=MarkDuplicates_50_new_illumina
#SBATCH --time=72:00:00
#SBATCH --ntasks=4
#SBATCH --mem=150G
#SBATCH --cpus-per-task=40
#SBATCH --chdir=/mnt/nfs/lobo/IMM-NFS/cfranco/scratch

path="/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung"

# Run gatk MarkDuplicatesSpark
process_dir="$path/AddOrReplaceReadGroups"
process_dir2="/mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/new_Markduplicates"

    ##determine file prefix
    s=${sample}

    pf=$(echo ${s%.readgroups.bam*})
    s2=${pf#*/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/AddOrReplaceReadGroups/}
    echo "s2 is $s2"
    echo "pf is $pf"
    BASE="$process_dir2/$s2"

 echo "Mark Duplicates in bam"
 READGROUPS="$pf.readgroups.bam"
 MARKED="$BASE.markeduplicates.bam"
 METRICS="$BASE.markduplicates.txt"

 echo "READGROUPS is $READGROUPS"

 echo "MarkDuplicates GATK"
 echo "Marked bam file will be $MARKED"


 echo "srun shifter gatk MarkDuplicatesSpark -I $READGROUPS -O $MARKED -M marked_dup_metrics.txt"
 srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar MarkDuplicates -I $READGROUPS -O $MARKED -M $METRICS --TMP_DIR /mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/TMP/

# Job statistics (like elapsed time and memory usage)
sacct --format="JOBID,Start,End,Elapsed,CPUTime,AveDiskRead,AveDiskWrite,MaxRSS" -j $SLURM_JOB_ID
