process concat_consensus {
    
    cpus 2
    memory '4 GB'

    input:
    tuple val(sample_id), path(reads)
    path fasta
    val output_dir

    publishDir "${params.output_dir}/${sample_id}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}_consensus.fasta", emit: consensus

    script:
    """
    cat ${fasta}/*.fa > ${sample_id}_consensus.fasta
    """
}