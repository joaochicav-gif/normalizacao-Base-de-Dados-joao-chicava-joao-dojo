# Normalização de Base de Dados — Sistema de Gestão de Funcionários

Trabalho II da disciplina de **Tecnologias de Base de Dados**, Curso de Licenciatura em Informática, Faculdade de Ciências e Tecnologias, **Universidade Licungo** (Docente: Daniel Berequeto Gimo).

## Descrição do projeto

Uma empresa moçambicana mantinha todos os dados dos seus funcionários numa única folha de cálculo (16 registos), gerando redundância e anomalias de inserção, atualização e remoção. Este repositório documenta a análise dessa tabela não normalizada (0FN) e a aplicação, passo a passo, do processo de normalização até à **4.ª Forma Normal**, culminando num modelo relacional bem desenhado, com script SQL funcional e queries que comprovam a reconstituição integral da informação original.

## Estrutura de pastas

```
.
├── README.md                          # este ficheiro
├── documentos/
│   ├── 01_Analise_Normalizacao.md     # anomalias, 1FN→4FN, cardinalidades, MER
│   └── Roteiro_Video.md               # guião minuto a minuto do vídeo explicativo
├── diagramas/
│   └── mer.png                        # exportação do Modelo Entidade-Relacionamento
└── sql/
    └── schema.sql                     # DDL + DML + queries de reconstituição
```

## Conteúdo por documento

- **`documentos/01_Analise_Normalizacao.md`** — Secção 1: anomalias e dependências funcionais/transitivas/multivaloradas do 0FN. Secção 2: regra teórica, ações e esquema resultante de cada forma normal (1FN a 4FN). Secção 3: tabela de cardinalidades e regras de negócio. Secção 4: MER em Mermaid, notação relacional formal e diagrama em bloco.
- **`sql/schema.sql`** — `CREATE DATABASE`/`CREATE TABLE` para as 7 tabelas finais (`CIDADE`, `CARGO`, `FUNCAO`, `POSTO_TRABALHO`, `FUNCIONARIO`, `DEPENDENTE`, `TELEFONE`), com `PRIMARY KEY`, `FOREIGN KEY` (`ON DELETE CASCADE` onde aplicável), `UNIQUE` (NUIT, BI, Email) e `NOT NULL`; população completa com os 16 funcionários; e 4 queries de demonstração com `JOIN`, `GROUP_CONCAT` e agregação.
- **`diagramas/mer.png`** — versão exportada do diagrama incluído em Mermaid no documento de análise.

## Como consultar / executar

1. Ler `documentos/01_Analise_Normalizacao.md` para o raciocínio completo de normalização (o diagrama Mermaid renderiza automaticamente na visualização do GitHub).
2. Importar `sql/schema.sql` num SGBD MySQL/MariaDB:
   ```bash
   mysql -u root -p < sql/schema.sql
   ```
3. Correr as queries da secção 8 do script (já incluídas no ficheiro) para verificar a reconstituição da tabela original a partir do esquema normalizado.

## Ferramentas sugeridas

- **Modelo ER:** [dbdiagram.io](https://dbdiagram.io) (a partir da notação relacional do documento) ou [draw.io / diagrams.net](https://app.diagrams.net)
- **Base de dados:** MySQL Workbench ou linha de comandos `mysql`
- **Diagramas embutidos:** Mermaid (suportado nativamente na pré-visualização Markdown do GitHub)

## Instruções de submissão (conforme enunciado do docente)

1. Criar este repositório como **público** no GitHub, com o nome `normalizacao-bd-joao-chicava-joao-dojo`.
2. Confirmar que a estrutura de pastas acima (`documentos/`, `diagramas/`, `sql/`, `README.md`) está publicada no repositório.
3. Gravar o vídeo explicativo (5–10 min, ver `documentos/Roteiro_Video.md`) e publicá-lo no YouTube como **"não listado"**.
4. Submeter no Google Classroom, na tarefa correspondente: (a) o link do repositório GitHub; (b) o link do vídeo do YouTube.

## Autor

João Chicava João Dojo — Curso de Licenciatura em Informática, Universidade Licungo

## Licença

Trabalho académico produzido no âmbito da disciplina de Tecnologias de Base de Dados (UniLicungo). Uso livre para fins educativos, com atribuição.
