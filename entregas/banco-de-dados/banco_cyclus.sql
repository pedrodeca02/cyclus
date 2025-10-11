create database cyclus;
use cyclus;

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    cep CHAR(8) NOT NULL,
    complemento VARCHAR(50) NOT NULL,
    UF CHAR(2) NOT NULL
);

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    representante VARCHAR(45) NOT NULL,
    nome_empresa VARCHAR(70) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(100) NOT NULL,
    token INT NOT NULL,
    fkEndereco INT,
		CONSTRAINT fkEmpresaEndereco
        FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
);

CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    cargo VARCHAR(20) NOT NULL,
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
    horarioRegistro DATETIME,
    CONSTRAINT fkRegSensor
		FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- INSERINDO VALORES
INSERT INTO endereco (rua, numero, bairro, cidade, cep, complemento, uf) VALUES
	('Av 9 de Julho', 1080, 'Vila Virginia', 'Jundiai', 13201009, 'Loja', 'SP'),
	('Av Tenente Marques', 3582, 'Polvilho', 'Cajamar', 07790845, 'Loja', 'SP'),
	('Av Adolfo Pinheiro', 674, 'Santo Amaro', 'São Paulo', 04734000, 'Loja', 'SP');
    
INSERT INTO empresa (representante, nome_empresa, cnpj, email, token, fkEndereco) VALUES
	('Marcos Gomes', 'Loja Jundiai', 11111111000111, 'lojajundiai@gmail.com', 988467, 1),
	('Carol Fonseca', 'Loja Cajamar', 22222222000222, 'lojacajamar@gmail.com', 442079, 2),
	('Julio Cesar', 'Loja Santo Amaro', 33333333000333, 'lojasantoamaro@gmail.com', 202644, 3);
    
INSERT INTO usuario (nome, cpf, cargo, email, senha, fkEmpresa) VALUES
	('Marcos Gomes', 11111111111, 'Gerente', 'marcos.gomes@gmail.com', 'marcos123', 1),
	('Claudio Figueira', 22222222222, 'Supervisor', 'claudio.figueira@gmail.com', 'claudio123', 1),
	('Carol Fonseca', 33333333333, 'Gerente', 'carol.fonseca@gmail.com', 'carol123', 2),
	('Gustavo Jesus', 44444444444, 'Supervisor', 'gustavo.jesus@gmail.com', 'gustavo123', 2),
	('Julio Cesar', 55555555555, 'Gerente', 'julio.cesar@gmail.com', 'julio123', 3),
	('Jorge Rock', 66666666666, 'Supervisor', 'jorge.rock@gmail.com', 'jorge123', 3);
    
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
    
-- Endereco com Empresa
SELECT * FROM endereco AS e
	JOIN empresa AS em
    ON em.fkEndereco = e.idEndereco;
    
-- Empresa com Usuarios
SELECT em.nome_empresa,
	u.nome, u.cargo, u.email
	FROM empresa AS em
		JOIN usuario AS u
		ON u.fkEmpresa = em.idEmpresa;
        
-- Empresa com Sensor e Freezer
SELECT s.modelo, s.tempMax, s.tempMin,
	f.localizacao, f.status,
    em.nome_empresa
    FROM sensor AS s
		JOIN freezer AS f
        ON s.fkFreezer = f.idFreezer
        JOIN empresa AS em
        ON s.fkEmpresa = em.idEmpresa;