#!/bin/bash
#FlusionFind
#Wilson Jose da Silva

# Função para exibir a mensagem de ajuda
show_help() {
    echo "Uso: $0 <nome_da_amostra> <arquivo_fastq_R1> [arquivo_fastq_R2]"
    echo "Monta genomas de influenza usando IRMA, GenoFLU e Nexclade."
    echo " "
    echo "Argumentos:"
    echo "  nome_da_amostra     Nome da amostra."
    echo "  arquivo_fastq_R1    Arquivo FASTQ R1 (obrigatório)."
    echo "  arquivo_fastq_R2    Arquivo FASTQ R2 (opcional)."
    echo " "
    echo "Exemplo de uso:"
    echo "  $0 minha_amostra meu_arquivo_R1.fastq meu_arquivo_R2.fastq"
    echo "  $0 outra_amostra outro_arquivo_R1.fastq"
}

# Verifica e faz pull dos arquivos SIF do Singularity necessários
check_and_pull_sif() {
    for sif_image in "$@"; do
        if [ ! -f "$sif_image" ]; then
            echo "Arquivo SIF do Singularity ($sif_image) não encontrado. Fazendo pull..."
            singularity pull --arch amd64 library://wallaulabs/flufind/"$sif_image"
        fi
    done
}

# Verifica se o número de argumentos está correto
if [ "$#" -lt 2 ]; then
    show_help
    exit 1
fi

# Lista de arquivos SIF do Singularity necessários
sif_images=("irma_1.1.3.sif" "genoflu_1.2.0.sif")

# Verifica e faz pull dos arquivos SIF necessários
check_and_pull_sif "${sif_images[@]}"

# Nome da amostra
sample_name=$1

# Arquivo FASTQ R1
fastq_r1=$2

# Arquivo FASTQ R2 (se fornecido)
fastq_r2=$3

# Diretório de saída
output_dir="flusionfind_$sample_name"
mkdir -p $output_dir

# Executar o IRMA (se o arquivo FASTQ R2 estiver presente) (Task IRMA)
if [ -n "$fastq_r2" ]; then
    echo "Executando IRMA modo paired-end..."
    singularity exec irma_1.1.3.sif IRMA "FLU" "$fastq_r1" "$fastq_r2" "$output_dir/$sample_name"
else
    echo "Executando IRMA modo single-end..."
    IRMA "FLU" "$fastq_r1" "$output_dir/$sample_name"
fi

## Concantenar o arquivo consenso
cat "$output_dir/$sample_name/amended_consensus/*.fasta > $sample_name"_consensus.fasta"" 
fasta_consensus=$sample_name"_consensus.fasta"

# Verifica que genomas de influenza foram detectados
if [ -e $fasta_consensus ]; then
  echo "Influenza detectado seguindo para anotação."

# Executar o GenoFLU (Task GenoFlu)
  echo "Executando GenoFLU..."
  mkdir -p $output_dir/genoflu_output
  cd $output_dir/genoflu_output
  singularity exec genoflu_1.2.0.sif genoflu.py -f $fasta_consensus > "genoflu.log"
  cd

# Criação do banco de dados do Nexclade (Resourses)
  echo "Criando banco de dados de Influenza"
  nextclade dataset get --name nextstrain/flu/h1n1pdm/ha/CY121680 --output-dir data/Influenza-A
  nexclade_dataset="data/Influenza-A"

# Executar o Nexclade (task Nexclade)
  echo "Executando Nexclade..." 
  nextclade run \
   --input-dataset $nexclade_dataset \
   -O $output_dir/nexclade_output \
   $fasta_consensus

# Finalizando o pipeline
  echo "Processo concluído. Os resultados estão em $output_dir"
else
  echo "Influenza não detectado!"
fi