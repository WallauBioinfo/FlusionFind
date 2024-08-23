process fasta2bed {
    
    cpus 2
    memory '4 GB'

    input:
    tuple val(sample_id), path(reads)
    path consensus

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}.bed", emit: bed

    script:
    """
    cat ${consensus} \\
    | awk '\$0 ~ "^>" {name=substr(\$0, 2); printf name"\\t1\\t"} \$0 !~ "^>" {printf length(\$0)"\\t"name"\\n"}' \\
    > ${sample_id}.bed
    """
}