#!/bin/sh
for n in $(ls /mnt/nfs/lobo/IMM-NFS/cfranco/MCPP-Lung/DNA/new_Markduplicates/Lung47_tumor_S5.markeduplicates.bam)
do
  echo $n
  sbatch --export=sample=$n,ALL SortSam.sbatch
done
