-- TABELA 1 - CADASTRO
CREATE DATABASE CYCLUS;
USE CYCLUS;
CREATE TABLE cadastro (
Idcadastro INT PRIMARY KEY auto_increment,
Empresa VARCHAR(100) not null,
email VARCHAR(50) NOT NULL,
CONSTRAINT chkemail CHECK (email LIKE '%@%'),
Tipo VARCHAR(50)
CONSTRAINT chkTipo CHECK(tipo IN ('Admistrador', 'Usuário')),
CNPJ CHAR(30) NOT NULL,
CPF CHAR(30) NOT NULL,
Senha VARCHAR(30) not null
);

INSERT INTO cadastro (Empresa, email, Tipo, CNPJ, CPF, Senha) VALUES
('Swift', 'swift@swift.com', 'Admistrador', '49.848.412/0001-75', ' ', 'swift0954');

SELECT * FROM cadastro;


-- TABELA 2 - ARDUINO
CREATE TABLE sensor (
idcontrole INT PRIMARY KEY auto_increment,
Empresa VARCHAR (50),
Localidade VARCHAR (40),
Temperatura DECIMAL (4,2),
UMIDADE INT,
Tempo_de_funcionamento TIME,
Dia_atual DATE
);


INSERT INTO sensor(Empresa, Localidade, Temperatura, UMIDADE, Tempo_de_funcionamento, Dia_atual) VALUES
('Swift', 'Carrefour Anália Franco', '23.40', 60, '8', '2025-08-29');

SELECT 
    Empresa, 
    Localidade, 
    Temperatura, 
    UMIDADE, 
    Tempo_de_funcionamento, 
    DATE_FORMAT(Dia_atual, '%d/%m/%Y') AS 'DIA ATUAL'
FROM sensor;


-- TABELA 3 FEEDBACK

CREATE TABLE feedback (
idempresa INT PRIMARY KEY auto_increment,
empresa VARCHAR(50),
Localidade VARCHAR(40),
Tipo_de_serviço_contratado VARCHAR(35),
Depoimento VARCHAR(300),
Quantos_sensores_ativos INT,
Alertas_resolvidos INT
);

INSERT INTO feedback(empresa, Localidade, Tipo_de_serviço_contratado, Depoimento, Quantos_sensores_ativos, Alertas_resolvidos) VALUES
('Swift', 'Tatuapé', 'monitoramento de temperatura', 'Desde que instalamos os sensores da Cyclus, conseguimos monitorar a climatização das nossas câmaras frias em tempo real, sem precisar enviar colaboradores para cada unidade', 5, 10);

SELECT * FROM feedback;
