create database cyclus;
use cyclus;

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50) NOT NULL
);

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(70) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    fkEndereco INT,
		CONSTRAINT fkEmpresaEndereco
        FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
);

CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(25) NOT NULL,
    fkEmpresa INT,
		CONSTRAINT fkUsuarioEmpresa
        FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);
	
CREATE TABLE freezer(
	idFreezer INT PRIMARY KEY AUTO_INCREMENT,
    localizacao VARCHAR(300) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(100) NOT NULL,
    tempMax DECIMAL(3,1) NOT NULL,
    tempMin DECIMAL(3,1) NOT NULL,
    fkFreezer INT,
		CONSTRAINT fkSensorFreezer
		FOREIGN KEY (fkFreezer) REFERENCES freezer (idFreezer),
	fkEmpresa INT,
		CONSTRAINT fkSensorEmpresa
        FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE registro(
	idRegistro INT AUTO_INCREMENT,
    fkSensor INT,
    CONSTRAINT pkComposta
		PRIMARY KEY (idRegistro, fkSensor),
    tempAtual DECIMAL(3,1) NOT NULL,
    dataHoraRegistro DATETIME,
    CONSTRAINT fkRegSensor
		FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- INSERINDO VALORES
INSERT INTO endereco (rua, numero, bairro, cidade, cep, complemento) VALUES
	('Rua das Estrelas', 810, 'Vila dos Cedros', 'Jundiai', 32345098, 'Loja'),
	('Avenida Horizonte Azul', 357, 'Jardim Aurora', 'Campinas', 65432321, 'Loja'),
	('Travessa da Lua Cheia', 194, 'Vila Monte Claro', 'São Paulo', 89123345, 'Loja');
INSERT INTO empresa (razao_social, cnpj, email, fkEndereco) VALUES
	('Loja Vila dos Cedros', 11111111000111, 'lojaviladoscedros@gmail.com', 1),
	('Loja Jardim Aurora', 22222222000222, 'lojajardimaurora@gmail.com', 2),
	('Loja Vila Monte Claro', 33333333000333, 'lojavilamonteclaro@gmail.com', 3);
    
INSERT INTO usuario (nome, cpf, email, senha, fkEmpresa) VALUES
	('Claudio Figueira', 22222222222, 'claudio.figueira@gmail.com', 'claudio123', 1),
	('Carolina Fonseca', 33333333333, 'carolina.fonseca@gmail.com', 'carolina123', 2),
	('Jorge Souza', 66666666666, 'jorge.souza@gmail.com', 'jorge123', 3);
    
INSERT INTO freezer (localizacao, modelo, status) VALUES 
	('Corredor 1', 'Freezer Philco PFH205B', 'Funcionando'),
	('Corredor 2', 'Freezer Philco PFH205B', 'Funcionando'),
	('Corredor 1', 'Freezer Electrolux H330', 'Funcionando'),
	('Corredor 2', 'Freezer Electrolux H330', 'Funcionando'),
	('Corredor 1', 'Freezer Midea RCFB22', 'Funcionando'),
	('Corredor 2', 'Freezer Midea RCFB22', 'Funcionando');

INSERT INTO sensor (modelo, tempMax, tempMin, fkFreezer, fkEmpresa) VALUES
	('LM35 - RFVNP73E1NG1X4ZH', 8.0, 2.0, 1, 1),
	('LM35 - OOJDZG40ITAMX97I', 8.0, 2.0, 2, 1),
	('LM35 - D9DPQLXN9JQEBXCC', 8.0, 2.0, 3, 2),
	('LM35 - T3B51AEFGF9QT5DY', 8.0, 2.0, 4, 2),
	('LM35 - 0MU661QWR9ON6USJ', 8.0, 2.0, 5, 3),
	('LM35 - I324NC4HWW60OWUW', 8.0, 2.0, 6, 3);
    
-- Valores Mocados
INSERT INTO registro (fkSensor, tempAtual, dataHoraRegistro) VALUES
	(1, '10.0', '2025-10-22 16:15:17');

-- Valores Mocados
INSERT INTO registro (fkSensor, tempAtual, dataHoraRegistro) VALUES
	(2, '4.0', '2025-10-22 16:15:17');
    
-- Apenas os sensores
SELECT * FROM sensor;

-- Endereco com Empresa
SELECT * FROM endereco AS e
	JOIN empresa AS em
    ON em.fkEndereco = e.idEndereco;
    
-- Empresa com Usuarios
SELECT em.razao_social,
	u.nome, u.email
	FROM empresa AS em
		JOIN usuario AS u
		ON u.fkEmpresa = em.idEmpresa;
        
-- Empresa com Sensor e Freezer
SELECT s.modelo, s.tempMax, s.tempMin, s.idSensor,
	f.localizacao, f.status,
    em.razao_social,
	r.tempAtual, r.dataHoraRegistro
    FROM sensor AS s
		JOIN freezer AS f
        ON s.fkFreezer = f.idFreezer
        JOIN empresa AS em
        ON s.fkEmpresa = em.idEmpresa
        JOIN registro AS r
        ON r.fkSensor= s.idSensor;
