#!/bin/bash

# 1. Load modules.
module load gatk/4.1.2.0
module load java/13.0.1
module load bwa/0.7.17
module load samtools/1.10

# 2. Create variables for directories.
source=/home/path/to/dir/source

# 3. Sort the aligned bam file.
# ----- Blood BAM.
srun gatk --java-options "-Xms30g -Xmx120g" SortSam \
-I $source/bam1_mrg_aln.bam \
-O $source/bam1_sorted_aln.bam \
--SORT_ORDER coordinate

# ----- Tumor BAM.
srun gatk --java-options "-Xms30g -Xmx120g" SortSam \
-I $source/bam2_mrg_aln.bam \
-O $source/bam2_sorted_aln.bam \
--SORT_ORDER coordinate

# 4. Mark PCR duplicates.
# ----- Blood BAM.
srun gatk --java-options "-Xms30g -Xmx120g" MarkDuplicates \
-I $source/bam1_sorted_aln.bam \
-O $source/bam1_sorted_nodup_aln.bam \
-M $source/bam1_sorted_nodup_aln_metrics.txt \
--REMOVE_DUPLICATES true

# ----- Tumor BAM.
srun gatk --java-options "-Xms30g -Xmx120g" MarkDuplicates \
-I $source/bam2_sorted_aln.bam \
-O $source/bam2_sorted_nodup_aln.bam \
-M $source/bam2_sorted_nodup_aln_metrics.txt \
--REMOVE_DUPLICATES true

# 5. Remove no longer useful intermediate files.
rm $source/bam1_mrg_aln.bam $source/bam1_mrg_aln.bai
rm $source/bam2_mrg_aln.bam $source/bam2_mrg_aln.bai

# 5. Create index.
samtools index $source/bam1_sorted_nodup_aln.bam
samtools index $source/bam2_sorted_nodup_aln.bam

# The end.

