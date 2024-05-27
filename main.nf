#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.sample_name = 'minha_amostra'
params.database = 'path_do_database'
params.fastq_r1 = file('meu_arquivo_R1.fastq')
params.fastq_r2 = file('meu_arquivo_R2.fastq')
params.output_dir = "flusionfind_$params.sample_name"

workflow {
    sif_images = ["irma_1.1.3.sif", "genoflu_1.2.0.sif", "nextclade_3.0.0.sif"]
    images = ["irma:1.1.3", "genoflu:1.2.0", "nextclade:3.0.0"]

    include { CHECK_AND_PULL_SIF } from './processes/check_and_pull_sif.nf'
    include { RUN_IRMA } from './processes/run_irma.nf'
    include { RUN_GENOFLU } from './processes/run_genoflu.nf'
    include { CREATE_NEXCLADE_DB } from './processes/create_nexclade_db.nf'
    include { RUN_NEXCLADE } from './processes/run_nexclade.nf'
    include { RUN_BLAST } from './processes/run_blast.nf'

    CHECK_AND_PULL_SIF(sif_images)
    RUN_IRMA(params.sample_name, params.fastq_r1, params.fastq_r2, params.output_dir)
    RUN_GENOFLU(RUN_IRMA.fasta_consensus, params.output_dir, params.sample_name)
    CREATE_NEXCLADE_DB()
    RUN_NEXCLADE(RUN_IRMA.fasta_consensus, CREATE_NEXCLADE_DB.nextclade_dataset, params.output_dir)
    RUN_BLAST(RUN_IRMA.fasta_consensus, params.database, params.output_dir)
}
