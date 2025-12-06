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
('Rua das Estrelas', 810, 'Vila dos Cedros', 'Jundiai', 32345098, 'Loja');
    
INSERT INTO empresa (razao_social, cnpj, fkEndereco) VALUES
('Loja Vila dos Cedros', 11111111000111,  1);
    
INSERT INTO usuario (nome, cpf, email, senha, fkEmpresa) VALUES
('Claudio Figueira', 22222222222, 'claudio.figueira@gmail.com', 'claudio123', 1);
    
INSERT INTO freezer (localizacao, modeloFreezer, status, tempMax, tempMin, fkEmpresa) VALUES 
('Corredor 1', 'Freezer Philco PFH205B', 'Funcionando', 8.0, 2.0, 1),
('Corredor 2', 'Freezer Philco PFH205B', 'Funcionando', 8.0, 2.0, 1),
('Corredor 3', 'Freezer Electrolux H330', 'Funcionando', 8.0, 2.0, 1),
('Corredor 4', 'Freezer Electrolux H330', 'Funcionando', 8.0, 2.0, 1);

INSERT INTO sensor (modeloSensor, estado, fkFreezer) VALUES
('LM35 - RFVNP73E1NG1X4ZH', 1, 1),
('LM35 - OOJDZG40ITAMX97I', 1, 2),
('LM35 - D9DPQLXN9JQEBXCC', 1, 3),
('LM35 - T3B51AEFGF9QT5DY', 1, 4);
    
-- Valores Mocados
INSERT INTO registro (tempAtual, dataHoraRegistro, alerta, fkFreezer) VALUES
(4.5, '2025-01-10 08:15:00', 0, 1),
(7.9, '2025-01-10 12:30:00', 0, 1),
(8.5, '2025-01-10 16:00:00', 1, 1),
(3.2, '2025-01-10 08:20:00', 0, 2),
(2.1, '2025-01-10 13:10:00', 0, 2),
(1.5, '2025-01-10 18:45:00', 1, 2),
(5.0, '2025-01-10 09:00:00', 0, 3),
(6.2, '2025-01-10 14:30:00', 0, 3),
(9.1, '2025-01-10 19:00:00', 1, 3),
(4.9, '2025-01-10 09:10:00', 0, 4),
(2.5, '2025-01-10 15:00:00', 0, 4),
(10.0, '2025-01-10 20:10:00', 1, 4);

-- Apenas os sensores
SELECT tempAtual, dataHoraRegistro, fkFreezer
FROM registro WHERE fkFreezer = 1
ORDER BY dataHoraRegistro DESC LIMIT 1;

CREATE OR REPLACE VIEW freezer_view AS 
SELECT r.tempAtual AS freezer_tempAtual,
		DATE_FORMAT(r.dataHoraRegistro,'%H:%i %d/%m') AS freezer_dataHora,
        r.fkFreezer AS freezer_id,
        f.localizacao AS freezer_corredor,
        f.tempMax AS freezer_tempMax,
        f.tempMin AS freezer_tempMin
FROM registro r
JOIN freezer f ON f.idFreezer = r.fkFreezer
WHERE r.fkFreezer = 1
ORDER BY dataHoraRegistro DESC;

CREATE OR REPLACE VIEW grafico_view AS 
SELECT r.tempAtual AS freezer_tempAtual,
		DATE_FORMAT(r.dataHoraRegistro,'%H:%i:%s') AS freezer_dataHora,
        r.fkFreezer AS freezer_id,
        f.localizacao AS freezer_corredor,
        f.tempMax AS freezer_tempMax,
        f.tempMin AS freezer_tempMin
FROM registro r
JOIN freezer f ON f.idFreezer = r.fkFreezer
WHERE r.fkFreezer = 1
ORDER BY dataHoraRegistro DESC;

SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
		freezer_id, freezer_tempMax, freezer_tempMin
FROM freezer_view WHERE freezer_id = 1
ORDER BY freezer_dataHora DESC LIMIT 1;

SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
		freezer_id, freezer_tempMax, freezer_tempMin
FROM grafico_view WHERE freezer_id = 1
ORDER BY freezer_dataHora DESC LIMIT 5;

SELECT freezer_tempAtual, freezer_dataHora, freezer_corredor,
		freezer_id, freezer_tempMax, freezer_tempMin
FROM grafico_view WHERE freezer_id = 1
ORDER BY freezer_dataHora DESC LIMIT 1;