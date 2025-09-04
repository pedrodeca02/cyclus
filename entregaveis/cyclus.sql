CREATE DATABASE cyclus;
USE cyclus;

CREATE TABLE usuario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(70),
    cnpj CHAR(18) NOT NULL,
    cpf CHAR(14) UNIQUE NOT NULL,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL
		CONSTRAINT chk_email CHECK(email LIKE '_%@_%.__%'),
	tipo VARCHAR(50)
		CONSTRAINT chk_tipo CHECK(tipo IN('Administrador', 'Usuario')),
	senha VARCHAR(30) NOT NULL,
    token VARCHAR(10) UNIQUE
);

INSERT INTO usuario (nome_empresa, cnpj, cpf, nome, email, tipo, senha, token) VALUES
	('Açougue Paulo', '49.848.412/0001-75', '409.243.470-74', 'Paulo', 'Paulo@gmail.com', 'Administrador', '123Paulo', '1234567890');
    
CREATE TABLE dashboard(
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    temperaturaAtual DECIMAL (4,1),
    temperaturaMax DECIMAL (4,1),
    temperaturaMin DECIMAL(4,1),
	horarioRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_temperatura VARCHAR(30)
		CONSTRAINT chk_status CHECK(status_temperatura IN('Adequado', 'Moderado', 'Crítico')),
	localidade VARCHAR(30)
);

INSERT INTO dashboard (temperaturaAtual, temperaturaMax, temperaturaMin, status_temperatura, localidade) VALUES
	(2.0, 4.0, 0.0, 'Adequado', 'São Paulo');

CREATE TABLE contrato(
	idContrato INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL (8,2),
    status_contrato VARCHAR(20)
		CONSTRAINT chk_contrato CHECK(status_contrato IN('Ativo', 'Inadiplente', 'Inativo')),
	nome_fantasia VARCHAR(30),
    cnpj CHAR(14) UNIQUE,
    responsavel VARCHAR(30),
    cpf CHAR(11) UNIQUE,
    telefone VARCHAR(20),
	email VARCHAR(100) UNIQUE NOT NULL
		CONSTRAINT chk_emailcontrato CHECK(email LIKE '%@%' AND email LIKE '%.___'),
	datacontratoInicio DATE,
	datacontratoFim DATE
);
    
INSERT INTO contrato (valor, status_contrato, nome_fantasia, cnpj, responsavel, cpf, telefone, email, datacontratoInicio, datacontratoFim) VALUES
	(30.000, 'Ativo', 'Parabol', '64418712000108', 'Juliano', '86239748080', '11939478097', 'juliano@gmail.com', '2025-08-09', '2029-08-12');