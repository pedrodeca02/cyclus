create database cyclus;
use cyclus;

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100),
	numero VARCHAR(10),
    bairro VARCHAR(100),
    cidade VARCHAR(50),
    cep CHAR(8),
    complemento VARCHAR(50)
);

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(70),
    cnpj CHAR(14),
    fkEndereco INT,
		CONSTRAINT fkEmpresaEndereco
        FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
);

CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf CHAR(11),
    email VARCHAR(100),
    senha VARCHAR(25),
    fkEmpresa INT,
		CONSTRAINT fkUsuarioEmpresa
        FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);
	
CREATE TABLE freezer(
	idFreezer INT PRIMARY KEY AUTO_INCREMENT,
    localizacao VARCHAR(300),
    modeloFreezer VARCHAR(30),
    status VARCHAR(30),
    tempMax DECIMAL (3,1),
    tempMin DECIMAL (3,1),
	fkEmpresa INT,
		CONSTRAINT fkFreezerEmpresa
        FOREIGN KEY (fkEmpresa) REFERENCES empresa (idEmpresa)
);

CREATE TABLE sensor(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modeloSensor VARCHAR(100),
    estado TINYINT,
    fkFreezer INT,
		CONSTRAINT fkSensorFreezer
		FOREIGN KEY (fkFreezer) REFERENCES freezer (idFreezer)
);

CREATE TABLE registro(
	idRegistro INT AUTO_INCREMENT,
    tempAtual DECIMAL(3,1),
    dataHoraRegistro DATETIME,
    alerta TINYINT,
    fkFreezer INT,
    CONSTRAINT pkCompostaRegistro
		PRIMARY KEY(idRegistro, fkFreezer),
    CONSTRAINT fkRegFreezer
		FOREIGN KEY (fkFreezer) REFERENCES freezer (idFreezer)
);

CREATE TABLE monitoramento (
	idMonitoramento INT AUTO_INCREMENT,
    fkUsuario INT,
    fkFreezer INT,
    hrInicioTurno TIME,
    hrFimTurno TIME,
    CONSTRAINT pkCompostaMonitoramento
		PRIMARY KEY (idMonitoramento, fkUsuario, fkFreezer),
	CONSTRAINT fkMonUsuario
		FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario),
	CONSTRAINT fkMonFreezer
		FOREIGN KEY (fkFreezer) REFERENCES freezer (idFreezer)
);

-- INSERINDO VALORES
INSERT INTO endereco (rua, numero, bairro, cidade, cep, complemento) VALUES
	('Rua das Estrelas', 810, 'Vila dos Cedros', 'Jundiai', 32345098, 'Loja'),
	('Avenida Horizonte Azul', 357, 'Jardim Aurora', 'Campinas', 65432321, 'Loja'),
	('Travessa da Lua Cheia', 194, 'Vila Monte Claro', 'São Paulo', 89123345, 'Loja');
    
INSERT INTO empresa (razao_social, cnpj, fkEndereco) VALUES
	('Loja Vila dos Cedros', 11111111000111,  1),
	('Loja Jardim Aurora', 22222222000222, 2),
	('Loja Vila Monte Claro', 33333333000333, 3);
    
INSERT INTO usuario (nome, cpf, email, senha, fkEmpresa) VALUES
	('Claudio Figueira', 22222222222, 'claudio.figueira@gmail.com', 'claudio123', 1),
	('Carolina Fonseca', 33333333333, 'carolina.fonseca@gmail.com', 'carolina123', 2),
	('Jorge Souza', 66666666666, 'jorge.souza@gmail.com', 'jorge123', 3);
    
INSERT INTO freezer (localizacao, modeloFreezer, status, tempMax, tempMin, fkEmpresa) VALUES 
	('Corredor 1', 'Freezer Philco PFH205B', 'Funcionando', 8.0, 2.0, 1),
	('Corredor 2', 'Freezer Philco PFH205B', 'Funcionando', 8.0, 2.0, 1),
	('Corredor 1', 'Freezer Electrolux H330', 'Funcionando', 8.0, 2.0, 2),
	('Corredor 2', 'Freezer Electrolux H330', 'Funcionando', 8.0, 2.0, 2),
	('Corredor 1', 'Freezer Midea RCFB22', 'Funcionando', 8.0, 2.0, 3),
	('Corredor 2', 'Freezer Midea RCFB22', 'Funcionando', 8.0, 2.0, 3);

INSERT INTO sensor (modeloSensor, estado, fkFreezer) VALUES
	('LM35 - RFVNP73E1NG1X4ZH', 1, 1),
	('LM35 - OOJDZG40ITAMX97I', 1, 2),
	('LM35 - D9DPQLXN9JQEBXCC', 1, 3),
	('LM35 - T3B51AEFGF9QT5DY', 1, 4),
	('LM35 - 0MU661QWR9ON6USJ', 0, 5),
	('LM35 - I324NC4HWW60OWUW', 0, 6);
    
-- Valores Mocados
INSERT INTO registro (fkFreezer, tempAtual, dataHoraRegistro) VALUES
	(1, '10.0', '2025-10-22 16:15:17');

-- Valores Mocados
INSERT INTO registro (fkFreezer, tempAtual, dataHoraRegistro) VALUES
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
SELECT s.modeloSensor, f.tempMax, f.tempMin, s.idSensor,
	f.localizacao, f.status,
    em.razao_social,
	r.tempAtual, r.dataHoraRegistro
    FROM sensor AS s
		JOIN freezer AS f
        ON s.fkFreezer = f.idFreezer
        JOIN empresa AS em
        ON f.fkEmpresa = em.idEmpresa
        JOIN registro AS r
        ON r.fkFreezer= f.idFreezer;
        
select * from endereco;
select * from empresa;
select * from usuario;
