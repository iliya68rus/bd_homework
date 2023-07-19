-- производитель
CREATE TABLE manufacturer
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- разряды ремонтников
CREATE TABLE category
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(100), -- название
    rate decimal(3, 2) -- ставка
);

-- ремонтники
CREATE TABLE repairman
(
    id          int PRIMARY KEY AUTO_INCREMENT,
    category_id int,   -- разряд
    worker_id   bigint -- ид работника из общей базы компании
);

-- вид ремонта
CREATE TABLE type_repair
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(400) -- название
);

-- завод
CREATE TABLE factory
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(400) -- название
);

-- цех заказчик
CREATE TABLE factory
(
    id                    int PRIMARY KEY AUTO_INCREMENT,
    workshop              varchar(400), -- название
    responsible_worker_id bigint-- ид ответственного работника из общей базы компании
);

-- щётки
CREATE TABLE electric_motor_brushes
(
    id              int PRIMARY KEY AUTO_INCREMENT,
    manufacturer_id int,        -- производитель
    article         varchar(50) -- артикуль
);

-- подшипник
CREATE TABLE bearing
(
    id              int PRIMARY KEY AUTO_INCREMENT,
    manufacturer_id int,        -- производитель
    article         varchar(50) -- артикуль
);

