CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(155),
    telefone VARCHAR(20),
    data_de_nascimento DATE,
    endereco VARCHAR(200),
    cep CHAR(8)
);

CREATE TABLE agencia (
    id_agencia SERIAL PRIMARY KEY ,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    numero_agencia VARCHAR(10),
    telefone VARCHAR(15)
);

CREATE TABLE tipo_operacao (
    id_tipo SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    sinal SMALLINT NOT NULL
);

CREATE TABLE sessao (
    id_sessao SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id_cliente) NOT NULL, 
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    token VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE conta (
    id_conta SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id_cliente) NOT NULL,
    id_agencia INTEGER NOT NULL REFERENCES agencia(id_agencia) NOT NULL,
    numero_conta VARCHAR(20) UNIQUE NOT NULL,
    tipo_conta VARCHAR(30) NOT NULL,
    saldo DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    data_abertura DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    uf CHAR(2) NOT NULL
);

CREATE TABLE favorito (
    id_favorito SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES cliente(id_cliente) NOT NULL,
    id_conta_favorita INTEGER NOT NULL REFERENCES conta(id_conta) NOT NULL,
    apelido VARCHAR(50),
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transferencia (
    id_transferencia SERIAL PRIMARY KEY,
    id_conta_origem INTEGER NOT NULL REFERENCES conta(id_conta) NOT NULL,
    id_conta_destino INTEGER NOT NULL REFERENCES conta(id_conta) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_transferencia TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(200),
    status VARCHAR(20) NOT NULL
);

CREATE TABLE operacao (
    id_operacao SERIAL PRIMARY KEY,
    id_conta INTEGER NOT NULL REFERENCES conta(id_conta) NOT NULL,
    id_tipo_operacao INTEGER NOT NULL REFERENCES tipo_operacao(id_tipo) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao VARCHAR(200)
);




-- INSERT TABELA (UM INSERT POR TABELA)

INSERT INTO cliente (nome, cpf, email, telefone, data_de_nascimento, endereco, cep)
VALUES (
    'João Silva',
    '14567283459',
    'joaosilva01@gmail.com',
    '15999999999',
    '1990-08-09',
    'Rua Benedito Monteiro, 100',
    '18214100'
);


INSERT INTO agencia (nome, endereco, numero_agencia, telefone)
VALUES (
    'Agência Centro',
    'Rua Principal, 200',
    '0001',
    '1532554444'
);



INSERT INTO tipo_operacao (codigo, descricao, sinal)
VALUES ('DEP', 'Depósito', 1);

INSERT INTO tipo_operacao (codigo, descricao, sinal)
VALUES ('SAQ', 'Saque', -1);



INSERT INTO conta (id_cliente, id_agencia, numero_conta, tipo_conta, saldo, data_abertura, status, uf)
VALUES (
    1, 1, '12345-6', 'Corrente', 1500.00, '2026-01-15', 'Ativa', 'SP'
);

INSERT INTO conta (id_cliente, id_agencia, numero_conta, tipo_conta, saldo, data_abertura, status, uf)
VALUES (
    1, 1, '65432-1', 'Poupança', 3000.00, '2026-02-10', 'Ativa', 'SP'
);



INSERT INTO sessao (id_cliente, data_inicio, data_fim, token)
VALUES (
    1, CURRENT_TIMESTAMP, NULL, 'TOKEN123'
);



INSERT INTO favorito (id_cliente, id_conta_favorita, apelido)
VALUES (
    1, 2, 'Conta Poupança'
);



INSERT INTO transferencia (id_conta_origem, id_conta_destino, valor, descricao, status)
VALUES (
    1, 2, 250.00, 'Transferência entre contas', 'Concluída'
);



INSERT INTO operacao (id_conta, id_tipo_operacao, valor, descricao)
VALUES (
    1, 1, 500.00, 'Depósito em dinheiro'
);



INSERT INTO operacao (id_conta, id_tipo_operacao, valor, descricao)
VALUES (
    1, 2, 100.00, 'Saque em dinheiro'
);
