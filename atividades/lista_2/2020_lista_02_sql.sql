/*
	Segunda lista de exercícios de banco de dados - Laboratório de SQL

	Docente: Dra. Karine Reis
	Discente: Felipe Menino Carlos
*/

-- Exercício 1 (Criação das tabelas Instrutor, Aluno, Escola e Curso)
CREATE TABLE Instrutor (
    InstrutorID   	INT   			NOT NULL,
    CPF				INT				NOT NULL  UNIQUE,
    Nome  			VARCHAR( 30 )  	NOT NULL,
    Endereco   		VARCHAR( 60 ),
    CONSTRAINT InstrutorPK PRIMARY KEY (InstrutorID) 
);

CREATE TABLE Aluno ( 
    AlunoID   		INT   			NOT NULL,
    CPF				INT				NOT NULL  UNIQUE,
    Nome  			VARCHAR( 30 )  	NOT NULL,
    Endereco   		VARCHAR( 60 ),
    CONSTRAINT AlunoPK PRIMARY KEY (AlunoID) 
);

CREATE TABLE Escola ( 
    EscolaID   		INT   			NOT NULL,
    CNPJ			INT				NOT NULL  UNIQUE,
    Nome  			VARCHAR( 30 )  	NOT NULL,
    Endereco   		VARCHAR( 60 ),
    CONSTRAINT EscolaPK PRIMARY KEY (EscolaID) 
);

CREATE TABLE Curso ( 
    CursoID   		INT   			NOT NULL,
    Nome  			VARCHAR( 30 )  	NOT NULL,
    Carga_horaria	INT 			NOT NULL,
    Ementa			VARCHAR( 500 )	,
    EscolaID        INT 			NOT NULL,
    
    CONSTRAINT CursoPK PRIMARY KEY (CursoID), 
    
    CONSTRAINT CursoEscolaFK 	FOREIGN KEY (EscolaID) 
    							REFERENCES Escola(EscolaID) 
    							ON DELETE CASCADE 
    							ON UPDATE CASCADE
);
--/ Final do exercício 1

-- Exercício 2 (Crie as tabelas Turma e Matrícula)
CREATE TABLE Turma
(
	turmaID INT,
	data_inicio DATE NOT NULL,
	data_termino DATE NOT NULL,
	cursoID INT,
	instrutorID INT,
	
	CONSTRAINT pk_turma PRIMARY KEY (turmaID),
	
	CONSTRAINT fk_turma_curso FOREIGN KEY (cursoID) 
							  REFERENCES Curso(CursoID) 
							  ON DELETE CASCADE
							  ON UPDATE CASCADE,
	
	CONSTRAINT fk_turma_instrutor FOREIGN KEY (instrutorID) 
								  REFERENCES Instrutor(InstrutorID)
								  ON DELETE CASCADE
								  ON UPDATE CASCADE
);

CREATE TABLE Matricula
(
	turmaID INT,
	alunoID INT,
	nota_final NUMERIC(4, 2),
	presenca INT,
	
	CONSTRAINT fk_matricula_turma FOREIGN KEY (turmaID)
								  REFERENCES Turma(turmaID)
								  ON DELETE CASCADE
								  ON UPDATE CASCADE,
	
	CONSTRAINT fk_matricula_aluno FOREIGN KEY (alunoID)
								  REFERENCES Aluno(AlunoID)
								  ON DELETE CASCADE
								  ON UPDATE CASCADE,
	
	CONSTRAINT pk_matricula PRIMARY KEY(turmaID, alunoID)
);
--/ Final do exercício 2

-- Exercício 3 (Inserir os dados de instrutor)
INSERT INTO Instrutor VALUES(1, 11111, 'Rodrigo Carvalho', 'Rua Alfa, num 50, Centro');
INSERT INTO Instrutor VALUES(2, 22222, 'Jacqueline França', 'Rua Sete de Setembro, num 620, Alvorada');
INSERT INTO Instrutor VALUES(3, 33333, 'Leandro Siqueira', 'Rua Nelson Davila, num 120, Centro');
-- Neste exercício, a inserção abaixo apresenta problemas em sua constituição original, uma vez que
-- tenta inserir um CPF já inserido. Para isso, o CPF é trocado.
-- Abaixo são apresentadas as versões originais e a alterada para o exercício
-- Versão Original: INSERT INTO Instrutor VALUES(4, 33333, 'Diego Faria', 'Rua Siqueira Campos, num 80, Jd Apolo');
-- Versão do exercício:
INSERT INTO Instrutor VALUES(4, 44444, 'Diego Faria', 'Rua Siqueira Campos, num 80, Jd Apolo');
--/ Final do exercício 3

