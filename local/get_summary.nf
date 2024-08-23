process get_summary {
    
    cpus 2
    memory '4 GB'

    input:
    tuple val(sample_id), path(reads)
    path blast
    path mosdepth

    publishDir "${params.output_dir}", mode: 'copy', overwrite: false

    output:
    path "${sample_id}.xlsx", emit: bed

    script:
    """
    ls
    python3 ${projectDir}/bin/summary_report.py --blast-file-path ${blast} \\
      --coverage-file-path ${mosdepth} \\
      --output-file ${sample_id}
    """
}