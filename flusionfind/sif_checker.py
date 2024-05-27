import subprocess
import os


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
