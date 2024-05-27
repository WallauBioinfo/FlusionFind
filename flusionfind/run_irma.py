import subprocess


def run_irma(sample_name, fastq_r1, fastq_r2, output_dir):
    if fastq_r2:
        print("Executando IRMA modo paired-end...")
        subprocess.run(
            [
                "singularity",
                "exec",
                "irma_1.1.3.sif",
                "IRMA",
                "FLU",
                fastq_r1,
                fastq_r2,
                f"{output_dir}/{sample_name}",
            ]
        )
    else:
        print("Executando IRMA modo single-end...")
        subprocess.run(["IRMA", "FLU", fastq_r1, f"{output_dir}/{sample_name}"])
