#!/bin/bash

# Função para exibir a mensagem de ajuda
show_help() {
    echo "Uso: $0 <arquivo_multifasta> <nome_do_banco>"
    echo "Este script cria um banco de dados BLAST a partir de um arquivo multifasta."
    echo "Argumentos:"
    echo "  <arquivo_multifasta>: O arquivo multifasta contendo as sequências"
    echo "  <nome_do_banco>: Nome desejado para o banco de dados BLAST"
    echo "Exemplo:"
    echo "  $0 sequencias.fasta meu_banco"
}

# Verifica se o número correto de argumentos foi fornecido
if [ "$#" -ne 2 ]; then
    show_help
    exit 1
fi

# Atribui os argumentos a variáveis
arquivo_multifasta=$1
nome_do_banco=$2

# Verifica se o primeiro argumento é a opção de ajuda
if [ "$arquivo_multifasta" == "-h" ] || [ "$arquivo_multifasta" == "--help" ]; then
    mostrar_ajuda
    exit 0
fi

# Verifica se o arquivo multifasta existe
if [ ! -f "$arquivo_multifasta" ]; then
    echo "Erro: Arquivo multifasta '$arquivo_multifasta' não encontrado."
    exit 1
fi

# Verifica se o formato do arquivo multifasta é válido
if ! grep -q "^>" "$arquivo_multifasta"; then
    echo "Erro: O arquivo multifasta parece estar em um formato inválido."
    exit 1
fi

# Cria o banco de dados usando o formato makeblastdb
makeblastdb -in "$arquivo_multifasta" -dbtype nucl -out "$nome_do_banco"

# Verifica se a criação do banco de dados foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Banco de dados '$nome_do_banco' criado com sucesso."
else
    echo "Erro ao criar o banco de dados '$nome_do_banco'."
fi
