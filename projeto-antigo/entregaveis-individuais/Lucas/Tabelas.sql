-- Sprint 1 - Modelagem das Tabelas do Banco de Dados

/*
Nesta primeira sprint foram definidas as tabelas principais do sistema, responsáveis por armazenar os dados de cadastro de usuários e empresas, além do monitoramento dos sensores de transporte e frigorífico. Essas tabelas garantem a organização das informações, integridade dos dados e suporte às funcionalidades iniciais do projeto.
*/

CREATE DATABASE Projeto;

USE Projeto;

-- Tabela de Cadastro - Responsável por armazenar os dados de usuários e empresas, incluindo informações de autenticação (e-mail e senha), identificação (CPF/CNPJ) e contato.
 
CREATE TABLE Cadastro (
id INT PRIMARY KEY AUTO_INCREMENT,
Nome_Empresa VARCHAR(70),
CNPJ CHAR(14) NOT NULL,
Nome VARCHAR(100),
Email VARCHAR(100) NOT NULL UNIQUE 
CONSTRAINT chkEmail CHECK(Email LIKE '%_@%.%'),
CPF CHAR(11) UNIQUE,
Tipo VARCHAR(13)
CONSTRAINT chkTipo CHECK(Tipo IN('Administrador', 'Usuario')),
Senha VARCHAR(255) NOT NULL,
Telefone VARCHAR(15)
);

-- Tabela de Sensor Transporte - Destinada a registrar os dados coletados pelos sensores instalados durante o transporte da carga, como temperatura, localização e status do veículo.

CREATE TABLE Sensor_Transporte (
id_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
Placa VARCHAR(7),
Datas DATE NOT NULL,
Horario TIME NOT NULL,
Turno VARCHAR(5)
CONSTRAINT chkTurno CHECK(Turno IN('Manha', 'Tarde', 'Noite')),
Temperatura FLOAT NOT NULL,
Status_Temperatura VARCHAR(8) NOT NULL
CONSTRAINT chkStatus_Temperatura CHECK(Status_Temperatura IN('Adequado', 'Moderado', 'Critico')),
Responsavel_Turno VARCHAR(100) NOT NULL
);

-- Tabela de Sensor Frigorífico - Voltada ao monitoramento dos sensores instalados no ambiente de armazenamento refrigerado (frigorífico), permitindo acompanhar a temperatura e demais variáveis críticas para a conservação da carga.

CREATE TABLE Sensor_Frigorifico (
id_Frigorifico INT PRIMARY KEY AUTO_INCREMENT,
Datas DATE NOT NULL,
Horario TIME NOT NULL,
Turno_Frigorifico VARCHAR(5)
CONSTRAINT chkTurno_Frigorifico CHECK(Turno_Frigorifico IN('Manha', 'Tarde', 'Noite')),
Temperatura FLOAT NOT NULL,
Status_Temperatura_Frigorifico VARCHAR(8) NOT NULL
CONSTRAINT chkStatus_Temperatura_Frigorifico CHECK(Status_Temperatura_Frigorifico IN('Adequado', 'Moderado', 'Critico')),
Responsavel_Turno VARCHAR(100) NOT NULL
);






 