-- Exercício 4 (Inserir os dados de alunos)
-- Neste exercício, ao tentar inserir os dados apresentados originalmente, um problema com o tamanho do
-- nome dos alunos foi identificado, para resolver tal problema, é feita a alteração do tamanho
ALTER TABLE Aluno ALTER COLUMN nome TYPE VARCHAR(180);

INSERT INTO Aluno VALUES(1, 12222, 'Jose Vitor Ferreira Fernandes Gomes Dias', 'Rua Alfa, num 100, Centro');
INSERT INTO Aluno VALUES(2, 32222, 'Rodrigo Gomes Dias', 'Rua Sete de Setembro, num 200, Alvorada');
INSERT INTO Aluno VALUES(3, 42222, 'Daniel Ribeiro Alvarenga', 'Rua Nelson Davila, num 150, Centro');
INSERT INTO Aluno VALUES(4, 52222, 'Gustavo Ferreira', 'Rua Lumem, num 140, Jd Apolo');
INSERT INTO Aluno VALUES(5, 62222, 'Marcelo Reis Fernandes', 'Rua Siqueira Campos, num 80, Jd Apolo');
INSERT INTO Aluno VALUES(6, 72222, 'Renata Fernandes Carvalho', 'Rua Sete de Setembro, num 620, Alvorada');
INSERT INTO Aluno VALUES(7, 82222, 'Debora Ribeiro Reis', 'Rua Lumem, num 140, Jd Apolo');
INSERT INTO Aluno VALUES(8, 92222, 'Daniela Reis Barbosa', 'Rua Nelson Davila, num 120, Centro');
INSERT INTO Aluno VALUES(9, 13333, 'Luciane Cardoso', 'Rua Siqueira Campos, num 80, Jd Apolo');
INSERT INTO Aluno VALUES(10, 91919, 'Claudio Cardoso', 'Rua Lumem, num 140, Jd Apolo');
INSERT INTO Aluno VALUES(11, 81818, 'Marina Reis Alvarenga', 'Rua Sete de Setembro, num 620, Alvorada');
INSERT INTO Aluno VALUES(12, 71717, 'Sabrina Carvalho', 'Rua Nelson Davila, num 120, Centro');
INSERT INTO Aluno VALUES(13, 61616, 'Julio Cesar Dias', 'Rua Siqueira Campos, num 80, Jd Apolo');
INSERT INTO Aluno VALUES(14, 51515, 'Regiane Limeira', 'Rua Sete de Setembro, num 620, Alvorada');
INSERT INTO Aluno VALUES(15, 41414, 'Augusto Dias Gomes', 'Rua Nelson Davila, num 120, Centro');
-- OBS: Erro ao inserir o primeiro registro, temos que aumentar o range do atributo nome
--/ Final do exercício 4

-- Exercício 5 (Populando as tabelas)
-- 5. Use os comandos SQL para inserir dados na tabela Escola, Curso, Turma e Matricula
INSERT INTO Escola VALUES(1, 11111, 'InfoSys', 'Rua Nelson Davila, num 400, Centro');
INSERT INTO Escola VALUES(2, 22222, 'Inova', 'Rua Sete de Setembro, num 800, Alvorada');
INSERT INTO Escola VALUES(3, 33333, 'CodSys', 'Rua Alfa, num 1030, Apolo');

INSERT INTO Curso VALUES(1, 'Linux - Introduction', 120, '', 1);
INSERT INTO Curso VALUES(2, 'Linux - Advanced', 120, '', 1);
INSERT INTO Curso VALUES(3, 'Windows - Introduction', 120, '', 1);
INSERT INTO Curso VALUES(4, 'Windows - Advanced', 120, '', 1);
INSERT INTO Curso VALUES(5, 'C++ Programming Language', 240, '', 3);
INSERT INTO Curso VALUES(6, 'Java Programming Language', 240, '', 3);
INSERT INTO Curso VALUES(7, 'Python', 120, '', 3);
INSERT INTO Curso VALUES(8, 'Database System and SQL', 240, '', 2);
INSERT INTO Curso VALUES(9, 'Data Science', 240, '', 2);
INSERT INTO Curso VALUES(10, 'Geoinformatics', 240, '', 2);

