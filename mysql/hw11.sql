--inner join
SELECT *
FROM purchase p
    INNER JOIN consumer c
        ON p.consumer_id = c.id;

--left join
SELECT *
FROM product p
    LEFT JOIN category c
        ON p.category_id = c.id;


--5 запросв с where
--1.получение продуктов дороже 500 руб.
SELECT *
FROM product p
    LEFT JOIN category c
        ON p.category_id = c.id
WHERE p.price > 500.00;

--2.поиск необходимых компаний
SELECT *
FROM company c
WHERE c.name IN ('ОАО Вихрь', 'ООО Надежда');

--3.получение компания с определенным кодом города в телефоне
SELECT *
FROM company c
WHERE c.phone LIKE '%(901)%';

--4.получение товаров без категории
SELECT *
FROM product p
WHERE p.category_id IS NULL;

--5.получение сегодняшних покупок
SELECT *
FROM purchase p
WHERE p.date = now();