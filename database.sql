DROP DATABASE IF EXISTS PORTAL;

CREATE DATABASE IF NOT EXISTS PORTAL;

USE PORTAL;

-- 
-- 
-- 
--  CRIAÇÕES DE TABELAS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 
-- 
-- 

CREATE TABLE IF NOT EXISTS `TBL_LOGRADOUROS`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    LOGRADOURO VARCHAR(100),
    LOGRADOURO_NUMERO INT,
    COMPLEMENTO VARCHAR(200),
    BAIRRO VARCHAR(50),
    CIDADE VARCHAR(50),
    ESTADO VARCHAR(50),
    PAIS VARCHAR(30),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_ALUNOS`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_STATUS VARCHAR(50) NOT NULL,
    MATRICULA VARCHAR(7) NOT NULL,
    NOME VARCHAR(200) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    CELULAR VARCHAR(20),
    PERFIL_DESCRICAO TEXT,
    ID_LOGRADOURO INT,
    FOREIGN KEY (ID_LOGRADOURO) REFERENCES TBL_LOGRADOUROS(ID),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_PROFESSORES`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_STATUS VARCHAR(50) NOT NULL,
    MATRICULA VARCHAR(7) NOT NULL,
    NOME VARCHAR(200) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    CELULAR VARCHAR(20),
    PERFIL_DESCRICAO TEXT,
    ID_LOGRADOURO INT,
    FOREIGN KEY (ID_LOGRADOURO) REFERENCES TBL_LOGRADOUROS(ID),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_ADM`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USER_STATUS VARCHAR(50) NOT NULL,
    NOME VARCHAR(200) NOT NULL,
    CELULAR VARCHAR(20),
    PERFIL_DESCRICAO TEXT,
    ID_LOGRADOURO INT,
    FOREIGN KEY (ID_LOGRADOURO) REFERENCES TBL_LOGRADOUROS(ID),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_DISCIPLINAS`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NOME_DISCIPLINA VARCHAR(100) NOT NULL,
    DESCRICAO TEXT,
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_CALENDARIO_DISCIPLINAS`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    STATUS_DISCIPLINA VARCHAR(100) NOT NULL,
    ANO DATE NOT NULL,
    SEMESTRE INT NOT NULL,
    HORARIO_INICIO TIME NOT NULL,
    HORARIO_FINAL TIME NOT NULL,
    DIAS TEXT NOT NULL,
    DATA_INICIO DATE NOT NULL,
    DATA_FINAL DATE NOT NULL,
    CH INT NOT NULL,
    ID_DISCIPLINA INT NOT NULL, 
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES TBL_DISCIPLINAS(ID),
    ID_PROFESSOR INT NOT NULL,
    FOREIGN KEY (ID_PROFESSOR) REFERENCES TBL_PROFESSORES(ID),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_CONVITE`(
    HASH_CONVITE varchar(500) PRIMARY KEY NOT NULL,
    ID_DISCIPLINA INT NOT NULL,
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES TBL_CALENDARIO_DISCIPLINAS(ID),
    INSCRIPTION_COUNTING INT,
    TOTAL_PEOPLE INT,
    EXPIRATION_DATE DATE,
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_CALENDARIO_ALUNOS`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    STATUS_DISCIPLINA VARCHAR(100) NOT NULL,
    NOTA TEXT,
    ID_ALUNO INT NOT NULL,
    FOREIGN KEY (ID_ALUNO) REFERENCES TBL_ALUNOS(ID),
    ID_DISCIPLINA INT NOT NULL,
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES TBL_CALENDARIO_DISCIPLINAS(ID),
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

CREATE TABLE IF NOT EXISTS `TBL_LOGIN`(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    EMAIL VARCHAR(200) NOT NULL,
    PASSWORD_LOGIN TEXT NOT NULL,
    TYPE_USER VARCHAR(10) NOT NULL,
    ID_USER INT NOT NULL,
    COOKIE_SESSION TEXT,
    LOG_COOKIE_UPDATE DATETIME,
    LOG_INSERT DATETIME NOT NULL,
    LOG_UPDATE DATETIME
);

-- 
-- 
-- 
--  CRIAÇÕES DE VIEWS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 
-- 
-- 

DROP VIEW IF EXISTS `VIEW_ALUNOS`;
CREATE VIEW `VIEW_ALUNOS` AS
    SELECT 
        `ALUNO`.ID AS `ID`, 
        `ALUNO`.NOME AS `NOME`,
        `ALUNO`.CPF AS `CPF`,
        `ALUNO`.CELULAR AS `CELULAR`,
        `ALUNO`.PERFIL_DESCRICAO AS `PERFIL_DESCRICAO`,
        `ALUNO`.ID_LOGRADOURO AS `ID_LOGRADOURO`,
        `LOGIN`.EMAIL AS `EMAIL`, 
        `LOGIN`.PASSWORD_LOGIN AS `PASSWORD`, 
        `LOGIN`.COOKIE_SESSION AS `COOKIE_SESSION`, 
        `LOGIN`.LOG_COOKIE_UPDATE AS `COOKIE_UPDATE`,
        `ALUNO`.LOG_INSERT AS `ALUNO_LOG_INSERT`,
        `ALUNO`.LOG_UPDATE AS `ALUNO_LOG_UPDATE`,
        `LOGIN`.LOG_INSERT AS `LOGIN_LOG_CREATE`,
        `LOGIN`.LOG_UPDATE AS `LOGIN_LOG_UPDATE`
    FROM `TBL_LOGIN` AS `LOGIN`
    INNER JOIN `TBL_ALUNOS` AS `ALUNO` ON `LOGIN`.ID_USER = `ALUNO`.ID AND `LOGIN`.TYPE_USER = 'ALUNO';


DROP VIEW IF EXISTS `VIEW_PROFESSOR`;
CREATE VIEW `VIEW_PROFESSOR` AS
    SELECT 
        `PROFESSOR`.ID AS `ID`, 
        `PROFESSOR`.NOME AS `NOME`,
        `PROFESSOR`.CPF AS `CPF`,
        `PROFESSOR`.CELULAR AS `CELULAR`,
        `PROFESSOR`.PERFIL_DESCRICAO AS `PERFIL_DESCRICAO`,
        `PROFESSOR`.ID_LOGRADOURO AS `ID_LOGRADOURO`,
        `LOGIN`.EMAIL AS `EMAIL`,
        `LOGIN`.PASSWORD_LOGIN AS `PASSWORD`,
        `LOGIN`.COOKIE_SESSION AS `COOKIE_SESSION`,
        `LOGIN`.LOG_COOKIE_UPDATE AS `COOKIE_UPDATE`,
        `PROFESSOR`.LOG_INSERT AS `PROFESSOR_LOG_INSERT`,
        `PROFESSOR`.LOG_UPDATE AS `PROFESSOR_LOG_UPDATE`,
        `LOGIN`.LOG_INSERT AS `LOGIN_LOG_CREATE`,
        `LOGIN`.LOG_UPDATE AS `LOGIN_LOG_UPDATE`
    FROM `TBL_LOGIN` AS LOGIN
    INNER JOIN `TBL_PROFESSORES` AS `PROFESSOR` ON `LOGIN`.ID_USER = `PROFESSOR`.ID AND `LOGIN`.TYPE_USER = 'PROFESSOR';


DROP VIEW IF EXISTS `VIEW_ADM`;
CREATE VIEW `VIEW_ADM` AS
    SELECT 
        `ADM`.ID AS `ID`, 
        `ADM`.NOME AS `NOME`,
        `ADM`.CELULAR AS `CELULAR`,
        `ADM`.PERFIL_DESCRICAO AS `PERFIL_DESCRICAO`,
        `ADM`.ID_LOGRADOURO AS `ID_LOGRADOURO`,
        `LOGIN`.EMAIL AS `EMAIL`, 
        `LOGIN`.PASSWORD_LOGIN AS `PASSWORD`,
        `LOGIN`.COOKIE_SESSION AS `COOKIE_SESSION`,
        `LOGIN`.LOG_COOKIE_UPDATE AS `COOKIE_UPDATE`,
        `ADM`.LOG_INSERT AS `ADM_LOG_INSERT`,
        `ADM`.LOG_UPDATE AS `ADM_LOG_UPDATE`,
        `LOGIN`.LOG_INSERT AS `LOGIN_LOG_CREATE`,
        `LOGIN`.LOG_UPDATE AS `LOGIN_LOG_UPDATE`
    FROM `TBL_LOGIN` AS `LOGIN`
    INNER JOIN `TBL_ADM` AS `ADM` ON `LOGIN`.ID_USER = `ADM`.ID AND `LOGIN`.TYPE_USER = 'ADM';


DROP VIEW IF EXISTS `VIEW_CALENDARIO_DISCIPLINAS`;
CREATE VIEW `VIEW_CALENDARIO_DISCIPLINAS` AS
    SELECT 
        `CALENDARIO_DISCIPLINAS`.ID AS `ID`,
        `DISCIPLINAS`.NOME_DISCIPLINA AS `NOME_DISCIPLINA`,
        `PROFESSOR`.NOME AS `NOME_PROFESSOR`,
        `CALENDARIO_DISCIPLINAS`.STATUS_DISCIPLINA AS `STATUS_DISCIPLINA`,
        `CALENDARIO_DISCIPLINAS`.ANO AS `ANO_APLICACAO`,
        `CALENDARIO_DISCIPLINAS`.SEMESTRE AS `SEMESTRE_ANO`,
        `CALENDARIO_DISCIPLINAS`.HORARIO_INICIO AS `HORARIO_INICIO`,
        `CALENDARIO_DISCIPLINAS`.HORARIO_FINAL AS `HORARIO_FINAL`,
        `CALENDARIO_DISCIPLINAS`.DIAS AS `DIAS_SEMANAIS`,
        `CALENDARIO_DISCIPLINAS`.DATA_INICIO AS `DATA_INICIO`,
        `CALENDARIO_DISCIPLINAS`.DATA_FINAL AS `DATA_FINAL`,
        `CALENDARIO_DISCIPLINAS`.CH AS `CARGA_HORARIA`,
        `CALENDARIO_DISCIPLINAS`.LOG_INSERT AS `LOG_INSERT`,
        `CALENDARIO_DISCIPLINAS`.LOG_UPDATE AS `LOG_UPDATE`
    FROM `TBL_CALENDARIO_DISCIPLINAS` AS `CALENDARIO_DISCIPLINAS`
    INNER JOIN `TBL_DISCIPLINAS` AS `DISCIPLINAS` ON `CALENDARIO_DISCIPLINAS`.ID_DISCIPLINA = `DISCIPLINAS`.ID
    INNER JOIN `TBL_PROFESSORES` AS `PROFESSOR` ON `CALENDARIO_DISCIPLINAS`.ID_PROFESSOR = `PROFESSOR`.ID;


DROP VIEW IF EXISTS `VIEW_CALENDARIO_ALUNOS`;
CREATE VIEW `VIEW_CALENDARIO_ALUNOS` AS
    SELECT 
        `CALENDARIO_ALUNO`.ID AS `ID`,
        `CALENDARIO_ALUNO`.ID_ALUNO AS `ID_ALUNO`,
        `CALENDARIO_DISCIPLINA`.ID AS `ID_CALENDARIO_DISCIPLINA`,
        `CALENDARIO_ALUNO`.STATUS_DISCIPLINA AS `STATUS`,
        `DISCIPLINA`.NOME_DISCIPLINA AS `NOME_DISCIPLINA`,
        `DISCIPLINA`.DESCRICAO AS `DESCRICAO_DISCIPLINA`,
        `CALENDARIO_ALUNO`.NOTA AS `NOTA`,
        `CALENDARIO_ALUNO`.LOG_INSERT AS `LOG_INSERT`,
        `CALENDARIO_ALUNO`.LOG_UPDATE AS `LOG_UPDATE`
    FROM `TBL_CALENDARIO_ALUNOS` AS `CALENDARIO_ALUNO`
    INNER JOIN `TBL_CALENDARIO_DISCIPLINAS` AS `CALENDARIO_DISCIPLINA` ON `CALENDARIO_ALUNO`.ID_DISCIPLINA = `CALENDARIO_DISCIPLINA`.ID
    INNER JOIN `TBL_DISCIPLINAS` AS `DISCIPLINA` ON `CALENDARIO_DISCIPLINA`.ID_DISCIPLINA = `DISCIPLINA`.ID;



-- 
-- 
-- 
--  CRIAÇÕES DE PROCEDURES ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 
-- 
-- 

DELIMITER $$

DROP PROCEDURE IF EXISTS `P_NEW_ALUNO`;
CREATE PROCEDURE `P_NEW_ALUNO` (
	IN P_EMAIL VARCHAR(200),
	IN P_PASSWORD TEXT,
	IN P_COOKIE_SESSION TEXT,
	IN P_NOME VARCHAR(200),
	IN P_CPF VARCHAR(14),
	IN P_MATRICULA VARCHAR(7)
)BEGIN
	INSERT INTO `TBL_ALUNOS` (USER_STATUS, MATRICULA, NOME, CPF, LOG_INSERT)
    VALUES('CADASTRADO', P_MATRICULA, P_NOME, P_CPF, NOW());

    SET @ID_ALUNO = LAST_INSERT_ID();
    
    INSERT INTO `TBL_LOGIN` (EMAIL, PASSWORD_LOGIN, TYPE_USER, ID_USER, COOKIE_SESSION, LOG_COOKIE_UPDATE, LOG_INSERT)
    VALUES(P_EMAIL, P_PASSWORD, 'ALUNO', @ID_ALUNO, P_COOKIE_SESSION, NOW(), NOW());

    SELECT * FROM VIEW_ALUNOS WHERE ID = @ID_ALUNO;
END;

DROP PROCEDURE IF EXISTS `P_NEW_PROFESSOR`;
CREATE PROCEDURE `P_NEW_PROFESSOR` (
	IN P_EMAIL VARCHAR(200),
	IN P_PASSWORD TEXT,
	IN P_COOKIE_SESSION TEXT,
	IN P_NOME VARCHAR(200),
	IN P_CPF VARCHAR(14),
	IN P_MATRICULA VARCHAR(7)
)BEGIN
	INSERT INTO `TBL_PROFESSORES` (USER_STATUS, MATRICULA, NOME, CPF, LOG_INSERT)
    VALUES('CADASTRADO', P_MATRICULA, P_NOME, P_CPF, NOW());
    
    INSERT INTO TBL_LOGIN(EMAIL, PASSWORD_LOGIN, TYPE_USER, ID_USER, COOKIE_SESSION, LOG_COOKIE_UPDATE, LOG_INSERT)
    VALUES(P_EMAIL, P_PASSWORD, 'PROFESSOR', LAST_INSERT_ID(), P_COOKIE_SESSION, NOW(), NOW());
END;

DROP PROCEDURE IF EXISTS `P_NEW_ADM`;
CREATE PROCEDURE `P_NEW_ADM` (
	IN P_EMAIL VARCHAR(200),
	IN P_PASSWORD TEXT,
	IN P_COOKIE_SESSION TEXT,
	IN P_NOME VARCHAR(200)
)BEGIN
    INSERT INTO `TBL_ADM` (USER_STATUS, NOME, LOG_INSERT)
    VALUES('ATIVO', P_NOME, NOW());

    INSERT INTO `TBL_LOGIN` (EMAIL, PASSWORD_LOGIN, TYPE_USER, ID_USER, COOKIE_SESSION, LOG_COOKIE_UPDATE, LOG_INSERT)
    VALUES(P_EMAIL, P_PASSWORD, 'ADM', LAST_INSERT_ID(), P_COOKIE_SESSION, NOW(), NOW());
END;

DROP PROCEDURE IF EXISTS `P_NEW_DISCIPLINA`;
CREATE PROCEDURE `P_NEW_DISCIPLINA` (
	IN P_HASH_CONVITE VARCHAR(500),
    IN P_QUANTIDADE_CONVITES INT,
    IN P_EXPIRACAO_CONTIVE DATE,
    IN P_ANO_DISCIPLINA DATE,
    IN P_SEMESTRE_DISCIPLINA INT,
    IN P_HORARIO_INICIO TIME,
    IN P_HORARIO_FINAL TIME,
    IN P_CH INT,
    IN P_DIAS TEXT,
    IN P_DATA_INICIO DATE,
    IN P_DATA_FINAL DATE,
    IN P_ID_DISCIPLINA INT,
    IN P_ID_PROFESSOR INT
)BEGIN
    INSERT INTO `TBL_CALENDARIO_DISCIPLINAS` (STATUS_DISCIPLINA, ANO, SEMESTRE, HORARIO_INICIO, HORARIO_FINAL, DIAS, DATA_INICIO, DATA_FINAL, CH, ID_DISCIPLINA, ID_PROFESSOR, LOG_INSERT)
    VALUES('CADASTRADA', P_ANO_DISCIPLINA, P_SEMESTRE_DISCIPLINA, P_HORARIO_INICIO, P_HORARIO_FINAL, P_DIAS, P_DATA_INICIO, P_DATA_FINAL, P_CH, P_ID_DISCIPLINA, P_ID_PROFESSOR, NOW());

    INSERT INTO `TBL_CONVITE` (HASH_CONVITE, ID_DISCIPLINA, TOTAL_PEOPLE, EXPIRATION_DATE, LOG_INSERT)
    VALUES(P_HASH_CONVITE, LAST_INSERT_ID(), P_QUANTIDADE_CONVITES, P_EXPIRACAO_CONTIVE, NOW());

    SELECT HASH_CONVITE FROM `TBL_CONVITE` WHERE ID = LAST_INSERT_ID();
END;

DROP PROCEDURE IF EXISTS `P_NEW_ENDERECO`;
CREATE PROCEDURE `P_NEW_ENDERECO` (
    IN P_LOGRADOURO VARCHAR(100),
    IN P_LOGRADOURO_NUMERO INT,
    IN P_COMPLEMENTO VARCHAR(200),
    IN P_BAIRRO VARCHAR(50),
    IN P_CIDADE VARCHAR(50),
    IN P_ESTADO VARCHAR(50),
    IN P_PAIS VARCHAR(30)
)BEGIN
    INSERT INTO `TBL_LOGRADOUROS` (LOGRADOURO, LOGRADOURO_NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, PAIS, LOG_INSERT)
    VALUES(P_LOGRADOURO, P_LOGRADOURO_NUMERO, P_COMPLEMENTO, P_BAIRRO, P_CIDADE, P_ESTADO, P_PAIS, NOW());

    SELECT LAST_INSERT_ID() AS "ID";
END;
$$