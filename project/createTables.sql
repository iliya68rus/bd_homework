-- производитель
CREATE TABLE manufacturer
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- неисправность (щетки, подшипник, вал, обмотка)
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
    fk_worker                 bigint -- ид работника из общей базы компании
);

-- перечисление какие неисправности может исправить ремонтник
CREATE TABLE malfunction_repairman
(
    fk_malfunction int,    -- ид неисправности
    fk_repairman   bigint, -- ид ремонтника
    estimation     int,    -- оценка от 1 до 10
    PRIMARY KEY (fk_malfunction, fk_repairman)
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
    fk_responsible_worker bigint-- ид ответственного работника из общей базы компании
);

-- щётки
CREATE TABLE electric_motor_brushes
(
    id              int PRIMARY KEY AUTO_INCREMENT,
    fk_manufacturer int,        -- производитель
    article         varchar(50) -- артикль
);

-- подшипник
CREATE TABLE bearing
(
    id              int PRIMARY KEY AUTO_INCREMENT,
    fk_manufacturer int,        -- производитель
    article         varchar(50) -- артикль
);

-- вид возбуждения (параллельное, последовательное, смешанное)
CREATE TABLE type_motor_excitation
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- тип трансформатора
CREATE TABLE type_transformer
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- трансформатор
CREATE TABLE transformer
(
    id                  int PRIMARY KEY AUTO_INCREMENT,
    fk_type_transformer int, -- ид типа трансформатора
    power               int, -- мощность
    voltage_h           int, -- напряжение ВН (высокое напряжение)
    voltage_l           int  -- напряжение НН (низкое напряжение)
);

-- зарегистрированный трансформатор
CREATE TABLE reg_transformer
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    fk_transformer       int,         -- ид трансформатора
    fk_factory           int,         -- завод
    fk_workshop_customer int          -- ид цеха
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
    fk_reg_transformer int,          -- ид зарегистрированного трансформатора
    fk_type_repair     int,          -- ид вида ремонта
    defect             varchar(500), -- примечание по неполадкам
    date_acceptance    date,         -- дата приемки
    date_issue         date,         -- дата выдачи
    fk_status_order    int           -- ид статуса заказа
);

-- перечисление неисправностей трансформатора
CREATE TABLE malfunction_transformer_order
(
    fk_malfunction       int,    -- ид неисправности
    fk_transformer_order bigint, -- ид заказа на трансформатор
    PRIMARY KEY (fk_malfunction, fk_transformer_order)
);

-- ремонт трансформатора (для фиксации всех кто занимался ремонтом)
CREATE TABLE transformer_repair
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    fk_transformer_order bigint,      -- ид заказа на трансформатор
    fk_repairman         int,         -- ид ремонтника
    repair_date          date,        -- дата ремонта
    note                 varchar(300) -- примечание
);

-- тип двигателя
CREATE TABLE type_motor
(
    id   int PRIMARY KEY AUTO_INCREMENT,
    name varchar(255) -- название
);

-- двигатель постоянного тока
CREATE TABLE dc_motor
(
    id                        int PRIMARY KEY AUTO_INCREMENT,
    fk_type_motor             int, -- ид типа двигателя
    power                     int, -- мощность
    inductor_voltage          int, -- напряжение индуктора
    inductor_current          int, -- ток индуктора
    number_revolutions        int, -- число оборотов
    armature_voltage          int, -- напряжение якоря
    armature_current          int, -- ток якоря
    fk_type_motor_excitation  int, -- ид вида возбуждения
    excitation_voltage        int, -- напряжение возбуждения
    excitation_current        int, -- ток возбуждения
    number_output_ends        int, -- количество  выводных концов
    fk_electric_motor_brushes int, -- ид щеток
    fk_drive_side_bearing     int, -- ид типа подшипника со стороны привода
    fk_collector_side_bearing int, -- ид типа подшипника со стороны коллектора
    efficiency                int  -- КПД %
);

