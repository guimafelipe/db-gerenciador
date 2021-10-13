drop database gerenciador;

create database gerenciador;

use gerenciador;

CREATE TABLE veiculo(
    id INT NOT NULL AUTO_INCREMENT,
    placa VARCHAR(7),
    chassi VARCHAR(20),
    ano INT,
    modelo VARCHAR(15),
    marca VARCHAR(15),
    cor VARCHAR (10),
    PRIMARY KEY(id)
);

CREATE TABLE dispositivo(
    id INT NOT NULL AUTO_INCREMENT,
    numero_serie VARCHAR(12),
    data_insercao DATETIME,
    descricao VARCHAR (150),
    PRIMARY KEY(id)
);

CREATE TABLE usuario(
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80),
    cpf VARCHAR(11),
    administrador CHAR,
    login_usuario VARCHAR(20),
    senha VARCHAR(30),
    PRIMARY KEY(id)
);

CREATE TABLE rota_desejada(
    id INT NOT NULL AUTO_INCREMENT,
    custo FLOAT,
    distancia FLOAT,
    data_insercao DATETIME,
    PRIMARY KEY(id)
);

CREATE TABLE rota_efetuada(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    custo FLOAT,
    distancia FLOAT,
    data_insercao DATETIME,
    id_dispositivo INT,
    id_rota_desejada INT,
    id_veiculo INT,
    id_usuario INT,
    CONSTRAINT fk_id_dispositivo_rotae FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id),
    CONSTRAINT fk_id_usuario_rotae FOREIGN KEY (id_usuario) REFERENCES usuario (id),
    CONSTRAINT fk_id_veiculo_rotae FOREIGN KEY (id_veiculo) REFERENCES veiculo (id),
    CONSTRAINT fk_id_rota_desejada_rotae FOREIGN KEY (id_rota_desejada) REFERENCES rota_desejada (id)
);

CREATE TABLE dispositivo_veiculo (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_veiculo INT,
    id_dispositivo INT,
    CONSTRAINT fk_id_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo (id),
    CONSTRAINT fk_id_dispositivo FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id)
);

CREATE TABLE veiculo_usuario(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_veiculo INT,
    id_usuario INT,
    CONSTRAINT fk_id_veiculousuario FOREIGN KEY (id_veiculo) REFERENCES veiculo (id),
    CONSTRAINT fk_id_usuarioveiculo FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);

CREATE TABLE dispositivo_rotad(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_dispositivo INT NOT NULL,
    id_rota_desejada INT NOT NULL,
    CONSTRAINT fk_id_dispositivo_rotad FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id),
    CONSTRAINT fk_id_rotad_dispositivo FOREIGN KEY (id_rota_desejada) REFERENCES rota_desejada (id)
);

CREATE TABLE endereco(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(15),
    numero VARCHAR(6),
    complemento VARCHAR(100),
    bairro VARCHAR(20),
    estado VARCHAR(20),
    cidade VARCHAR(20),
    cep VARCHAR(8),
    id_usuario INT NOT NULL,
    ddd VARCHAR(3),
    telefone VARCHAR(10),
    CONSTRAINT fk_id_endereco_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id)
);

CREATE TABLE posicao_efetuada(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    latitude FLOAT,
    altitude FLOAT,
    data_insercao DATE,
    id_rota_efetuada INT,
    CONSTRAINT fk_id_rota_efetuada FOREIGN KEY (id_rota_efetuada) REFERENCES rota_efetuada (id)
);

CREATE TABLE posicao_desejada(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    latitude FLOAT,
    altitude FLOAT,
    id_rota_desejada INT,
    CONSTRAINT fk_rota_desejada FOREIGN KEY (id_rota_desejada) REFERENCES rota_desejada (id)
);