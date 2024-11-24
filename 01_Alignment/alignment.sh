#!/bin/bash

# 1. Load modules.
module load gatk/4.1.2.0
module load java/13.0.1
module load bwa/0.7.17
module load samtools/1.10

# 2. Create variables for directories.
ref_alignment=/home/path/to/dir/bwa_index
source=/home/path/to/dir/source

# 3. Alignment with bwa mem. The output is a sam file.
# ----- Blood BAM.
srun bwa mem -M -t 26 -p $ref_alignment/Homo_sapiens.hg19.fa $source/bam1_interleaved.fq > $source/bam1_aln.sam

# ----- Tumor BAM.
srun bwa mem -M -t 26 -p $ref_alignment/Homo_sapiens.hg19.fa $source/bam2_interleaved.fq > $source/bam2_aln.sam

# The end.
