#!/bin/sh
for n in $(ls /mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/fastq/*_R2_001.fastq.gz)
do
 echo $n
 sbatch --export=sample=$n,ALL FASTQC_DNA.sbatch
done
