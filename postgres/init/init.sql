CREATE TABLE company
(
    id    int PRIMARY KEY,
    name  varchar(50) NOT NULL,
    phone varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    type  varchar(50) NOT NULL
);

CREATE TABLE category
(
    id   int PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE product
(
    id          int PRIMARY KEY,
    name        varchar(50)            NOT NULL,
    price       decimal(10, 2)         NOT NULL CHECK ( price >= 0 ),
    maker_id    int REFERENCES company NOT NULL,
    provider_id int REFERENCES company NOT NULL,
    category_id int REFERENCES category
);

CREATE TABLE consumer
(
    id        int PRIMARY KEY,
    full_name varchar(80) NOT NULL,
    phone     varchar(50) NOT NULL
);

CREATE TABLE purchase
(
    id          bigint PRIMARY KEY,
    date        date                    NOT NULL,
    sum         decimal(14, 2)          NOT NULL,
    address     varchar(50)             NOT NULL,
    consumer_id int REFERENCES consumer NOT NULL
);

CREATE TABLE product_purchase
(
    product_id  int REFERENCES product     NOT NULL,
    purchase_id bigint REFERENCES purchase NOT NULL,
    PRIMARY KEY (product_id, purchase_id)
);

CREATE INDEX idx_company_name ON company (name);
CREATE INDEX idx_product_name ON product (name);
CREATE INDEX idx_product_price ON product (price);
CREATE INDEX idx_category_name ON category (name);
CREATE INDEX idx_purchase_date ON purchase (date);
CREATE INDEX idx_purchase_sum ON purchase (sum);
CREATE INDEX idx_consumer_full_name ON consumer (full_name);



-- INSERT INTO company (id, name, phone, email, type)
-- SELECT generate_series(1, 1000000) AS id,
--        md5(random()::text)     AS name,
--        md5(random()::text)     AS phone,
--        md5(random()::text)     AS email,
--        md5(random()::text)     AS type;
