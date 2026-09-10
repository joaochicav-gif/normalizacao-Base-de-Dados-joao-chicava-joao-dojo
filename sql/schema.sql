-- =====================================================================
-- TRABALHO II — Normalização de Base de Dados
-- Sistema de Gestão de Funcionários — Universidade Licungo
-- DDL + DML compatível com MySQL / MariaDB
-- =====================================================================

DROP DATABASE IF EXISTS gestao_funcionarios_ul;
CREATE DATABASE gestao_funcionarios_ul
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gestao_funcionarios_ul;

-- ---------------------------------------------------------------------
-- 1. DDL — TABELAS DE REFERÊNCIA (resultado da 3FN)
-- ---------------------------------------------------------------------

CREATE TABLE CIDADE (
    cod_cidade   INT AUTO_INCREMENT PRIMARY KEY,
    nome_cidade  VARCHAR(60)  NOT NULL,
    provincia    VARCHAR(60)  NOT NULL,
    pais         VARCHAR(60)  NOT NULL DEFAULT 'Moçambique',
    UNIQUE KEY uk_cidade_provincia (nome_cidade, provincia)
) ENGINE=InnoDB;

CREATE TABLE CARGO (
    cod_cargo   VARCHAR(5)  PRIMARY KEY,
    nome_cargo  VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE FUNCAO (
    cod_funcao   VARCHAR(5)  PRIMARY KEY,
    nome_funcao  VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE POSTO_TRABALHO (
    cod_posto    INT AUTO_INCREMENT PRIMARY KEY,
    designacao   VARCHAR(100) NOT NULL,
    cod_cidade   INT NOT NULL,
    FOREIGN KEY (cod_cidade) REFERENCES CIDADE(cod_cidade)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE KEY uk_posto (designacao, cod_cidade)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 2. DDL — TABELA PRINCIPAL
-- ---------------------------------------------------------------------

CREATE TABLE FUNCIONARIO (
    id_funcionario  INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    data_nasc       DATE NOT NULL,
    nuit            VARCHAR(9)   NOT NULL UNIQUE,
    bi              VARCHAR(20)  NOT NULL UNIQUE,
    email           VARCHAR(120) NOT NULL UNIQUE,
    via             VARCHAR(120) NOT NULL,
    numero_porta    VARCHAR(10),
    bairro          VARCHAR(80)  NOT NULL,
    cod_cidade      INT NOT NULL,
    cod_cargo       VARCHAR(5)  NOT NULL,
    cod_funcao      VARCHAR(5)  NOT NULL,
    cod_posto       INT NOT NULL,
    data_admissao   DATE NOT NULL,
    FOREIGN KEY (cod_cidade) REFERENCES CIDADE(cod_cidade)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (cod_cargo)  REFERENCES CARGO(cod_cargo)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (cod_funcao) REFERENCES FUNCAO(cod_funcao)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (cod_posto)  REFERENCES POSTO_TRABALHO(cod_posto)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. DDL — TABELAS RESULTANTES DA 4FN (grupos multivalorados isolados)
-- ---------------------------------------------------------------------

CREATE TABLE DEPENDENTE (
    id_dependente    INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario   INT NOT NULL,
    nome_dependente  VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE TELEFONE (
    id_telefone     INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario  INT NOT NULL,
    numero_celular  VARCHAR(15) NOT NULL UNIQUE,
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =====================================================================
-- 4. DML — DADOS DE REFERÊNCIA
-- =====================================================================

INSERT INTO CIDADE (nome_cidade, provincia, pais) VALUES
('Maputo',     'Maputo Cidade',     'Moçambique'),   -- 1
('Matola',     'Maputo Província',  'Moçambique'),   -- 2
('Chókwè',     'Gaza',              'Moçambique'),   -- 3
('Maxixe',     'Inhambane',         'Moçambique'),   -- 4
('Beira',      'Sofala',            'Moçambique'),   -- 5
('Nampula',    'Nampula',           'Moçambique'),   -- 6
('Chimoio',    'Manica',            'Moçambique'),   -- 7
('Tete',       'Tete',              'Moçambique'),   -- 8
('Quelimane',  'Zambézia',          'Moçambique'),   -- 9
('Pemba',      'Cabo Delgado',      'Moçambique');   -- 10

INSERT INTO CARGO (cod_cargo, nome_cargo) VALUES
('C01', 'Técnico de Informática'),
('C02', 'Contabilista'),
('C03', 'Engenheiro Civil'),
('C04', 'Enfermeiro'),
('C05', 'Professor'),
('C06', 'Motorista'),
('C07', 'Gestor de Recursos Humanos'),
('C08', 'Assistente Administrativo');

INSERT INTO FUNCAO (cod_funcao, nome_funcao) VALUES
('F01', 'Tecnologias de Informação'),
('F02', 'Finanças'),
('F03', 'Engenharia'),
('F04', 'Saúde'),
('F05', 'Educação'),
('F06', 'Logística'),
('F07', 'Recursos Humanos'),
('F08', 'Administração');

INSERT INTO POSTO_TRABALHO (designacao, cod_cidade) VALUES
('Sede Maputo',              1),   -- 1
('Delegação Matola',         2),   -- 2
('Delegação Gaza',           3),   -- 3
('Delegação Inhambane',      4),   -- 4
('Delegação Beira',          5),   -- 5
('Delegação Nampula',        6),   -- 6
('Delegação Manica',         7),   -- 7
('Delegação Tete',           8),   -- 8
('Delegação Zambézia',       9),   -- 9
('Delegação Cabo Delgado',   10);  -- 10

-- =====================================================================
-- 5. DML — OS 16 FUNCIONÁRIOS (chave: id_funcionario 1..16, na ordem da tabela 0FN)
-- =====================================================================

INSERT INTO FUNCIONARIO
(nome, data_nasc, nuit, bi, email, via, numero_porta, bairro,
 cod_cidade, cod_cargo, cod_funcao, cod_posto, data_admissao) VALUES
('Amélia Fernanda Cossa',    '1985-03-12', '100234567', '110100123456A', 'amelia.cossa@empresa.co.mz',    'Av. Julius Nyerere',    '245', 'Sommerschield',    1, 'C01', 'F01', 1,  '2015-02-05'),
('Bernardo Alfredo Machava', '1979-07-22', '100345678', '110100234567B', 'bernardo.machava@empresa.co.mz','Rua da Resistência',    '8',   'Polana Caniço B',  1, 'C02', 'F02', 1,  '2010-09-14'),
('Celina Armando Sitoe',     '1990-11-03', '100456789', '110200345678C', 'celina.sitoe@empresa.co.mz',    'Av. Samora Machel',     '12',  'Fomento',          2, 'C08', 'F08', 2,  '2018-06-01'),
('Domingos Paulo Nhantumbo', '1982-01-30', '100567890', '110300456789D', 'domingos.nhantumbo@empresa.co.mz','Rua 3',               '56',  'Chókwè-Sede',      3, 'C06', 'F06', 3,  '2012-03-10'),
('Eugénia Marta Muchanga',   '1988-05-18', '100678901', '110400567890E', 'eugenia.muchanga@empresa.co.mz','Av. Eduardo Mondlane',  '301', 'Maxixe-Sede',      4, 'C04', 'F04', 4,  '2016-08-20'),
('Fernando José Macuácua',   '1975-09-25', '100789012', '110500678901F', 'fernando.macuacua@empresa.co.mz','Av. Poder Popular',    '77',  'Macuti',           5, 'C03', 'F03', 5,  '2008-01-15'),
('Graça Isabel Zunguze',     '1992-12-07', '100890123', '110600789012G', 'graca.zunguze@empresa.co.mz',   'Rua da Frescura',       '19',  'Ponta Gêa',        5, 'C05', 'F05', 5,  '2019-02-02'),
('Hélder António Cuamba',    '1980-04-14', '100901234', '110700890123H', 'helder.cuamba@empresa.co.mz',   'Av. 25 de Setembro',    '150', 'Alto Maé',         1, 'C07', 'F07', 1,  '2011-11-11'),
('Ivete Sara Chirindza',     '1995-06-29', '101012345', '110800901234I', 'ivete.chirindza@empresa.co.mz', 'Rua do Bagamoyo',       '5',   'Muhipiti',         6, 'C01', 'F01', 6,  '2020-07-03'),
('João Baptista Nhaca',      '1978-08-09', '101123456', '110900012345J', 'joao.nhaca@empresa.co.mz',      'Av. Josina Machel',     '200', 'Namahera',         6, 'C02', 'F02', 6,  '2009-05-25'),
('Lúcia Ermelinda Bila',     '1991-02-16', '101234567', '111000123456K', 'lucia.bila@empresa.co.mz',      'Rua da Base',           '33',  'Chaimite',         5, 'C08', 'F08', 5,  '2017-09-19'),
('Marcelino Inácio Tembe',   '1983-10-21', '101345678', '111100234567L', 'marcelino.tembe@empresa.co.mz', 'Av. Kwame Nkrumah',     '410', 'Coop',             1, 'C03', 'F03', 1,  '2013-04-08'),
('Noémia Alzira Massingue',  '1987-03-04', '101456789', '111200345678M', 'noemia.massingue@empresa.co.mz','Rua de Chimoio',        '67',  'Chingussura',      7, 'C04', 'F04', 7,  '2014-12-12'),
('Osvaldo Simião Ubisse',    '1976-07-27', '101567890', '111300456789N', 'osvaldo.ubisse@empresa.co.mz',  'Av. 7 de Setembro',     '90',  'Matundo',          8, 'C06', 'F06', 8,  '2006-10-30'),
('Paulina Fátima Uache',     '1993-01-15', '101678901', '111400567890O', 'paulina.uache@empresa.co.mz',   'Rua da Missão',         '24',  'Chalaua',          9, 'C05', 'F05', 9,  '2021-09-09'),
('Ricardo Manuel Come',      '1981-06-02', '101789012', '111500678901P', 'ricardo.come@empresa.co.mz',    'Av. Franqueza',         '18',  'Chuwaula',         10,'C07', 'F07', 10, '2010-07-17');

-- =====================================================================
-- 6. DML — DEPENDENTES (ex-"Filho 1/2/3", 1:N)
-- =====================================================================

INSERT INTO DEPENDENTE (id_funcionario, nome_dependente) VALUES
(1,  'Cátia Cossa'),
(2,  'Nelson Machava'), (2, 'Ivete Machava'), (2, 'Suzana Machava'),
(4,  'Paulo Nhantumbo Jr'), (4, 'Alzira Nhantumbo'),
(5,  'Marta Muchanga'),
(6,  'José Macuácua'), (6, 'Beatriz Macuácua'), (6, 'Adriano Macuácua'),
(8,  'António Cuamba Jr'), (8, 'Filomena Cuamba'),
(10, 'Baptista Nhaca Jr'),
(11, 'Ermelinda Bila'),
(12, 'Inácio Tembe Jr'), (12, 'Rosa Tembe'),
(14, 'Simião Ubisse Jr'), (14, 'Alcinda Ubisse'), (14, 'Custódio Ubisse'),
(16, 'Manuel Come Jr');

-- =====================================================================
-- 7. DML — TELEFONES (ex-"Celular 1/2/3", 1:N)
-- =====================================================================

INSERT INTO TELEFONE (id_funcionario, numero_celular) VALUES
(1,  '841234567'), (1,  '821234567'),
(2,  '845678901'),
(3,  '861122334'),
(4,  '847890123'), (4,  '878901234'),
(5,  '849012345'),
(6,  '823456789'), (6,  '843456789'), (6, '863456789'),
(7,  '844567890'), (7,  '824567890'),
(8,  '825678901'),
(9,  '846789012'),
(10, '827890123'), (10, '847890124'),
(11, '848901234'),
(12, '829012345'), (12, '849012346'), (12, '869012347'),
(13, '841122334'),
(14, '822233445'), (14, '842233445'),
(15, '843344556'),
(16, '824455667'), (16, '844455667');

-- =====================================================================
-- 8. QUERIES DE DEMONSTRAÇÃO — reconstituição da visão original a partir
--    do esquema normalizado (comprovação de que nenhuma informação da
--    tabela 0FN se perdeu no processo de normalização)
-- =====================================================================

-- 8.1 Reconstituição integral da "ficha de funcionário" (equivalente a
--     uma linha da tabela 0FN original), com filhos e telefones agregados
--     em texto através de sub-queries correlacionadas com GROUP_CONCAT.
SELECT
    f.id_funcionario,
    f.nome,
    f.data_nasc,
    f.nuit,
    f.bi,
    f.email,
    CONCAT(f.via, ', n.º ', f.numero_porta, ', ', f.bairro) AS endereco_completo,
    ci.nome_cidade                                           AS cidade,
    ci.provincia,
    ci.pais,
    ca.nome_cargo                                            AS cargo,
    f.cod_cargo,
    fu.nome_funcao                                            AS funcao,
    f.cod_funcao,
    pt.designacao                                             AS posto_trabalho,
    f.data_admissao,
    (SELECT GROUP_CONCAT(d.nome_dependente SEPARATOR ' | ')
       FROM DEPENDENTE d WHERE d.id_funcionario = f.id_funcionario) AS filhos,
    (SELECT GROUP_CONCAT(t.numero_celular SEPARATOR ' | ')
       FROM TELEFONE t WHERE t.id_funcionario = f.id_funcionario)   AS celulares
FROM FUNCIONARIO f
INNER JOIN CIDADE ci         ON ci.cod_cidade = f.cod_cidade
INNER JOIN CARGO ca          ON ca.cod_cargo  = f.cod_cargo
INNER JOIN FUNCAO fu         ON fu.cod_funcao = f.cod_funcao
INNER JOIN POSTO_TRABALHO pt ON pt.cod_posto  = f.cod_posto
ORDER BY f.id_funcionario;

-- 8.2 Distribuição do quadro de pessoal por cargo e por província
--     (agregação com GROUP BY sobre duas dimensões via JOIN)
SELECT
    ca.nome_cargo,
    ci.provincia,
    COUNT(*) AS total_funcionarios
FROM FUNCIONARIO f
INNER JOIN CARGO ca  ON ca.cod_cargo  = f.cod_cargo
INNER JOIN CIDADE ci ON ci.cod_cidade = f.cod_cidade
GROUP BY ca.nome_cargo, ci.provincia
ORDER BY ca.nome_cargo, ci.provincia;

-- 8.3 Funcionários com mais de um dependente E mais de um contacto
--     telefónico (LEFT JOIN duplo + HAVING sobre contagens distintas)
SELECT
    f.nome,
    COUNT(DISTINCT d.id_dependente) AS num_filhos,
    COUNT(DISTINCT t.id_telefone)   AS num_telefones
FROM FUNCIONARIO f
LEFT JOIN DEPENDENTE d ON d.id_funcionario = f.id_funcionario
LEFT JOIN TELEFONE t   ON t.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome
HAVING num_filhos > 1 AND num_telefones > 1
ORDER BY num_filhos DESC, num_telefones DESC;

-- 8.4 Ocupação de cada posto de trabalho por cidade/província
--     (LEFT JOIN a partir de POSTO_TRABALHO para incluir postos mesmo
--      que, hipoteticamente, ficassem sem funcionários afectos)
SELECT
    pt.designacao,
    ci.nome_cidade,
    ci.provincia,
    COUNT(f.id_funcionario) AS total_funcionarios
FROM POSTO_TRABALHO pt
INNER JOIN CIDADE ci  ON ci.cod_cidade = pt.cod_cidade
LEFT JOIN FUNCIONARIO f ON f.cod_posto = pt.cod_posto
GROUP BY pt.cod_posto, pt.designacao, ci.nome_cidade, ci.provincia
ORDER BY total_funcionarios DESC;