-- зарегистрированный двигатель постоянного тока
CREATE TABLE reg_dc_motor
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    fk_dc_motor          int,         -- ид двигателя постоянного тока
    fk_factory           int,         -- завод
    fk_workshop_customer int          -- ид цеха
);

-- заказ на двигатель постоянного тока
CREATE TABLE dc_motor_order
(
    id              bigint PRIMARY KEY AUTO_INCREMENT,
    order_number    int,          -- заказ
    fk_reg_dc_motor int,          -- ид зарегистрированного двигателя постоянного тока
    fk_type_repair  int,          -- ид вида ремонта
    defect          varchar(500), -- примечание по неполадкам
    date_acceptance date,         -- дата приемки
    date_issue      date,         -- дата выдачи
    fk_status_order int           -- ид статуса заказа
);

-- перечисление неисправностей двигателя постоянного тока
CREATE TABLE malfunction_dc_motor_order
(
    fk_malfunction    int,    -- ид неисправности
    fk_dc_motor_order bigint, -- ид заказа на двигатель постоянного тока
    PRIMARY KEY (fk_malfunction, fk_dc_motor_order)
);

-- ремонт двигателя постоянного тока (для фиксации всех кто занимался ремонтом)
CREATE TABLE dc_motor_repair
(
    id                int PRIMARY KEY AUTO_INCREMENT,
    fk_dc_motor_order bigint,      -- ид заказа на двигатель постоянного тока
    fk_repairman      int,         -- ид ремонтника
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
    id                        int PRIMARY KEY AUTO_INCREMENT,
    fk_type_motor             int, -- ид типа двигателя
    power                     int, -- мощность
    voltage                   int, -- напряжение
    rated_current             int, -- номинальный ток
    number_revolutions        int, -- число оборотов
    rotor_voltage             int, -- напряжение ротора
    rotor_current             int, -- ток ротора
    fk_phase_connection       int, -- ид соединения фаз
    number_output_ends        int, -- количество  выводных концов
    fk_electric_motor_brushes int, -- ид щеток
    fk_front_bearing          int, -- тип переднего подшипника
    fk_rear_bearing           int, -- тип заднего подшипника
    cos_f                     int, -- cos ф
    efficiency                int  -- КПД %
);

-- зарегистрированный двигатель переменного тока
CREATE TABLE reg_ac_motor
(
    id                   int PRIMARY KEY AUTO_INCREMENT,
    serial_number        varchar(20), -- серийный номер
    inventory_number     varchar(20), -- инвентарный номер
    fk_ac_motor          int,         -- ид двигателя переменного тока
    fk_factory           int,         -- завод
    fk_workshop_customer int,         -- ид цеха
    fk_location_barno    int          -- ид расположения барно
);

-- заказ на двигатель переменного тока
CREATE TABLE ac_motor_order
(
    id              bigint PRIMARY KEY AUTO_INCREMENT,
    order_number    int,          -- заказ
    fk_reg_ac_motor int,          -- ид зарегистрированного двигателя переменного тока
    fk_type_repair  int,          -- ид вида ремонта
    defect          varchar(500), -- примечание по неполадкам
    date_acceptance date,         -- дата приемки
    date_issue      date,         -- дата выдачи
    fk_status_order int           -- ид статуса заказа
);

-- перечисление неисправностей двигателя переменного тока
CREATE TABLE malfunction_ac_motor_order
(
    fk_malfunction    int,    -- ид неисправности
    fk_ac_motor_order bigint, -- ид заказа на двигатель переменного тока
    PRIMARY KEY (fk_malfunction, fk_ac_motor_order)
);

-- ремонт двигателя переменного тока (для фиксации всех кто занимался ремонтом)
CREATE TABLE ac_motor_repair
(
    id                int PRIMARY KEY AUTO_INCREMENT,
    fk_ac_motor_order bigint,      -- ид заказа на двигатель переменного тока
    fk_repairman      int,         -- ид ремонтника
    repair_date       date,        -- дата ремонта
    note              varchar(300) -- примечание
);

