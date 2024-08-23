import pandas as pd
import click


def read_coverage_results(file_path):
    # Lê o arquivo .gz usando pandas
    df = pd.read_csv(file_path, compression="gzip", sep=r"\s+")

    # Adiciona uma coluna com o tamanho (end - start)
    df["length"] = df["end"] - df["start"]

    # Divide as colunas 10X, 20X e 30X pela coluna length
    df["10X"] = df["10X"] / df["length"] * 100
    df["20X"] = df["20X"] / df["length"] * 100
    df["30X"] = df["30X"] / df["length"] * 100

    # Mapeia as condições da coluna #chrom
    mapping = {
        "_1": "PB1",
        "_2": "PB2",
        "_3": "PA",
        "_4": "HA",
        "_5": "NP",
        "_6": "NB",
        "_7": "M1",
        "_8": "NEP",
    }

    def annotation(chrom_value):
        for key in mapping:
            if key in chrom_value:
                return mapping[key]
        return "Unknown"  # Caso nenhuma condição seja satisfeita

    # Aplica a função de mapeamento à coluna #chrom e cria a nova coluna
    df["annotation"] = df["#chrom"].apply(annotation)

    return df


def read_blast_results(file_path):
    # Lê o arquivo .gz usando pandas
    df = pd.read_csv(file_path, sep=r"\s+")
    return df


def merge_dataframes(df1, df2):
    """
    Merges two DataFrames on the specified key column.

    :param df1: First DataFrame
    :param df2: Second DataFrame
    :param key: Column name to merge on
    :return: Merged DataFrame
    """
    merged_df = pd.merge(
        df1, df2, left_on="Query_sequence_id", right_on="#chrom", how="inner"
    )
    return merged_df


@click.command()
@click.option(
    "--blast-file-path",
    type=click.Path(exists=True),
    required=True,
    help="Path to the blast results file.",
)
@click.option(
    "--coverage-file-path",
    type=click.Path(exists=True),
    required=True,
    help="Path to the coverage results file (gzipped).",
)
@click.option(
    "--output-file",
    type=str,
    default="merged_results.csv",
    help="Filename for the merged results.",
)
def main(blast_file_path, coverage_file_path, output_file):
    # Lê os arquivos
    blast_results_df = read_blast_results(blast_file_path)
    coverage_results_df = read_coverage_results(coverage_file_path)

    # Realiza o merge dos DataFrames na coluna 'query_sequence_id'
    merged_df = merge_dataframes(blast_results_df, coverage_results_df)
    merged_df.to_excel(output_file+".xlsx", index=False)


if __name__ == "__main__":
    main()
