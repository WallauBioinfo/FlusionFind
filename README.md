# FlusionFind

## Product Manager:

**Gabriel Wallau**

## Scrum-master:

****

## Título do projeto:


## Resumo
Este repositório abriga o FlusionFind, um pipeline para montagem e subtipagem H/N de vírus Influenza A e B a partir de dados de sequenciamento NGS. O vírus da Influenza, devido ao seu genoma segmentado composto por oito segmentos gênicos, requer uma abordagem especializada para a seleção das sequências de referência mais apropriadas. Nosso pipeline realiza automaticamente essa seleção, utilizando o [IRMA](https://wonder.cdc.gov/amd/flu/irma/) para montagem e o [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) de nucleotídeos em todas as sequências do Influenza do NCBI. Além disso, disponibilizamos aos usuários a opção de incluir suas próprias sequências de referência no processo de seleção da sequência principal. Uma vez que a sequência de referência é escolhida, o pipeline conduz o mapeamento de leituras, a chamada de variantes e a geração da sequência de consenso, incorporando máscaras de profundidade conforme necessário. Essa abordagem torna a análise de vírus Influenza mais eficiente e adaptável, fornecendo resultados precisos e personalizados para pesquisadores e profissionais de saúde.
