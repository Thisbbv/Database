CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('Alice Silva', 'alice.silva@email.com', '2023-02-01'),
('Bruno Souza', 'bruno.souza@email.com', '2023-03-05'),
('Carla Lima', 'carla.lima@email.com', '2023-04-10'),
('Diego Pereira', 'diego.pereira@email.com', '2023-05-15'),
('Fernanda Costa', 'fernanda.costa@email.com', '2023-06-20');

INSERT INTO pedidos (cliente_id, data_pedido, valor_total) VALUES
(1, '2023-07-01', 150.00),
(2, '2023-07-15', 85.00),
(1, '2023-07-20', 200.00);

SELECT * FROM clientes;

SELECT nome, email FROM clientes WHERE data_cadastro > '2023-01-01';

SELECT * FROM pedidos WHERE valor_total > 100;

SELECT * FROM clientes WHERE nome LIKE 'A%';

SELECT pedidos.*, clientes.nome 
FROM pedidos
JOIN clientes ON pedidos.cliente_id = clientes.id;

SELECT clientes.nome, COUNT(pedidos.id) AS total_pedidos
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nome;

SELECT SUM(valor_total) AS valor_total_pedidos FROM pedidos;

SELECT AVG(valor_total) AS media_valor_total FROM pedidos;

UPDATE clientes SET email = 'novo.email@email.com' WHERE id = 1;

UPDATE pedidos SET valor_total = valor_total * 1.10;

DELETE FROM clientes WHERE id = 2;

DELETE FROM pedidos WHERE cliente_id = 2;

SELECT * FROM clientes 
WHERE id NOT IN (SELECT cliente_id FROM pedidos);

SELECT clientes.nome, COUNT(pedidos.id) AS total_pedidos
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.cliente_id
GROUP BY clientes.nome;

CREATE INDEX idx_email ON clientes (email);

CREATE INDEX idx_valor_total ON pedidos (valor_total);
