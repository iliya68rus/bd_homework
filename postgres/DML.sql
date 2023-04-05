-- Запрос с регуляркой для поиска покупателей с счасливых регионом для выдаки купона
SELECT *
FROM consumer c
WHERE phone SIMILAR TO '__9(8|0)[1,2,5]%';


SELECT *
FROM product p
         LEFT JOIN category c ON p.category_id = c.id
         JOIN company com ON p.maker_id = com.id;


INSERT INTO company (name, phone, email, type)
VALUES ('Test', '8(902)234-21-33', 'test@test.ru', 'MAKER')
RETURNING id;


UPDATE category
SET name = 'BY ' || c.name
FROM category cat
         JOIN product p ON cat.id = p.category_id
         JOIN company c ON p.maker_id = c.id
WHERE c.type = 'MAKER';


DELETE
FROM consumer c
    USING purchase p
WHERE c.id = p.consumer_id
  AND p.date < now();



