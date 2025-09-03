CREATE DATABASE usuarios;

USE usuarios;

CREATE TABLE cadastro_empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(100),
cnpj VARCHAR(18),
email VARCHAR(320),
senha VARCHAR(100),
telefone VARCHAR(20),
endereço VARCHAR (300),
dtIngresso DATE
);

CREATE TABLE cadastro_usuarios (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(100),
nome VARCHAR (150),
funcao VARCHAR (10),
	CONSTRAINT chkFuncao 
		CHECK(funcao IN('Gestor', 'Analista')),
email VARCHAR(320),
senha VARCHAR(100)
);

CREATE TABLE arduino (
idArduino INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(100),
unidade VARCHAR(300),
temperatura VARCHAR(6),
umidade VARCHAR(8),
dtMonitoramento DATE
);

CREATE TABLE contrato (
idContrato INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(100),
dtInicio DATE,
dtFim DATE,
qtdSensores INT,
Unidades VARCHAR(1000),
estado VARCHAR (11),
	CONSTRAINT chkEstado
		CHECK(estado IN('ativo', 'pausa', 'cancelado'))
);







