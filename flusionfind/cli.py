import click
from .sif_checker import check_and_pull_sif
import os
import subprocess


@click.command()
@click.argument("sample_name")
@click.argument("database")
@click.argument("fastq_r1")
@click.option("--fastq_r2", default=None, help="Arquivo FASTQ R2 (opcional)")
def main(sample_name, database, fastq_r1, fastq_r2):
    """Script para rodar o workflow Nextflow"""

    sif_images = ["irma_1.1.3.sif", "genoflu_1.2.0.sif", "nextclade_3.0.0.sif"]
    images = ["irma:1.1.3", "genoflu:1.2.0", "nextclade:3.0.0"]

    check_and_pull_sif(sif_images, images)

    output_dir = f"flusionfind_{sample_name}"
    os.makedirs(output_dir, exist_ok=True)

    nextflow_command = [
        "nextflow",
        "run",
        "main.nf",
        "--sample_name",
        sample_name,
        "--database",
        database,
        "--fastq_r1",
        fastq_r1,
        "--fastq_r2",
        fastq_r2 if fastq_r2 else "",
        "--output_dir",
        output_dir,
    ]

    subprocess.run(nextflow_command)


if __name__ == "__main__":
    main()
