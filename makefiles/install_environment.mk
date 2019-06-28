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
CONFIG=snakefiles/workflows/motifs_analysis_config.yaml
TARGET=all
OPT=
run_workflow:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} -p -k --reason \
		--use-conda ${TARGET} ${OPT}

report:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} \
		all --report workflow_report.html

dag:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} \
		all --dag > workflow_dag.dot
	dot -Tpdf workflow_dag.dot > workflow_dag.pdf
	dot -Tpng workflow_dag.dot > workflow_dag.png

rulegraph:
	snakemake -s ${SNAKEFILE} --configfile ${CONFIG} \
		all --rulegraph > workflow_rulegraph.dot
	dot -Rpdf workflow_rulegraph.dot > workflow_rulegraph.pdf
	dot -Rpbg workflow_rulegraph.dot > workflow_rulegraph.png


#		 --detailed-summary > workflow_detailed-summary.txt 
#		--stats workflow_stats.json --list-conda-envs \
