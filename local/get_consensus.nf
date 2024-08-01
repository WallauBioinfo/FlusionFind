process concat_consensus {
    
    cpus 2
    memory '4 GB'

    input:
    path fasta
    val sample_name
    val output_dir

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_name}_consensus.fasta", emit: consensus

    script:
    """
    cat ${fasta}/*.fa > ${sample_name}_consensus.fasta
    """
}