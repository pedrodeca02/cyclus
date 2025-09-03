CREATE DATABASE clienteCyclus;
USE clienteCyclus;

CREATE TABLE cadastroEmpresa(
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
empresa VARCHAR(30),
cnpj CHAR(18),
responsavel VARCHAR(50),
cpf CHAR(14),
telefone VARCHAR(20),
email VARCHAR(30),
dtContrato datetime
); 

CREATE TABLE usuarioDashboard(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeUsuario VARCHAR (50),
email VARCHAR(30) NOT NULL UNIQUE,
cpfUsuario VARCHAR(14),
senhaUsuario VARCHAR(12) UNIQUE NOT NULL,
cnpj VARCHAR(20) NOT NULL
);

CREATE TABLE dadosDashboard(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
temperaturaMax DECIMAL(5,2),
temperaturaIdeal DECIMAL(5,2),
temperaturaMin DECIMAL(5,2)
);

CREATE TABLE frigorifico(
id INT PRIMARY KEY AUTO_INCREMENT,
cnpj VARCHAR(20),
unidade VARCHAR(20),
cep VARCHAR(20),
bairro VARCHAR(20),
numero VARCHAR(10)
);


