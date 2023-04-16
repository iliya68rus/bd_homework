-- написать запрос суммы очков с группировкой и сортировкой по годам
SELECT year_game, sum(points)
FROM statistic
GROUP BY year_game
ORDER BY year_game;


-- написать cte показывающее тоже самое
WITH "group" AS (SELECT year_game, sum(points)
                 FROM statistic
                 GROUP BY year_game
                 ORDER BY year_game)
SELECT *
FROM "group";


-- используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий.
WITH "group" AS (SELECT player_name,
                        points::int                                              AS current_year,
                        year_game,
                        lag(points, 1, 0) OVER (ORDER BY player_name, year_game) AS last_year
                 FROM statistic)
SELECT player_name, current_year, last_year
FROM "group"
WHERE year_game = '2020';