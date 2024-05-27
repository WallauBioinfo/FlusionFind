# FlusionFind

## Product Manager:

**Gabriel Wallau**

## Scrum-master:

****

## Título do projeto:

Flusionfind

## Resumo

Este repositório abriga o FlusionFind, um pipeline para montagem e subtipagem H/N de vírus Influenza A e B a partir de dados de sequenciamento NGS. O vírus da Influenza, devido ao seu genoma segmentado composto por oito segmentos gênicos, requer uma abordagem especializada para a seleção das sequências de referência mais apropriadas. Nosso pipeline realiza automaticamente essa seleção, utilizando o [IRMA](https://wonder.cdc.gov/amd/flu/irma/) para montagem e o [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) de nucleotídeos em todas as sequências do Influenza do NCBI. Além disso, disponibilizamos aos usuários a opção de incluir suas próprias sequências de referência no processo de seleção da sequência principal. Uma vez que a sequência de referência é escolhida, o pipeline conduz o mapeamento de leituras, a chamada de variantes e a geração da sequência de consenso, incorporando máscaras de profundidade conforme necessário. Essa abordagem torna a análise de vírus Influenza mais eficiente e adaptável, fornecendo resultados precisos e personalizados para pesquisadores e profissionais de saúde.

## FlusionFind

FlusionFind é uma ferramenta para montar genomas de influenza usando IRMA, GenoFLU e Nexclade.

### Uso

```bash
flusionfind <nome_da_amostra> <database> <arquivo_fastq_R1> [arquivo_fastq_R2]
```

#### Argumentos

* nome_da_amostra: Nome da amostra.
* path_do_database: PATH do database.
* arquivo_fastq_R1: Arquivo FASTQ R1 (obrigatório).
* arquivo_fastq_R2: Arquivo FASTQ R2 (opcional).

#### Exemplo de uso

```bash
flusionfind minha_amostra meu_arquivo_R1.fastq meu_arquivo_R2.fastq
```

```bash
flusionfind outra_amostra outro_arquivo_R1.fastq
```

### Instalação

```bash
pip install .
```
