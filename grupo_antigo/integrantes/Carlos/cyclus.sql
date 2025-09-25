USE cyclus;

CREATE TABLE usuario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14) UNIQUE,
    cnpj VARCHAR(18),
    email VARCHAR(40) UNIQUE
		CONSTRAINT chk_email CHECK(email LIKE '_%@_%.__%'),
	senha VARCHAR(12),
	nome_empresa VARCHAR(25),
    dt_nascimento DATE,
    horario DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuario (cpf, cnpj, email, senha, nome_empresa, dt_nascimento) VALUES
	('437.753.490-49', '57.249.740/0001-83', 'Paulo@gmail.com', 'oioi9909', 'Beef artesanais', '2003-09-12'),
	('128.556.550-99', '10.132.272/0001-07', 'Ana@gmail.com', '88oioi99', 'Beefs Gourmet', '1981-12-01'),
	('903.833.040-59', '33.863.131/0001-51', 'Joao@gmail.com', 'joao8989', 'Beef de rua', '1987-01-09');

CREATE TABLE dashboard(
	id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura VARCHAR(8)
    CONSTRAINT chk_temperatura CHECK(temperatura LIKE '%ºC'), 
    umidade VARCHAR(5),
    movimentacao_carne VARCHAR(18)
		CONSTRAINT chk_carne CHECK(movimentacao_carne LIKE 'R$:%'),
    perdas VARCHAR(5),
    reducao VARCHAR(5),
    investimento VARCHAR(18)
		CONSTRAINT chk_investimento CHECK(investimento LIKE 'R$:%')
);

INSERT INTO dashboard (temperatura, umidade, movimentacao_carne, perdas, reducao, investimento) VALUES
	('20ºC', '20%', 'R$:20.000', '15%', '10%', 'R$:10.000'),
	('10ºC', '10%', 'R$:40.000', '35%', '20%', 'R$:20.000'),
	('15ºC', '80%', 'R$:100.000', '40%', '20%', 'R$:50.000');
    
SELECT * FROM dashboard;

CREATE TABLE estoque(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    quantidade INT,
    horario DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_estoque VARCHAR(20)
		CONSTRAINT chk_status CHECK (status_estoque IN ('Ativo', 'Inativo')),
	tipo VARCHAR(20) 
		CONSTRAINT chk_tipo CHECK (tipo IN ('Entrada', 'Saida'))
);

INSERT INTO estoque(nome, quantidade, status_estoque, tipo) VALUES
	('Picanha', 30, 'Ativo', 'Entrada'),
    ('Cupim', 20, 'Ativo', 'Entrada'),
    ('Fígado', 0, 'Inativo', 'Saida');
    
SELECT * FROM estoque;
    