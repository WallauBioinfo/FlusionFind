#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.sample_name = params.sample_name ?: error('Sample name not specified')
params.database = params.database ?: './database/database'
params.fastq_r1 = params.fastq_r1 ?: error('FASTQ R1 file not specified')

include { irma } from '.Modules/irma/main.nf'
include { genoflu } from '.Modules/genoflu/main.nf'
include { nextclade } from '.Modules/nextclade/main.nf'
include { blast } from '.Modules/blast/main.nf'

workflow {
    channel.fromPath(params.fastq_r1) \
        .set { fastq_r1_ch }

    if (params.fastq_r2) {
        channel.fromPath(params.fastq_r2) \
            .set { fastq_r2_ch }
    }

    irma_output = irma(single_end: !params.fastq_r2, fastq_r1: fastq_r1_ch, fastq_r2: params.fastq_r2 ? fastq_r2_ch : null)
    genoflu_output = genoflu(input_fasta: irma_output.out.fasta_consensus)
    nextclade_output = nextclade(input_fasta: genoflu_output.out.fasta_consensus)
    blast_output = blast(input_fasta: nextclade_output.out.fasta_consensus, database: params.database)
}
