#!/bin/bash

# 1. Load modules.
module load gatk/4.1.2.0
module load java/1.8.0_192
module load samtools/1.10

# 2. Create variables for directories.
ref=/home/path/to/dir/hg19_reference
source=/home/path/to/dir/source
panel_normal=/home/path/to/dir/pon1

# 3. Mutation calling - Mutect2.
srun gatk --java-options "-Xms30g -Xmx230g" Mutect2 \
-R $ref/Homo_sapiens.hg19.fa \
-I $source/bam2_sorted_nodup_aln.bam \
-I $source/bam1_sorted_nodup_aln.bam \
-normal bam1 \
--min-base-quality-score XX \
--callable-depth XX \
-pon $panel_normal/PanelNormal.vcf.gz \
--f1r2-tar-gz $source/bam2-f1r2.tar.gz \
--native-pair-hmm-threads X \
-O $source/bam2.unfiltered.vcf.gz

# The end.
