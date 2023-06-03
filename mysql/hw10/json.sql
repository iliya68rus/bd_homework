--добавление записи
INSERT INTO consumer (
    "full_name" ,
    "phone" ,
    "favorite"
)
VALUES(
    'Петров Алексей Иванович' ,
    '8(901)453-73-90' ,
    JSON_OBJECT(
        "color" , JSON_ARRAY("red" , "pink") ,
        "company" , JSON_ARRAY("543") ,
        "category" , JSON_ARRAY("32", "33" , "41")
    )
);

--выборка пользователей которые добавили компанию в избранное
SELECT *
FROM consumer
WHERE JSON_EXTRACT("favorite" , "$.company") = 543;