#!/bin/sh
for n in $(ls /mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/AddOrReplaceReadGroups/Lung50_tumor_S8.readgroups.bam)
do	
  echo $n	
  sbatch --export=sample=$n,ALL MarkDuplicates_50_new_illumina.sbatch
done
