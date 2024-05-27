import subprocess


def run_nextclade(consensus_file, output_dir):
    print("Criando banco de dados de Influenza")
    subprocess.run(
        [
            "singularity",
            "exec",
            "nextclade_3.0.0.sif",
            "nextclade",
            "dataset",
            "get",
            "--name",
            "nextstrain/flu/h1n1pdm/ha/CY121680",
            "--output-dir",
            "data/Influenza-A",
        ]
    )
    nextclade_dataset = "data/Influenza-A"

    print("Executando Nextclade...")
    subprocess.run(
        [
            "singularity",
            "exec",
            "nextclade_3.0.0.sif",
            "nextclade",
            "run",
            "--input-dataset",
            nextclade_dataset,
            "-O",
            f"{output_dir}/nextclade_output",
            consensus_file,
        ]
    )
