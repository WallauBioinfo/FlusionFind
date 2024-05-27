import os
import subprocess


def check_and_pull_sif(sif_images, images):
    for sif_image, image in zip(sif_images, images):
        if not os.path.isfile(sif_image):
            print(
                f"Arquivo SIF do Singularity ({sif_image}) não encontrado. Fazendo pull..."
            )
            subprocess.run(
                [
                    "singularity",
                    "pull",
                    "--arch",
                    "amd64",
                    f"library://wallaulabs/flufind/{image}",
                ]
            )


def concatenate_consensus(output_dir, sample_name, consensus_file):
    with open(consensus_file, "w") as outfile:
        for fa in os.listdir(f"{output_dir}/{sample_name}/amended_consensus/"):
            with open(f"{output_dir}/{sample_name}/amended_consensus/{fa}") as infile:
                outfile.write(infile.read())