INSERT INTO Turma VALUES(1, to_date('2015-02-15', 'YYYY-MM-DD'), to_date('2015-06-15', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Turma VALUES(2, to_date('2015-08-15', 'YYYY-MM-DD'), to_date('2015-12-15', 'YYYY-MM-DD'), 2, 1);
INSERT INTO Turma VALUES(3, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-06-15', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Turma VALUES(4, to_date('2016-08-15', 'YYYY-MM-DD'), to_date('2016-12-15', 'YYYY-MM-DD'), 2, 1);
INSERT INTO Turma VALUES(5, to_date('2015-02-15', 'YYYY-MM-DD'), to_date('2015-06-15', 'YYYY-MM-DD'), 3, 2);
INSERT INTO Turma VALUES(6, to_date('2015-08-15', 'YYYY-MM-DD'), to_date('2015-12-15', 'YYYY-MM-DD'), 4, 2);
INSERT INTO Turma VALUES(7, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-06-15', 'YYYY-MM-DD'), 3, 2);
INSERT INTO Turma VALUES(8, to_date('2016-08-15', 'YYYY-MM-DD'), to_date('2016-12-15', 'YYYY-MM-DD'), 4, 2);
INSERT INTO Turma VALUES(9, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-06-15', 'YYYY-MM-DD'), 7, 3);
INSERT INTO Turma VALUES(10, to_date('2016-08-15', 'YYYY-MM-DD'), to_date('2016-11-15', 'YYYY-MM-DD'), 7, 3);
INSERT INTO Turma VALUES(11, to_date('2017-02-15', 'YYYY-MM-DD'), to_date('2017-06-15', 'YYYY-MM-DD'), 7, 3);
INSERT INTO Turma VALUES(12, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-11-15', 'YYYY-MM-DD'), 5, 4);
INSERT INTO Turma VALUES(13, to_date('2017-02-15', 'YYYY-MM-DD'), to_date('2017-11-15', 'YYYY-MM-DD'), 5, 4);
INSERT INTO Turma VALUES(14, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-11-15', 'YYYY-MM-DD'), 6, 3);
INSERT INTO Turma VALUES(15, to_date('2017-02-15', 'YYYY-MM-DD'), to_date('2017-11-15', 'YYYY-MM-DD'), 6, 3);
INSERT INTO Turma VALUES(16, to_date('2015-02-15', 'YYYY-MM-DD'), to_date('2015-11-15', 'YYYY-MM-DD'), 8, 1);
INSERT INTO Turma VALUES(17, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-11-15', 'YYYY-MM-DD'), 8, 1);
INSERT INTO Turma VALUES(18, to_date('2015-02-15', 'YYYY-MM-DD'), to_date('2015-11-15', 'YYYY-MM-DD'), 10, 4);
INSERT INTO Turma VALUES(19, to_date('2016-02-15', 'YYYY-MM-DD'), to_date('2016-11-15', 'YYYY-MM-DD'), 10, 4);

-- TurmaID, AlunoID, Nota e Presenca
INSERT INTO Matricula VALUES(1, 1, '8.4', 80);   
INSERT INTO Matricula VALUES(1, 2, '6.4', 85);   
INSERT INTO Matricula VALUES(1, 3, '5.0', 67);   
INSERT INTO Matricula VALUES(1, 4, '9.4', 100);   
INSERT INTO Matricula VALUES(1, 5, '8.7', 100); 
  
INSERT INTO Matricula VALUES(2, 1, '7.4', 80);   
INSERT INTO Matricula VALUES(2, 2, '7.4', 85);   
INSERT INTO Matricula VALUES(2, 3, '8.0', 80);   
INSERT INTO Matricula VALUES(2, 4, '7.4', 70);   
INSERT INTO Matricula VALUES(2, 5, '9.7', 100);   

INSERT INTO Matricula VALUES(3, 6, '8.4', 80);   
INSERT INTO Matricula VALUES(3, 7, '6.4', 85);   
INSERT INTO Matricula VALUES(3, 8, '5.0', 67);   
INSERT INTO Matricula VALUES(3, 9, '9.4', 100);   
INSERT INTO Matricula VALUES(3, 10, '8.7', 100); 
  
INSERT INTO Matricula VALUES(4, 6, '7.4', 80);   
INSERT INTO Matricula VALUES(4, 7, '9.4', 85);   
INSERT INTO Matricula VALUES(4, 8, '8.0', 80);   
INSERT INTO Matricula VALUES(4, 9, '7.4', 70);   
INSERT INTO Matricula VALUES(4, 10, '9.7', 100); 

INSERT INTO Matricula VALUES(9, 11, '7.4', 80);   
INSERT INTO Matricula VALUES(9, 12, '9.4', 85);   
INSERT INTO Matricula VALUES(9, 13, '8.0', 70);  

INSERT INTO Matricula VALUES(10, 14, '7.4', 80);   
INSERT INTO Matricula VALUES(10, 15, '9.4', 85);   
INSERT INTO Matricula VALUES(10, 1, '8.0', 70);  

INSERT INTO Matricula VALUES(11, 2, '7.4', 80);   
INSERT INTO Matricula VALUES(11, 3, '9.4', 85);   
INSERT INTO Matricula VALUES(11, 4, '8.0', 70);  
--/ Final do exercício 5
