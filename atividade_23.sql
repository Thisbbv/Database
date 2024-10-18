 CREATE DATABASE sistema_usuarios;
USE sistema_usuarios;
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE logs_acesso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
DELIMITER //
CREATE FUNCTION usuario_existe(email_input VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe BOOLEAN;
    SET existe = EXISTS(SELECT 1 FROM usuarios WHERE email = email_input);
    RETURN existe;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE inserir_usuario_e_registrar_acesso(
    IN nome_input VARCHAR(100),
    IN email_input VARCHAR(100),
    IN senha_input VARCHAR(255)
)
BEGIN
    DECLARE usuario_id INT;
    
    -- Inserir o usuário na tabela 'usuarios'
    INSERT INTO usuarios (nome, email, senha_hash)
    VALUES (nome_input, email_input, senha_input);
    
    -- Obter o ID do novo usuário
    SET usuario_id = LAST_INSERT_ID();
    
    -- Registrar o acesso na tabela 'logs_acesso'
    INSERT INTO logs_acesso (usuario_id)
    VALUES (usuario_id);
END //
DELIMITER ;
CALL inserir_usuario_e_registrar_acesso(
    'cristiano ronaldo',
    'cristiano.ronaldo@email.com',
    SHA2('senha123', 256)
);
SELECT * FROM usuarios;
SELECT * FROM logs_acesso;
SELECT usuario_existe('cristiano.ronaldo@email.com');
