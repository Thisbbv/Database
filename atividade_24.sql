CREATE DATABASE sistema_vendas;
USE sistema_vendas;
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    produto VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

INSERT INTO usuarios (nome, email)
VALUES ('Leonardo Rocha', 'Leonardo.Rocha@email.com'),
       ('Carlos Bahia', 'Carlos.Bahia@email.com');
       
INSERT INTO pedidos (usuario_id, produto, quantidade)
VALUES (1, 'Notebook', 2),
       (2, 'Smartphone', 1),
       (1, 'Mouse', 5);
       
SELECT * FROM usuarios;
SELECT * FROM pedidos;
SELECT pedidos.id, usuarios.nome, pedidos.produto, pedidos.quantidade, pedidos.data_pedido
FROM pedidos
JOIN usuarios ON pedidos.usuario_id = usuarios.id;

UPDATE usuarios
SET nome = 'Ana Maria'
WHERE id = 1;
UPDATE pedidos
SET quantidade = 3
WHERE id = 2;
DELETE FROM usuarios
WHERE id = 2;
DELETE FROM pedidos
WHERE id = 3;
CREATE INDEX idx_email ON usuarios(email);
CREATE INDEX idx_produto ON pedidos(produto);
CREATE VIEW detalhes_pedidos AS
SELECT pedidos.id, usuarios.nome, usuarios.email, pedidos.produto, pedidos.quantidade, pedidos.data_pedido
FROM pedidos
JOIN usuarios ON pedidos.usuario_id = usuarios.id;
SELECT * FROM detalhes_pedidos;
DELIMITER //
CREATE FUNCTION contar_pedidos(usuario_id_input INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_pedidos INT;
    SET total_pedidos = (SELECT COUNT(*) FROM pedidos WHERE usuario_id = usuario_id_input);
    RETURN total_pedidos;
END //
DELIMITER ;


SELECT contar_pedidos(1);
DELIMITER //
CREATE PROCEDURE inserir_pedido(
    IN usuario_id_input INT,
    IN produto_input VARCHAR(100),
    IN quantidade_input INT
)
BEGIN
    INSERT INTO pedidos (usuario_id, produto, quantidade)
    VALUES (usuario_id_input, produto_input, quantidade_input);
END //
DELIMITER ;
CALL inserir_pedido(1, 'Teclado', 1);
START TRANSACTION;

INSERT INTO usuarios (nome, email)
VALUES ('Lucas Vieira', 'Lucas.Vieira@email.com');

-- Verificar se o usuário foi criado com sucesso
SET @usuario_id = LAST_INSERT_ID();

-- Inserir o pedido, caso o usuário tenha sido criado
INSERT INTO pedidos (usuario_id, produto, quantidade)
VALUES (@usuario_id, 'Monitor', 1);

COMMIT;
CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'senha123';

GRANT SELECT, INSERT, UPDATE ON sistema_vendas.* TO 'vendedor'@'localhost';
FLUSH PRIVILEGES;
DROP DATABASE sistema_vendas;
