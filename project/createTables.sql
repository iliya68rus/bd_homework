-- todo проставить ограничения

-- производитель
CREATE TABLE manufacturer
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- неисправность (щетки, подшипки, вал, обмотка)
CREATE TABLE malfunction
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) -- название
);

-- ремонтники
CREATE TABLE repairman
(
    id                        int PRIMARY KEY AUTO_INCREMENT,
    date_next_qualifying_exam date,  -- дата следующего квалификационного экзамена
    worker_id                 bigint -- ид работника из общей базы компании
);

-- перечисление какие несиправности может исправить ремонтник
CREATE TABLE malfunction_repairman
(
    malfunction_id int,    -- ид неисправности
    repairman_id   bigint, -- ид ремонтника
    estimation     int,    -- оценка от 1 до 10
    PRIMARY KEY (malfunction_id, repairman_id)
);

-- вид ремонта (ТО1, ТО2, ТО3, КР и т.д.)
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
CREATE TABLE workshop_customer
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

-- вид возбуждения (параллельное, последовательное, смешанное)
CREATE TABLE type_motor_excitation
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- трансформатор
CREATE TABLE transformer
(
    id        int PRIMARY KEY AUTO_INCREMENT,
    type      varchar(255), -- тип todo вынести
    power     int,          -- мощность
    voltage_h int,          -- напряжение ВН (высокое напряжение)
    voltage_l int           -- напряжение НН (низкое напряжение)
);

-- зарегестрированный трансформатор
CREATE TABLE reg_transformer
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    transformer_id       int,         -- ид трансформатора
    factory_id           int,         -- завод
    workshop_customer_id int          -- ид цеха
);

-- статус заказа (ремонт начат, ремонт окончен)
CREATE TABLE status_order
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) -- название
);

-- заказ на трансформатор
CREATE TABLE transformer_order
(
    id                 bigint PRIMARY KEY AUTO_INCREMENT,
    order_number       int,          -- заказ
    reg_transformer_id int,          -- ид зарегестрированного трансформатора
    type_repair_id     int,          -- ид вида ремонта
    defect             varchar(500), -- примечание по неполадкам
    date_acceptance    date,         -- дата приемки
    date_issue         date,         -- дата выдачи
    status_order_id    int           -- ид статуса заказа
);

-- перечисление неисправностей трансформатора
CREATE TABLE malfunction_transformer_order
(
    malfunction_id       int,    -- ид неисправности
    transformer_order_id bigint, -- ид заказа на трансформатор
    PRIMARY KEY (malfunction_id, transformer_order_id)
);

-- ремонт трансформатора (для фиксации всех кто занимался ремонтом)
CREATE TABLE transformer_repair
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    transformer_order_id bigint,      -- ид заказа на трансформатор
    repairman_id         int,         -- ид ремонтника
    repair_date          date,        -- дата ремонта
    note                 varchar(300) -- примечание
);

-- двигатель постоянного тока
CREATE TABLE dc_motor
(
    id                        int PRIMARY KEY AUTO_INCREMENT,
    type                      varchar(255), -- тип todo вынести
    power                     int,          -- мощность
    inductor_voltage          int,          -- напряжение индуктора
    inductor_current          int,          -- ток индуктора
    number_revolutions        int,          -- число оборотов
    armature_voltage          int,          -- напряжение якоря
    armature_current          int,          -- ток якоря
    type_motor_excitation_id  int,          -- ид вида возбуждения
    excitation_voltage        int,          -- напряжение возбуждения
    excitation_current        int,          -- ток возбуждения
    number_output_ends        int,          -- количество  выводных концов
    type2                     varchar(255), -- тип щеток и размер todo вынести
    drive_side_bearing_id     int,          -- ид типа подшипника со стороны привода
    collector_side_bearing_id int,          -- ид типа подшипника со стороны коллектора
    efficiency                int           -- КПД %
);

-- зарегестрированный двигатель постоянного тока
CREATE TABLE reg_dc_motor
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    dc_motor_id          int,         -- ид двигателя постоянного тока
    factory_id           int,         -- завод
    workshop_customer_id int          -- ид цеха
);

