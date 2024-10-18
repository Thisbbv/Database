
CREATE DATABASE acougue;
USE acougue;


CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    email VARCHAR(100)
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    tipo_carne VARCHAR(50),
    quantidade_em_estoque DECIMAL(10, 2) NOT NULL
);

CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(255)
);

CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT,
    produto_id INT,
    quantidade DECIMAL(10, 2),
    preco_unitario DECIMAL(10, 2),
    FOREIGN KEY (venda_id) REFERENCES vendas(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    cargo VARCHAR(50),
    salario DECIMAL(10, 2)
);




INSERT INTO clientes (nome, telefone, endereco, email) VALUES
('Rodrigo Alves', '11999992222', 'Rua dos Pinhais, 123', 'rodrigo.alves@email.com'),
('Claudia Martins', '11988883333', 'Rua das Palmeiras, 456', 'claudia.martins@email.com'),
('Fábio Souza', '11977774444', 'Avenida do Sol, 789', 'fabio.souza@email.com'),
('Mariana Dantas', '11966665555', 'Rua das Rosas, 101', 'mariana.dantas@email.com'),
('Carlos Braga', '11955556666', 'Rua das Orquídeas, 202', 'carlos.braga@email.com'),

('Vanessa Cardoso', '11922221111', 'Rua dos Girassóis, 303', 'vanessa.cardoso@email.com');


INSERT INTO produtos (nome, preco, tipo_carne, quantidade_em_estoque) VALUES
('Picanha Angus', 72.50, 'Bovina', 50.00),
('Filé Mignon', 89.90, 'Bovina', 30.00),
('Alcatra', 45.90, 'Bovina', 60.00),
('Costela Suína', 28.90, 'Suína', 40.00),
('Peito de Frango', 15.90, 'Ave', 100.00),
-- (45 produtos adicionais)
('Maminha', 39.90, 'Bovina', 70.00);


INSERT INTO fornecedores (nome, telefone, email, endereco) VALUES
('Agropecuária Silva', '1133332222', 'contato@agrosilva.com', 'Fazenda Vale Verde, s/n'),
('Carnes Premium', '1144443333', 'vendas@carnespremium.com', 'Avenida Carne Forte, 100'),
('Distribuidora Boa Carne', '1155554444', 'comercial@boacarne.com', 'Rua do Açougue, 500'),
('Fazenda do Sol', '1166665555', 'contato@fazendadosol.com', 'Estrada da Fazenda, 200'),
('Agro Alimentos', '1177776666', 'vendas@agroalimentos.com', 'Rua da Indústria, 300');


INSERT INTO funcionarios (nome, telefone, cargo, salario) VALUES
('Marcelo Costa', '11999998888', 'Açougueiro', 2800.00),
('Ana Beatriz', '11988887777', 'Caixa', 2300.00),
('Paulo Henrique', '11977776666', 'Vendedor', 2500.00),
('Fernanda Souza', '11966665555', 'Gerente', 3200.00),
('Lucas Almeida', '11955554444', 'Assistente de Vendas', 2200.00);


INSERT INTO vendas (cliente_id, valor_total) VALUES
(1, 145.80),
(2, 250.00),
(3, 75.50),
(4, 320.00),
(5, 150.90);


INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 2.00, 72.50), 
(1, 3, 1.00, 45.90),
(2, 2, 3.00, 89.90),
(2, 5, 5.00, 15.90), 
(3, 4, 2.00, 28.90); 




SELECT * FROM clientes;


SELECT * FROM produtos;


SELECT * FROM fornecedores;


SELECT vendas.id, clientes.nome, vendas.data_venda, vendas.valor_total
FROM vendas
JOIN clientes ON vendas.cliente_id = clientes.id;


SELECT itens_venda.id, produtos.nome, itens_venda.quantidade, itens_venda.preco_unitario
FROM itens_venda
JOIN produtos ON itens_venda.produto_id = produtos.id
WHERE venda_id = 1;


SELECT * FROM funcionarios;
