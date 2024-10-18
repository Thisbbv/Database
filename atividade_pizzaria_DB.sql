CREATE DATABASE Pizzaria;
USE Pizzaria;

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    data_cadastro DATE
);

CREATE TABLE Pizzas (
    id_pizza INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    tamanho ENUM('Pequena', 'Média', 'Grande'),
    preco DECIMAL(10,2)
);

CREATE TABLE Ingredientes (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco_unitario DECIMAL(10,2)
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Itens_Pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_pizza INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_pizza) REFERENCES Pizzas(id_pizza)
);


INSERT INTO Clientes (nome, email, telefone, endereco, data_cadastro) VALUES
('João Silva', 'joao1@gmail.com', '11999999991', 'Rua Augusto Stresser, 123', '2023-10-01'),
('Maria Souza', 'maria2@gmail.com', '11988888882', 'Rua Machado de Assis, 456', '2023-10-02'),
('Pedro Costa', 'pedro3@gmail.com', '11977777773', 'Rua Bom Jesus, 789', '2023-10-03'),
('Ana Lima', 'ana4@gmail.com', '11966666664', 'Rua Itupava, 101', '2023-10-04'),
('Lucas Alves', 'lucas5@gmail.com', '11955555555', 'Rua Comendador Araujo, 202', '2023-10-05'),
('Julia Ferreira', 'julia6@gmail.com', '11944444446', 'Rua Deputado Heitor Alencar Furtado, 303', '2023-10-06'),
('Carla Mendes', 'carla7@gmail.com', '11933333337', 'Rua Palmenses, 404', '2023-10-07'),
('Bruno Dias', 'bruno8@gmail.com', '11922222228', 'Rua Agostinho Pereira Alves Filho, 505', '2023-10-08'),
('Fernanda Rocha', 'fernanda9@gmail.com', '11911111119', 'Rua Nicolau Gulbino, 606', '2023-10-09'),
('Rafael Torres', 'rafael10@gmail.com', '11900000000', 'Rua Mozart Correia de Souza Pinto, 707', '2023-10-10');


INSERT INTO Pizzas (nome, tamanho, preco) VALUES
('Mussarela', 'Média', 30.00),
('Calabresa', 'Grande', 45.00),
('Portuguesa', 'Média', 35.00),
('Frango com Catupiry', 'Grande', 50.00),
('Marguerita', 'Pequena', 25.00),
('Pepperoni', 'Grande', 55.00),
('Quatro Queijos', 'Média', 40.00),
('Vegetariana', 'Pequena', 20.00),
('Bacon', 'Média', 38.00),
('Chocolate', 'Grande', 60.00);


INSERT INTO Ingredientes (nome, preco_unitario) VALUES
('Queijo', 5.00),
('Calabresa', 7.00),
('Frango', 6.50),
('Catupiry', 8.00),
('Molho de Tomate', 2.00),
('Orégano', 1.00),
('Pepperoni', 9.00),
('Bacon', 6.00),
('Chocolate', 10.00),
('Cogumelo', 5.50);



INSERT INTO Pedidos (id_cliente, data_pedido, valor_total) VALUES
(1, '2023-10-01', 75.00),
(2, '2023-10-02', 50.00),
(3, '2023-10-03', 90.00),
(4, '2023-10-04', 30.00),
(5, '2023-10-05', 120.00),
(6, '2023-10-06', 60.00),
(7, '2023-10-07', 40.00),
(8, '2023-10-08', 55.00),
(9, '2023-10-09', 85.00),
(10, '2023-10-10', 100.00);


INSERT INTO Itens_Pedido (id_pedido, id_pizza, quantidade, preco_unitario) VALUES
(1, 1, 2, 30.00),
(1, 2, 1, 45.00),
(2, 3, 1, 35.00),
(3, 4, 2, 50.00),
(4, 5, 1, 25.00),
(5, 6, 2, 55.00),
(6, 7, 1, 40.00),
(7, 8, 2, 20.00),
(8, 9, 1, 38.00),
(9, 10, 1, 60.00);



CREATE VIEW View_Pedidos_Clientes AS
SELECT c.nome, p.data_pedido, ip.quantidade, piz.nome AS pizza, ip.preco_unitario
FROM Clientes c
JOIN Pedidos p ON c.id_cliente = p.id_cliente
JOIN Itens_Pedido ip ON p.id_pedido = ip.id_pedido
JOIN Pizzas piz ON ip.id_pizza = piz.id_pizza;



INSERT INTO Clientes (nome, email, telefone, endereco, data_cadastro) VALUES
('Marcelo Pereira', 'marcelo11@gmail.com', '11999999911', 'Rua Bento Ribeiro, 808', '2023-10-11'),
('Beatriz Lima', 'beatriz12@gmail.com', '11988888822', 'Rua Konrad Kuno Frank, 909', '2023-10-12'),
('Gustavo Santos', 'gustavo13@gmail.com', '11977777733', 'Rua Araras, 1010', '2023-10-13'),
('Daniela Cardoso', 'daniela14@gmail.com', '11966666644', 'Rua Pedro Deconto, 1111', '2023-10-14'),
('Ricardo Alves', 'ricardo15@gmail.com', '11955555555', 'Rua Luiz Lara Fernandes da Penha, 1212', '2023-10-15'),
('Sofia Braga', 'sofia16@gmail.com', '11944444466', 'Rua daley Sun Busetti Mori, 1313', '2023-10-16'),
('Thiago Martins', 'thiago17@gmail.com', '11933333377', 'Rua Luiza Mazetto Baggio, 1414', '2023-10-17'),
('Lara Ferreira', 'lara18@gmail.com', '11922222288', 'Rua Praxedes Silva Avelleda, 1515', '2023-10-18'),
('Igor Nunes', 'igor19@gmail.com', '11911111199', 'Rua Ourizona, 1616', '2023-10-19'),
('Camila Silva', 'camila20@gmail.com', '11900000010', 'Rua Nicolau Vorobi, 1717', '2023-10-20');


INSERT INTO Pedidos (id_cliente, data_pedido, valor_total) VALUES
(11, '2023-10-11', 100.00),
(12, '2023-10-12', 65.00),
(13, '2023-10-13', 85.00),
(14, '2023-10-14', 40.00),
(15, '2023-10-15', 110.00),
(16, '2023-10-16', 55.00),
(17, '2023-10-17', 70.00),
(18, '2023-10-18', 60.00);


SELECT * FROM Clientes;
SELECT * FROM Pizzas;
SELECT * FROM Ingredientes;
SELECT * FROM Pedidos;
SELECT * FROM Itens_Pedido;
SELECT * FROM View_Pedidos_Clientes;

