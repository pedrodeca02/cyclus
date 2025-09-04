CREATE DATABASE smartBeef;
use smartBeef;

-- Tabela 01
CREATE TABLE cadastroEmpresa (
id INT PRIMARY KEY auto_increment,
nomeEmpresa VARCHAR (70) NOT NULL,
cnpj VARCHAR (20) UNIQUE,
email VARCHAR(100) UNIQUE);

-- Tabela 02
CREATE TABLE dadosDash (
id INT PRIMARY KEY auto_increment,
sensor VARCHAR(30),
locall VARCHAR(60) NOT NULL,
dtRegistro DATETIME,
registro DECIMAL(2, 2) NOT NULL);

-- Tabela 03
CREATE TABLE cadastroUser (
id INT PRIMARY KEY auto_increment,
nomeUser VARCHAR (20),
sobrenomeUser VARCHAR(20),
cpf CHAR(11) UNIQUE,
email VARCHAR(100) UNIQUE constraint chkEmail CHECK (email LIKE '%@%'));

ALTER TABLE cadastroEmpresa ADD COLUMN senha VARCHAR(100);
ALTER TABLE cadastroUser ADD COLUMN senha VARCHAR(100);







