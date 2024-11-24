# Exome pipeline for matched normal/tumor samples (FFPE tumor samples) from cancer patients.
## Repository created by Jose Camacho Valenzuela.
Pipeline to process exome-sequenced BAM files (matched normal/tumor) with basic parameters, from alignment to annotation.

### Disclaimer.
This repository provides an example of a mock pipeline for processing blood BAM files for downstream germline exome analysis. The pipeline is broken down into individual scripts `.sh`, intended to serve as generalized templates, which can be adapted or modified according to users' specific needs.

## 1) Alignment to the human reference genome hg19.
Script available in the subdirectory <b> 01_Alignment </b>, file `alignment.sh`.

## 2) Remove PCR duplicates.
Script available in the subdirectory <b> 02_PCRduplicates </b>, file `PCR_duplicates.sh`.

## 3) Mutation calling for tumor samples.
Script available in the subdirectory <b> 03_VariantCalling </b>, file `mutation_calling.sh`. This step attempts to remove germline variants from the tumor sample by indicating in the code the matched blood/normal BAM of the patient, followed by a panel of normal (which can be constructed by the user, or download one from GATK portal).

## 4) Filter sequencing artifacts and contamination.
Script available in the subdirectory <b> 04_HardFiltering </b>, file `filter_artifacts.sh`. This is an additional step to have higher confidence of the somatic mutations called from FFPE samples.

## 5) Annotation with Annovar.
Script available in the subdirectory <b> 05_Annotation </b>, file `annotation.sh`.
Additionally, installation of annovar is exemplified in `Script_install_annovar_commandline.sh`.

