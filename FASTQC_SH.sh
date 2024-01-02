#!/bin/sh
for n in $(ls /mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/NEW_ILLUMINA_PIPELINE/untrimmed_fastq/*_R2_001.fastq.gz)
do
 echo $n
 sbatch --export=sample=$n,ALL FASTQC_new_illumina.sbatch
done