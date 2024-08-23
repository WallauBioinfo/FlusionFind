nextflow.enable.dsl=2

// Import modules
include { irma_process } from './Modules/nf-core/irma/main.nf'
// include { concat_consensus } from './local/get_consensus.nf'
// include { genoflu } from './Modules/nf-core/genoflu/main.nf'
// include { blast } from './Modules/nf-core/blast/main.nf'
// include { fasta2bed } from './local/fasta2bed.nf'
// include { minimap2 } from './Modules/nf-core/minimap2/main.nf'
// include { samtools_view } from './Modules/nf-core/samtools/main.nf'
// include { mosdepth_thresholds } from './Modules/nf-core/mosdepth/main.nf'

// Pipe that scans the directory and identifies files R1 and R2
if (params.library == "paired") {
    reads_ch = Channel.fromFilePairs("${params.input_dir}/*_{R1,R2}_*.{fastq,fq}.gz")
} else if (params.library == "single") {
    reads_ch = channel.fromPath("${params.input_dir}/*_{R1}_*.{fastq,fq}.gz").map { it -> tuple([it.baseName.split("_R1_")[0], [it]])}
    } 

// running
workflow {
    if (!params.input_dir || !params.database || !params.env) {
        error "Please provide --input_dir, --database, and --env"
    }

    irma = irma_process(reads_ch, params.output_dir)
    // concat = concat_consensus(irma_process.out.fasta, params.sample_name, params.output_dir)
    // genoflu_result = genoflu(concat_consensus.out.consensus, params.sample_name)
    // blast_result = blast(concat_consensus.out.consensus, params.database, params.sample_name)
    // fastaTobed = fasta2bed(concat_consensus.out.consensus, params.sample_name)
    // minimap2_process = minimap2(concat_consensus.out.consensus, params.fastq_r1, params.fastq_r2)
    // samtools_process = samtools_view(minimap2.out.minimap2_sam)
    // mosdepth_process = mosdepth_thresholds(samtools_view.out.samtools_bam, fasta2bed.out.bed, samtools_view.out.samtools_bam_bai)
}
