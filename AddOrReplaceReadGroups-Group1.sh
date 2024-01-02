#!/bin/sh
for n in $(ls /mnt/nfs/lobo/SALMEIDA-NFS/lcosta/MCPP-Lung/MergeBamAlignment/10LC_tumor_S2.readgroups.bam)
do	
  echo $n	
  sbatch --export=sample=$n,ALL AddOrReplaceReadGroups-Group1.sbatch
done