-- заказ на двигатель постоянного тока
CREATE TABLE dc_motor_order
(
    id              bigint PRIMARY KEY AUTO_INCREMENT,
    order_number    int,          -- заказ
    reg_dc_motor_id int,          -- ид зарегестрированного двигателя постоянного тока
    type_repair_id  int,          -- ид вида ремонта
    defect          varchar(500), -- примечание по неполадкам
    date_acceptance date,         -- дата приемки
    date_issue      date,         -- дата выдачи
    status_order_id int           -- ид статуса заказа
);

-- перечисление неисправностей двигателя постоянного тока
CREATE TABLE malfunction_dc_motor_order
(
    malfunction_id    int,    -- ид неисправности
    dc_motor_order_id bigint, -- ид заказа на двигатель постоянного тока
    PRIMARY KEY (malfunction_id, dc_motor_order_id)
);

-- ремонт двигателя постоянного тока (для фиксации всех кто занимался ремонтом)
CREATE TABLE dc_motor_repair
(
    id                int PRIMARY KEY AUTO_INCREMENT,
    dc_motor_order_id bigint,      -- ид заказа на двигатель постоянного тока
    repairman_id      int,         -- ид ремонтника
    repair_date       date,        -- дата ремонта
    note              varchar(300) -- примечание
);

-- расположение барно (коробка выводов)
CREATE TABLE location_barno
(
    id       int PRIMARY KEY AUTO_INCREMENT,
    location varchar(50) -- расположение
);

-- соединение фаз
CREATE TABLE phase_connection
(
    id         int PRIMARY KEY AUTO_INCREMENT,
    connection varchar(50) -- соединение
);

-- двигатель переменного тока
CREATE TABLE ac_motor
(
    id                  int PRIMARY KEY AUTO_INCREMENT,
    type                varchar(255), -- тип todo вынести
    power               int,          -- мощность
    voltage             int,          -- напряжение
    rated_current       int,          -- номинальный ток
    number_revolutions  int,          -- число оборотов
    rotor_voltage       int,          -- напряжение ротора
    rotor_current       int,          -- ток ротора
    phase_connection_id int,          -- ид соединения фаз
    number_output_ends  int,          -- количество  выводных концов
    type2               varchar(255), -- тип щеток и размер todo вынести
    front_bearing_id    int,          -- тип переднего подшипника
    rear_bearing_id     int,          -- тип заднего подшипника
    cos_f               int,          -- cos ф
    efficiency          int           -- КПД %
);

-- зарегестрированный двигатель переменного тока
CREATE TABLE reg_ac_motor
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    ac_motor_id          int,         -- ид двигателя переменного тока
    factory_id           int,         -- завод
    workshop_customer_id int,         -- ид цеха
    location_barno_id    int          -- ид расположежния барно
);

-- заказ на двигатель переменного тока
CREATE TABLE ac_motor_order
(
    id              bigint PRIMARY KEY AUTO_INCREMENT,
    order_number    int,          -- заказ
    reg_ac_motor_id int,          -- ид зарегестрированного двигателя переменного тока
    type_repair_id  int,          -- ид вида ремонта
    defect          varchar(500), -- примечание по неполадкам
    date_acceptance date,         -- дата приемки
    date_issue      date,         -- дата выдачи
    status_order_id int           -- ид статуса заказа
);

-- перечисление неисправностей двигателя переменного тока
CREATE TABLE malfunction_ac_motor_order
(
    malfunction_id    int,    -- ид неисправности
    ac_motor_order_id bigint, -- ид заказа на двигатель переменного тока
    PRIMARY KEY (malfunction_id, ac_motor_order_id)
);

-- ремонт двигателя переменного тока (для фиксации всех кто занимался ремонтом)
CREATE TABLE ac_motor_repair
(
    id                int PRIMARY KEY AUTO_INCREMENT,
    ac_motor_order_id bigint,      -- ид заказа на двигатель переменного тока
    repairman_id      int,         -- ид ремонтника
    repair_date       date,        -- дата ремонта
    note              varchar(300) -- примечание
);

