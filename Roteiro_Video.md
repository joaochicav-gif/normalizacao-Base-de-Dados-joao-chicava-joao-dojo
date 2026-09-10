# Roteiro do Vídeo Explicativo (YouTube, 8–9 minutos)

**Trabalho II — Normalização de Base de Dados — Sistema de Gestão de Funcionários**

> Instruções gerais: gravar o ecrã com o documento, o diagrama Mermaid e o terminal/MySQL Workbench abertos; falar de forma pausada e clara; publicar como "não listado" e colocar o link no Google Classroom junto ao link do repositório GitHub.

---

**00:00 – 00:40 | Abertura**
Apresentar-se pelo nome completo, número de estudante, curso (Licenciatura em Informática) e disciplina (Tecnologias de Base de Dados, docente Daniel Berequeto Gimo). Anunciar o título do trabalho e o objetivo do vídeo: mostrar o processo completo de normalização de 0FN até 4FN.

**00:40 – 01:30 | Contexto do problema**
Mostrar a tabela `Dados_Não_Normalizados_Funcionários` (0FN) no ecrã. Explicar o cenário: uma empresa moçambicana com 16 funcionários registados numa única folha de cálculo, com dados pessoais, morada, dados profissionais, filhos e telefones.

**01:30 – 03:00 | Anomalias identificadas**
Apontar no ecrã, com exemplos concretos do documento:
- O campo Endereço não atómico (via + número + bairro).
- Os grupos repetitivos Filho 1-3 e Celular 1-3, com células vazias.
- Um exemplo de anomalia de inserção (não é possível criar um cargo novo sem funcionário), um de atualização (código C01 repetido em duas linhas) e um de remoção (perda da informação da Delegação de Nampula).

**03:00 – 05:00 | Processo de normalização passo a passo**
Para cada forma normal (1FN, 2FN, 3FN, 4FN), mostrar no documento: a regra teórica, a ação aplicada e o esquema relacional resultante. Destacar visualmente a extração das entidades CARGO, FUNÇÃO, CIDADE e POSTO_TRABALHO na 3FN, e a separação de DEPENDENTE e TELEFONE (4FN) para evitar o produto cartesiano espúrio.

**05:00 – 06:00 | Cardinalidades e Modelo ER**
Mostrar a tabela de cardinalidades (todas 1:N) e explicar rapidamente a regra de negócio de uma delas (ex. Funcionário → Dependente). Mostrar o diagrama Mermaid renderizado no GitHub.

**06:00 – 06:30 | Ferramenta usada para o Modelo ER**
Indicar e justificar em 1-2 frases qual ferramenta foi usada para a versão final do diagrama (dbdiagram.io ou draw.io) e onde o ficheiro exportado está guardado no repositório (`diagramas/`).

**06:30 – 08:00 | Demonstração do esquema em funcionamento**
No MySQL Workbench ou terminal: correr `schema.sql`, mostrar as tabelas criadas (`SHOW TABLES;`), mostrar os dados inseridos numa tabela (ex. `SELECT * FROM FUNCIONARIO LIMIT 5;`) e correr a query 8.1 (reconstituição integral) para provar que a visão original é recuperável a partir do esquema normalizado. Correr rapidamente mais uma das queries (8.2 ou 8.3).

**08:00 – 08:45 | Conclusão**
Resumir em 2-3 frases o que foi aprendido (eliminação de redundância, prevenção de anomalias, ganho de integridade referencial) e confirmar que todos os artefactos (documento, diagrama, script SQL, README) estão publicados no repositório GitHub indicado no Google Classroom.

**08:45 – 09:00 | Encerramento**
Agradecer e terminar a gravação.
