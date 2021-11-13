CREATE TABLE cliente
  (
     id       INT NOT NULL IDENTITY(1, 1),
     nome     VARCHAR(50) NOT NULL,
     endereco VARCHAR(255) NULL,
     CONSTRAINT pk_cliente PRIMARY KEY ( id )
  )

go

CREATE TABLE telefone
  (
     id_cliente INT NOT NULL,
     numero     INT NOT NULL,
     CONSTRAINT pk_telefone PRIMARY KEY ( id_cliente, numero ),
     CONSTRAINT fk_telefonecliente FOREIGN KEY ( id_cliente ) REFERENCES cliente
     ( id )
  )

go

CREATE TABLE produto
  (
     id   INT NOT NULL IDENTITY(1, 1),
     nome VARCHAR(50) NOT NULL,
     CONSTRAINT pk_produto PRIMARY KEY ( id )
  )

go

CREATE TABLE pedido
  (
     numero     INT NOT NULL IDENTITY(1, 1),
     datahora   DATETIME NOT NULL,
     id_cliente INT NOT NULL,
     CONSTRAINT pk_pedido PRIMARY KEY (numero ),
     CONSTRAINT fk_pedidocliente FOREIGN KEY ( id_cliente ) REFERENCES cliente (
     id )
  )

go

CREATE TABLE itempedido
  (
     numeropedido INT NOT NULL,
     id_produto   INT NOT NULL,
     qtde         INT NOT NULL,
     CONSTRAINT pk_itempedido PRIMARY KEY (numeropedido, id_produto),
     CONSTRAINT fk_itempedidopedido FOREIGN KEY ( numeropedido) REFERENCES
     pedido ( numero ),
     CONSTRAINT fk_itempedidoproduto FOREIGN KEY ( id_produto) REFERENCES
     produto ( id )
  ) 
