CREATE DATABASE SmartBeef;
USE SmartBeef;

CREATE TABLE sensorTemp(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modeloSensor VARCHAR(20),
estadoSensor CHAR (3), CONSTRAINT chkEstado CHECK (estadoSensor IN('Sim','Nao')),
temporizadorSensor DATETIME,
temperaturaSensor DECIMAL (3,1),
umidadeSensor DECIMAL (3,1)
);

CREATE TABLE telaCadastroUser(
idCadastroUser INT PRIMARY KEY AUTO_INCREMENT,
nomeCadastroUser VARCHAR (50) NOT NULL,
senhaCadastroUser VARCHAR(30) NOT NULL,
emailCadastroUser VARCHAR(50) NOT NULL,
CNPJ CHAR (14) NOT NULL,
qtdSensoresCadastroUser INT
);

CREATE TABLE tbAdmin(
idAdmin INT PRIMARY KEY AUTO_INCREMENT,
nomeAdmin VARCHAR(50),
senhaAdmin VARCHAR(25),
emailAdmin VARCHAR (50),
tokenAdmin CHAR (8)
);

-- O tokenAdmin poderia ser um FK, mas não irei fazer pra evitar deixar isso daqui complexo.alter

CREATE TABLE tbProduto(
idProduto INT PRIMARY KEY AUTO_INCREMENT,
nomeProduto VARCHAR(50),
loteProduto DATETIME
);

INSERT INTO sensorTemp  (modeloSensor,estadoSensor,temporizadorSensor,temperaturaSensor,umidadeSensor) VALUES
('L-7M26','Nao','2012-08-29',11.3,20.1),
('L-7M56','Sim','2025-08-08',15.3,50.1),
('L-7M56','2025-04-10',20.1,25.1);

INSERT INTO telaCadastroUser (nomeCadastroUser, senhaCadastroUser,emailCadastroUser,CNPJ,qtdSensoresCadastroUser) VALUES
('Swiufit','!a1192209221','swiufit@outloukis.com','12345678912345',500),
('Frigado','!a9w1092i091r','frigado@hottmaiu.com','62654278122344',600),
('Susdia','!asdjojo1993','susdia@outloukis.com','75634212693567',300);

INSERT INTO tbAdmin (nomeAdmin,senhaAdmin,emailAdmin,tokenAdmin)VALUES
('Lucas','123456918','LucasFro@outlook.com','1JC4FEA8'),
('Arthur','17347518','ArthurB@hotmail.com','AJE461HC'),
('Carlos','!124ja35','CarlosTe@outlook.com','ABNA1234');

INSERT INTO tbProduto (nomeProduto,loteProduto) VALUES
('File Mignon','2020-05-03'),
('Iscas de Frango','2025-09-05'),
('Lagarto','2025-10-10');