process fasta2bed {
    
    cpus 2
    memory '4 GB'

    input:
    path consensus
    val sample_name

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_name}.bed", emit: bed

    script:
    """
    cat ${consensus} | awk '\$0 ~ "^>" {name=substr(\$0, 2); printf name"\\t1\\t"} \$0 !~ "^>" {printf length(\$0)"\\t"name"\\n"}' > ${sample_name}.bed
    """
}