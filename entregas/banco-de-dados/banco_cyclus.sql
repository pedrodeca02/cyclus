CREATE DATABASE cyclus;
USE cyclus;

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
	idRegistro INT,
    fkSensor INT,
    CONSTRAINT pkComposta
		PRIMARY KEY (idRegistro, fkSensor),
    tempAtual DECIMAL(3,1) NOT NULL,
    horarioRegistro DATETIME,
    CONSTRAINT fkRegSensor
		FOREIGN KEY (fkSensor) REFERENCES sensor(fkSensor)
);

