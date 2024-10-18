
CREATE DATABASE sistema_acessos;

USE sistema_acessos;

DROP TABLE  logs_acesso;
DROP TABLE  usuarios;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL, 
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs_acesso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endereco_ip VARBINARY(128), 
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

DROP VIEW acessos_usuarios;

CREATE VIEW acessos_usuarios AS
SELECT 
    usuarios.id AS usuario_id,
    usuarios.nome,
    usuarios.email,
    logs_acesso.data_acesso,
    AES_DECRYPT(logs_acesso.endereco_ip, 'chaveSegura') AS endereco_ip 
FROM 
    usuarios
JOIN 
    logs_acesso ON usuarios.id = logs_acesso.usuario_id;
DROP USER  'leitor'@'%';
DROP USER  'admin'@'%';

CREATE USER 'leitor'@'%' IDENTIFIED BY 'senhaSegura123';
GRANT SELECT ON sistema_acessos.acessos_usuarios TO 'leitor'@'%';

CREATE USER 'admin'@'%' IDENTIFIED BY 'senhaMuitoSegura456';
GRANT ALL PRIVILEGES ON sistema_acessos.* TO 'admin'@'%';

FLUSH PRIVILEGES;

INSERT INTO usuarios (nome, email, senha_hash) VALUES
('João da Silva', 'joao.silva@email.com', '$2y$10$EXEMPLOHASH1'),
('Maria Souza', 'maria.souza@email.com', '$2y$10$EXEMPLOHASH2');

INSERT INTO logs_acesso (usuario_id, endereco_ip) VALUES
(1, AES_ENCRYPT('192.168.1.1', 'chaveSegura')),
(2, AES_ENCRYPT('2001:0db8:85a3:0000:0000:8a2e:0370:7334', 'chaveSegura')),
(1, AES_ENCRYPT('192.168.1.3', 'chaveSegura'));

SELECT * FROM acessos_usuarios;

SELECT usuario_id, endereco_ip FROM logs_acesso;

SELECT usuario_id, AES_DECRYPT(endereco_ip, 'chaveSegura') AS endereco_ip_descriptografado 
FROM logs_acesso;
