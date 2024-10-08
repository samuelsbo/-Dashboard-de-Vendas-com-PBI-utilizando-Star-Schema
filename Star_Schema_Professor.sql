CREATE DATABASE DB_STAR_SCHEMA;
USE DB_STAR_SCHEMA;

-- Tabela DimProfessor
CREATE TABLE DimProfessor(
	id_professor INT IDENTITY(1, 1),
	nome VARCHAR(255) NOT NULL,
	genero VARCHAR(20) NOT NULL,
	data_nascimento DATE NOT NULL,
	grau_academico VARCHAR(100) NOT NULL,
	data_contratacao DATE NOT NULL,
	CONSTRAINT DimProfessor_id_professor_pk PRIMARY KEY(id_professor),
	CONSTRAINT DimProfessor_genero_ck CHECK(genero IN ('M', 'F', 'O'))
);

-- Tabela DimDepartamento
CREATE TABLE DimDepartamento(
	id_departamento INT IDENTITY(1, 1),
	nome_departamento VARCHAR(100) NOT NULL,
	faculdade VARCHAR(255) NOT NULL,
	chefe_departamento VARCHAR(255) NOT NULL,
	CONSTRAINT DimDepartamento_id_departamento_pk PRIMARY KEY(id_departamento),
	CONSTRAINT DimDepartamento_nome_departamento_un UNIQUE(nome_departamento)
);

-- Tabela DimCurso
CREATE TABLE DimCurso(
	id_curso INT IDENTITY(1, 1),
	nome_curso VARCHAR(50) NOT NULL,
	nivel VARCHAR(50) NOT NULL,
	creditos INT NOT NULL,
	duracao_semanas INT NOT NULL,
	CONSTRAINT DimCurso_id_curso_pk PRIMARY KEY(id_curso),
	CONSTRAINT DimCurso_nome_curso_un UNIQUE(nome_curso)
);

-- Tabela DimData
CREATE TABLE DimData(
	data DATE NOT NULL,
	ano as YEAR(data),
	trimestre as DATEPART(QUARTER, data),
	mes as MONTH(data),
	semana as DATEPART(WK, data),
	dia as DAY(data),
	nome_mes as DATENAME(MONTH, data),
	CONSTRAINT DimData_data_pk PRIMARY KEY(data)
);

-- Tabela FatoProfessor
CREATE TABLE FatoProfessor(
	data DATE NOT NULL,
	id_professor INT NOT NULL,
	id_curso INT NOT NULL,
	id_departamento INT NOT NULL,
	numeros_de_aulas INT NOT NULL,
	horas_ensino FLOAT NOT NULL,
	avaliacao_media FLOAT NOT NULL,
	salario FLOAT NOT NULL,
	CONSTRAINT FatoProfessor_data_fk FOREIGN KEY(data) REFERENCES DimData(data),
	CONSTRAINT FatoProfessor_id_professor_fk FOREIGN KEY(id_professor) REFERENCES DimProfessor(id_professor),
	CONSTRAINT FatoProfessor_id_curso_fk FOREIGN KEY(id_curso) REFERENCES DimCurso(id_curso),
	CONSTRAINT FatoProfessor_id_departamento_fk FOREIGN KEY(id_departamento) REFERENCES DimDepartamento(id_departamento),
	CONSTRAINT FatoProfessor_salario_ck CHECK(salario > 0)
);