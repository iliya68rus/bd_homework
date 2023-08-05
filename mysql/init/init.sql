CREATE SCHEMA shop;

CREATE TABLE shop.company
(
    id    int PRIMARY KEY AUTO_INCREMENT,
    name  varchar(50) NOT NULL,
    phone varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    type  varchar(50) NOT NULL
);


CREATE TABLE shop.category
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(50) NOT NULL
);

CREATE TABLE shop.product
(
    id          int PRIMARY KEY AUTO_INCREMENT,
    name        varchar(50) NOT NULL,
    price       decimal(10, 2) NOT NULL CHECK ( price >= 0 ),
    maker_id    int NOT NULL,
    provider_id int NOT NULL,
    category_id int,
    FOREIGN KEY (maker_id) REFERENCES shop.company (id),
    FOREIGN KEY (provider_id) REFERENCES shop.company (id),
    FOREIGN KEY (category_id) REFERENCES shop.category (id)
);

CREATE TABLE shop.consumer
(
    id        int PRIMARY KEY AUTO_INCREMENT,
    full_name varchar(80) NOT NULL,
    phone     varchar(50) NOT NULL
);

CREATE TABLE shop.purchase
(
    id          bigint PRIMARY KEY AUTO_INCREMENT,
    date        date NOT NULL,
    sum         decimal(14, 2) NOT NULL,
    address     varchar(50) NOT NULL,
    consumer_id int NOT NULL,
    FOREIGN KEY (consumer_id) REFERENCES shop.consumer (id)
);

CREATE TABLE shop.product_purchase
(
    product_id  int NOT NULL,
    purchase_id bigint NOT NULL,
    FOREIGN KEY (product_id) REFERENCES shop.product (id),
    FOREIGN KEY (purchase_id) REFERENCES shop.purchase (id),
    PRIMARY KEY (product_id, purchase_id)
);
