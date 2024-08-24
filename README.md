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

Este workflow foi desenvolvido para montar e identificar genomas de influenza utilizando ferramentas de bioinformática como IRMA, GenoFLU, Nextclade e BLAST. Implementado com Nextflow, o workflow é modular, permitindo fácil manutenção e execução eficiente das etapas envolvidas no processo. A seguir, são detalhados os componentes e o funcionamento do workflow.

### Estrutura do Workflow

* nextflow.config: Arquivo de configuração que define os parâmetros globais e especificações de execução dos processos, como o número de CPUs para determinadas tarefas.
* main.nf: Script principal que orquestra a execução dos diferentes processos, utilizando canais para passagem de dados entre eles. Inclui os arquivos de processos individuais e define o fluxo de trabalho.
* irma.nf: Script de processo para executar o IRMA (Iterative Refinement Meta-Assembler) a fim de montar os genomas de influenza a partir de arquivos FASTQ. Suporta modos single-end e paired-end.
* genoflu.nf: Script de processo para executar o GenoFLU, que anota os genomas de influenza montados.
* blast.nf: Script de processo para realizar buscas locais usando BLAST, comparando os genomas montados com um banco de dados especificado.
* minimap2.nf: Script de processo para mapear os reads brutos contra o genoma montado.
* mosdepth.nf: Script de processo para gerar métricas de qualidade, cobertura vertical e horizontal.

**Fluxo de Trabalho**
Entrada de Dados: O usuário fornece o nome da amostra, o caminho do banco de dados e os arquivos FASTQ (obrigatórios R1 e opcionalmente R2).

1. Montagem de Genoma com IRMA:
irma.nf: Monta o genoma de influenza a partir dos dados de sequência bruta utilizando o IRMA. Se um arquivo FASTQ R2 for fornecido, o modo paired-end é utilizado; caso contrário, o modo single-end é empregado.
Os genomas montados são concatenados em um único arquivo de consenso.
2. Anotação com GenoFLU:
genoflu.nf: Anota os genomas montados utilizando o GenoFLU, gerando um relatório de anotação.
3. blast.nf: Compara os genomas de consenso com um banco de dados local usando BLAST, gerando um relatório detalhado dos resultados.
Execução do Workflow

## Como rodar o pilpeline

Para executar o workflow, use o comando `Nextflow` abaixo, fornecendo os parâmetros necessários:

### Modo fácil

```bash
nextflow main.nf --input_dir <path/to/fastqfiles>
```

### Modo avançado

```bash
nextflow main.nf --input_dir <path/to/fastqfiles> --database <path/to/database.tar.gz> --env <docker|singularity|conda> --library <paired|single>
```

### Download para dados teste

Arquivos [fastq](https://drive.google.com/drive/folders/1U_h1IRzjcqng0r9RT4hDechW3dxwn7QO?usp=sharing)
**Benefícios do Workflow**

- Modularidade: Cada etapa do processo é definida em arquivos separados, permitindo fácil manutenção e reutilização dos componentes.
- Escalabilidade: Utilização eficiente de recursos computacionais, como especificação de número de CPUs para o processo BLAST.
- Reprodutibilidade: Adoção de Singularity para garantir que as dependências de software sejam consistentes em diferentes execuções e ambientes.
- Flexibilidade: Suporte tanto para dados de sequência single-end quanto paired-end, e a capacidade de adicionar ou modificar processos conforme necessário.

Este workflow é uma solução robusta e eficiente para a montagem e identificação de genomas de influenza, facilitando análises precisas e rápidas em ambientes de pesquisa genômica.
