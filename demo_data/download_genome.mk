################################################################
##
## Author: Claire Rioualen
## Date: 2019-06-25
##

export LC_ALL=C
export LANG=C


.PHONY: \
	init\
	download_genome_data
	
### Download genome & annotations 
download_genome_data:
	mkdir -p $(ANALYSIS_DIR)/genome && \
	wget -nc ftp://ftp.ensemblgenomes.org/pub/bacteria/release-37/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/dna/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.dna.chromosome.Chromosome.fa.gz -P $(ANALYSIS_DIR)/genome && \
	wget -nc ftp://ftp.ensemblgenomes.org/pub/bacteria/release-37/gff3/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.chromosome.Chromosome.gff3.gz -P $(ANALYSIS_DIR)/genome && \
	wget -nc ftp://ftp.ensemblgenomes.org/pub/release-37/bacteria/gtf/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.37.gtf.gz -P $(ANALYSIS_DIR)/genome
	gunzip -f $(ANALYSIS_DIR)/genome/*.gz


### all

all: \
	init\
	download_genome_data


