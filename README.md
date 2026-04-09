# Decoding the Non-Coding Landscape of Rare Pediatric Sarcomas

## Overview
This repository contains a reproducible, multi-omic bioinformatics pipeline designed to identify and prioritize non-coding regulatory variants in rare pediatric sarcomas (e.g., Ewing Sarcoma). 

While most oncological pipelines focus on the exome (<2% of the genome), this project integrates Whole Genome Sequencing (WGS) and RNA-Seq to uncover how mutations in distal enhancers and promoters drive aberrant gene expression.

## Architecture
The project is divided into two main components:
1. **Upstream Processing (Nextflow):** A scalable, containerized pipeline that handles FASTQ quality control, read alignment, and variant calling in non-coding regions.
2. **Downstream Analysis (Python/Scikit-Learn):** A Machine Learning module that prioritizes called variants based on functional impact scores, conservation, and distance to Transcription Start Sites (TSS).

## Tech Stack
* **Workflow Management:** Nextflow (DSL2)
* **Environment:** Docker
* **Data Processing:** BWA-MEM, GATK4, Samtools
* **Machine Learning:** Python, Pandas, Scikit-Learn (Random Forest Classifier)

## Quick Start

```bash
git clone [https://github.com/aniket-987/pediatric-sarcoma-noncoding.git](https://github.com/aniket-987/pediatric-sarcoma-noncoding.git)
cd pediatric-sarcoma-noncoding

nextflow run pipeline/main.nf -profile docker --reads "data/*_{1,2}.fastq.gz"