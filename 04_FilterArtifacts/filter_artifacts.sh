#!/bin/bash

# 1. Load modules.
module load gatk/4.1.2.0
module load java/1.8.0_192
module load samtools/1.10

# 2. Create variables for directories.
ref=/home/path/to/dir/hg19_reference/Homo_sapiens.hg19.fa
source=/home/path/to/dir/source
panel_normal=/home/path/to/dir/pon1
exac_common=/home/path/to/dir/exac

# 3. Strand-biased reads - LearnReadOrientationModel.
srun gatk --java-options "-Xms30g -Xmx230g" LearnReadOrientationModel \
-I $source/bam2-f1r2.tar.gz \
-O $source/bam2-read-orientation-model.tar.gz

# 2. Contamination - GetPileupSummaries - Tumor.
srun gatk --java-options "-Xms30g -Xmx230g" GetPileupSummaries \
-I $source/bam2_sorted_nodup_aln.bam \
-V $exac_common/small_exac_common_3_hg19.vcf \
-L $exac_common/small_exac_common_3_hg19.vcf \
-O $source/bam2.tumor.getpileupsummaries.table

# 3. Contamination - GetPileupSummaries - Blood.
srun gatk --java-options "-Xms30g -Xmx230g" GetPileupSummaries \
-I $source/bam1_sorted_nodup_aln.bam \
-V $exac_common/small_exac_common_3_hg19.vcf \
-L $exac_common/small_exac_common_3_hg19.vcf \
-O $source/bam1.germline.getpileupsummaries.table

# 4. Final contamination - CalculateContamination.
srun gatk --java-options "-Xms30g -Xmx230g" CalculateContamination \
-I $source/bam2.tumor.getpileupsummaries.table \
-matched $source/bam1.germline.getpileupsummaries.table \
-O $source/bam2.calculatecontamination.table

# 5. Filter somatic calls - FilterMutectCalls.
srun gatk --java-options "-Xms30g -Xmx230g" FilterMutectCalls \
-V $source/bam2.unfiltered.vcf.gz \
-R $ref/ \
--contamination-table $source/bam2.calculatecontamination.table \
--ob-priors $source/bam2-read-orientation-model.tar.gz \
-O $source/bam2_prefiltered.vcf.gz

# 6. Final treatment. Remove calls with a non-pass quality filter from the final output vcf.
gunzip -d $source/bam2_prefiltered.vcf.gz
awk '/^#/||$7=="PASS"' $source/bam2_prefiltered.vcf > $source/bam2_filtered.vcf

# 7. Compress to gz the output file.
gzip $source/bam2_filtered.vcf

# The end.
