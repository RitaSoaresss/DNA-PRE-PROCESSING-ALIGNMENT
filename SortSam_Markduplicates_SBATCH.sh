#!/bin/bash
#SBATCH --job-name=SortSam_Markduplicates
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --mem=240G
#SBATCH --cpus-per-task=40
#SBATCH --chdir=/home/rita.soares/scratch/

path="/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung"

# Run gatk MarkDuplicatesSpark
process_dir="$path/NEW_ILLUMINA_PIPELINE/new_MarkDuplicates"
process_dir2="$path/SortSam_MarkDuplicates"

    ##determine file prefix
    s=${sample}

    pf=$(echo ${s%.readgroups.bam*})
    s2=${pf#*/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/NEW_ILLUMINA_PIPELINE/new_MarkDuplicates/}
    echo "s2 is $s2"
    echo "pf is $pf"
    BASE="$process_dir2/$s2"

 echo "Mark Duplicates BAM is $bam"
 BAM="$pf.unsorted.bam"

 echo "Sorted BAM will be $SORTED"
 SORTED="$BASE.sorted.bam"

 echo "sort bam"

 echo "srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar SortSam -I $BAM -O $SORTED SORT_ORDER=coordinate"
 srun /mnt/beegfs/apptainer/images/picard_latest.sif java -XX:ParallelGCThreads=40 -jar /usr/picard/picard.jar SortSam -I $BAM -O $SORTED SORT_ORDER=coordinate

# Job statistics (like elapsed time and memory usage)
sacct --format="JOBID,Start,End,Elapsed,CPUTime,AveDiskRead,AveDiskWrite,MaxRSS" -j $SLURM_JOB_ID