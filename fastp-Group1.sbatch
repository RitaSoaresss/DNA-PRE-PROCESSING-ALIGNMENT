#!/bin/bash
#SBATCH --job-name=fastp.Group1
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --mem=240G
#SBATCH --cpus-per-task=40
#SBATCH --image=virusx/fastp:0.19.5
#SBATCH --chdir=/home/rita.soares/scratch/ 
#SBATCH --exclude=compute-[1,5,9,13,17,21]

path="/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung"

# Move fastq files to process folder and run fastp
process_dir="$path/Group_1"
process_dir2="$path/fastp"


    ##determine file prefix
    s=${sample}

    pf=$(echo ${s%_R1_001.*})
    NAME1=$(echo ${pf}_R1_001.fastq.gz)
    NAME2=$(echo ${pf}_R2_001.fastq.gz)
    
    trimBASE=$pf*
    echo "trimBASE is $trimBASE"


 echo "moving fastq to processing folder"
 echo "mv $trimBASE $process_dir2/"
 mv $trimBASE $process_dir2/ # move fastq files

 echo "Adapter and quality trimming with fastp"

    ##determine file prefix
    s2=${pf#*/mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/Group_1/} 
    echo "s2 is $s2"


    pf2=$(echo ${s2%_R1_001.*})
    BASE="$process_dir2/$pf2"
    NAME1b=$(echo ${BASE}_R1_001.fastq.gz)
    NAME2b=$(echo ${BASE}_R2_001.fastq.gz)
    echo "BASE file name is $BASE"

    R1="_R1"
    R2="_R2"
    STR5="$BASE$R1"
    STR6="$BASE$R2"
    echo "NAME1b IS $NAME1b"
    echo "NAME2b IS $NAME2b"
    echo "STR5 IS $STR5"
    echo "STR6 IS $STR6"

 echo "Start processing $pf2"
 echo "Trimming reads..."
 echo "fastp -i $NAME1b -I $NAME2b -o $STR5.trimmed.fastq.gz -O $STR6.trimmed.fastq.gz"
 srun shifter fastp --thread 40 -i $NAME1b -I $NAME2b -o $STR5.trimmed.fastq.gz -O $STR6.trimmed.fastq.gz


 #echo "moving untrimmed fastq"
 #echo "mv $process_dir2/*_001.fastq.gz $path/untrimmed_fastq/"
 mv $process_dir2/*_001.fastq.gz $path/untrimmed_fastq/ # move untrimmed fastq files


# Job statistics (like elapsed time and memory usage)
sacct --format="JOBID,Start,End,Elapsed,CPUTime,AveDiskRead,AveDiskWrite,MaxRSS" -j $SLURM_JOB_ID
