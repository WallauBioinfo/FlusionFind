import os
import subprocess


def run_genoflu(consensus_file, sample_name, output_dir):
    print("Executando GenoFLU...")
    os.makedirs(f"{output_dir}/genoflu_output", exist_ok=True)
    subprocess.run(
        [
            "singularity",
            "exec",
            "genoflu_1.2.0.sif",
            "genoflu.py",
            "-f",
            consensus_file,
            "-n",
            f"{output_dir}/genoflu_output/{sample_name}",
        ]
    )
