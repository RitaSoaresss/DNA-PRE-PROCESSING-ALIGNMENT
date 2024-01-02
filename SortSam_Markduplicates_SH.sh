#!/bin/sh
for n in $(ls /mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/NEW_ILLUMINA_PIPELINE/new_MarkDuplicates/*.markeduplicates.bam)
do
  echo $n
  sbatch --export=sample=$n,ALL SortSam_Markduplicates.sbatch
done