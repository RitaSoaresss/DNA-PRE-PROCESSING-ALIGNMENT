#!/bin/bash
#SBATCH --job-name=SortSam
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --mem=240G
#SBATCH --cpus-per-task=40
#SBATCH --chdir=/mnt/nfs/lobo/IMM-NFS/cfranco/scratch

path="/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung"

# Run gatk MarkDuplicatesSpark
process_dir="/mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/new_Markduplicates"
process_dir2="/mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/SortSam_MarkDuplicates"

    ##determine file prefix
    s=${sample}

    pf=$(echo ${s%.markeduplicates.bam*})
    s2=${pf#*/mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/new_Markduplicates/}
    echo "s2 is $s2"
    echo "pf is $pf"
    BASE="$process_dir2/$s2"

 echo "Mark Duplicates BAM is $bam"
 BAM="$pf.markeduplicates.bam"

 echo "Sorted BAM will be $SORTED"
 SORTED="$BASE.markeduplicates.sorted.bam"

 echo "sort bam"

 echo "srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar SortSam -I $BAM -O $SORTED SORT_ORDER=coordinate"
 srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar SortSam -I $BAM -O $SORTED -SO coordinate --TMP_DIR /mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/TMP/

# Job statistics (like elapsed time and memory usage)
sacct --format="JOBID,Start,End,Elapsed,CPUTime,AveDiskRead,AveDiskWrite,MaxRSS" -j $SLURM_JOB_ID
