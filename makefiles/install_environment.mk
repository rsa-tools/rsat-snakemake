################################################################
## Create a conda environment to run the workflow

MAKEFILE=makefiles/install_environment.mk
usage:
	@echo "usage: make [-OPT='options'] target"
	@echo "implemented targets"
	@perl -ne 'if (/^([a-z]\S+):/){ print "\t$$1\n";  }' ${MAKEFILE}

conda_create:
	conda create --name rsat-snakemake python=3.6

conda_install:
	(conda activate rsat-snakemake; \
	conda install -c conda-forge pandas=0.24.2; \
	conda install -c bioconda snakemake=5.5.2)

SNAKEFILE=snakefiles/workflows/motifs_analysis.wf
CONFIG=demo_data/config_demo.yml
TARGET=all
OPT=
run_workflow:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} -pk \
		--use-conda ${TARGET} ${OPT}
report:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} \
		all --report workflow_report.html

#		--report workflow_report.html \
#		 --summary --detailed-summary --reason \
#		--stats workflow_stats.json --list-conda-envs \
