#!/bin/bash

# 1. Load modules.
module load bcftools/1.10.2
module load tabix/0.2.6

# 2. Create variables for directories.
source=/home/path/to/dir/source

# 3. Rename properly the filtrated input vcf.
mv $source/bam2_filtered.vcf.gz $source/bam2.unannotated.vcf.gz

# 4. Run Annovar.
cd /home/josecv3/projects/def-wfoulkes/josecv3/Annovar_commandline/annovar
table_annovar.pl $source/bam2.unannotated.vcf.gz \
humandb/ --buildver hg19 \
--outfile $source/bam2.annotated \
--remove \
--protocol 1000g2015aug_all,snp138,esp6500siv2_all,exac03nontcga,kaviar_20150923,gme,cosmic70,revel,mcap,gnomad_genome,dbnsfp30a,dbscsnv11,clinvar_20220320,cytoBand,refGene \
--operation f,f,f,f,f,f,f,f,f,f,f,f,f,r,g \
--nastring . \
--otherinfo \
--vcfinput

# The end.
