import os
import subprocess


def run_blast(consensus_file, database, output_dir):
    print("Executando Blast...")
    os.makedirs(f"{output_dir}/blast_out", exist_ok=True)
    subprocess.run(
        [
            "singularity",
            "exec",
            "genoflu_1.2.0.sif",
            "blastn",
            "-query",
            consensus_file,
            "-db",
            database,
            "-outfmt",
            "6 qseqid sseqid stitle pident length mismatch gapopen qstart qend sstart send evalue bitscore",
            "-max_target_seqs",
            "1",
            "-max_hsps",
            "1",
            "-evalue",
            "1e-25",
            "-num_threads",
            "24",
            ">",
            f"{output_dir}/blast_out/blast_test.txt",
        ],
        shell=True,
    )
