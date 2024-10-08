# Dashboard-de-Vendas-com-PBI-utilizando-Star-Schema

# Modelagem de Dados - Esquema Estrela

Este projeto contém a criação de um banco de dados utilizando o modelo de esquema estrela, que é ideal para análises de dados em ambientes de Data Warehouse. O foco deste esquema é otimizar as consultas e a análise de dados de forma eficiente.

## Sumário

- [Descrição do Projeto](#descrição-do-projeto)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)
- [Tabelas Criadas](#tabelas-criadas)
- [Relacionamentos](#relacionamentos)
- [Esquema Estrela](#esquema-estrela)
- [Autor](#autor)

## Descrição do Projeto

Este projeto visa criar um banco de dados para armazenar informações sobre professores, departamentos, cursos e suas respectivas interações. O modelo é implementado em um esquema estrela, onde tabelas de dimensão e uma tabela fato são usadas para facilitar análises complexas e relatórios.

## Tecnologias Utilizadas

- **SQL Server** ou outro sistema de gerenciamento de banco de dados relacional (RDBMS) para criar e manipular o banco de dados.
- **SQL** como linguagem de consulta para definição e manipulação de dados.

## Estrutura do Banco de Dados

O banco de dados criado é chamado `DB_STAR_SCHEMA`. Abaixo estão as tabelas criadas no esquema:

### Tabelas Criadas

1. **DimProfessor**
   - Armazena informações sobre os professores, incluindo nome, gênero, data de nascimento e grau acadêmico.
   
2. **DimDepartamento**
   - Contém dados sobre os departamentos, incluindo nome do departamento, faculdade e chefe do departamento.

3. **DimCurso**
   - Detalha os cursos oferecidos, incluindo nome do curso, nível, créditos e duração.

4. **DimData**
   - Gerencia as informações de data, incluindo ano, trimestre, mês e nome do mês.

5. **FatoProfessor**
   - Tabela fato que relaciona dados de professores com cursos e departamentos, contendo informações sobre aulas, horas de ensino, avaliações e salários.

### Exemplo de Tabelas

```sql
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
```
## Relacionamentos

As tabelas **DimProfessor**, **DimCurso**, e **DimDepartamento** são tabelas de dimensão que se conectam à tabela fato **FatoProfessor**. A tabela **DimData** conecta-se à tabela fato através da data das aulas.

### Chaves Estrangeiras

```sql
CONSTRAINT FatoProfessor_data_fk FOREIGN KEY(data) REFERENCES DimData(data),
CONSTRAINT FatoProfessor_id_professor_fk FOREIGN KEY(id_professor) REFERENCES DimProfessor(id_professor),
CONSTRAINT FatoProfessor_id_curso_fk FOREIGN KEY(id_curso) REFERENCES DimCurso(id_curso),
CONSTRAINT FatoProfessor_id_departamento_fk FOREIGN KEY(id_departamento) REFERENCES DimDepartamento(id_departamento)
```
## Esquema Estrela

Abaixo está a representação do esquema estrela:

                  +-----------------+         +-----------------+
                  |  DimProfessor   |         |     DimData     |
                  +-----------------+         +-----------------+       
                         |                           |
                         +-------------+-------------+
                                       |        
                                       |
                                       |
                              +-----------------+
                              |  FatoProfessor  |
                              +-----------------+
                                       |
                                       |
                                       |
                         +-------------+-------------+
                         |                           |
                  +-----------------+         +-----------------+
                  |     DimCurso    |         | DimDepartamento |
                  +-----------------+         +-----------------+
          
## Autor

Este projeto foi desenvolvido por Samuel Batista, baseado nas orientações da tutora Juliana Mascarenhas (@julianazanelatto). Sinta-se à vontade para entrar em contato ou contribuir com melhorias!
