nextflow.enable.dsl=2

include { irma_process } from './Modules/nf-core/irma/main.nf'
include { concat_consensus } from './local/get_consensus.nf'
//include { genoflu } from './Modules/nf-core/genoflu/main.nf'
//include { create_nextclade_db } from './modules/create_nextclade_db.nf'
//include { nextclade } from './Modules/nf-core/nextclade/main.nf'
include { blast } from './Modules/nf-core/blast/main.nf'

workflow {
    if (!params.sample_name || !params.database || !params.fastq_r1) {
        error "Please provide --sample_name, --database, and --fastq_r1"
    }

    irma = irma_process(params.sample_name, params.fastq_r1, params.fastq_r2, params.output_dir)
    concat = concat_consensus(irma_process.out.fasta, params.sample_name, params.output_dir)
    //genoflu_result = genoflu(concat, output_dir, params.sample_name)
    //create_db = create_nextclade_db()
    //nextclade_result = nextclade(concat, output_dir, params.sample_name)
    blast_result = blast(concat_consensus.out.consensus, params.database)
}