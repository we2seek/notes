---------------------
        dump
---------------------
backup: 	shell> mysqldump -u root -p --databases db_name [db_name2] > dump.sql
restore:	shell> mysql -uroot -p < dump.sql
		mysql> source dump.sql

backup table	shell> mysqldump -u root -pInteger7_ db_name table_name > file_name.sql

Turn query result to the text file:
		SELECT * FROM product INTO OUTFILE '__product.txt' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

---------------------
  Queries Examples
---------------------

SELECT r.request_id, AVG(r.value) 
FROM rate r 
LEFT JOIN request2master rm ON r.request_id = rm.request_id 
WHERE rm.master_user_id = 15 AND r.question_id !='comment' 
GROUP BY r.request_id;

SELECT u.id, u.fio, ROUND(AVG(r.value), 2) AS avg
FROM rate r
LEFT JOIN request2master rm ON r.request_id = rm.request_id
LEFT JOIN user u ON rm.master_user_id = u.id
WHERE r.question_id != 'comment'
GROUP BY rm.master_user_id;

---------------------
SELECT r.id, r2m.master_user_id FROM request r 
LEFT JOIN request2master r2m ON r2m.request_id = r.id 
WHERE r2m.master_user_id IS NULL
OR r2m.master_user_id = 0
OR r2m.master_user_id = 20;

SELECT r.id AS ARRAY_KEY, r.*, 
	u.id AS user_id,
	u.phone,
	u.email,
	u.fio
FROM request AS r
LEFT JOIN user u ON r.user_id = u.id
LEFT JOIN request2master r2m ON r.id = r2m.request_id
WHERE r2m.master_user_id IS NULL
OR r2m.master_user_id = 0
OR r2m.master_user_id = 20;




=====================================================
=           Источник: Шпаргалка по MySQL            =
=       http://shapovalov.biz/mysql/base-command    =
=====================================================


Основные команды для работы с таблицей

--> Создать базу данных my_db
CREATE DATABASE my_db; 

--> Перейти на базу данных my_db
USE DATABASE my_db;

--> список баз данных
SHOW DATABASES;             

-->  список таблиц в базе 
SHOW TABLES [FROM db_name]; 

--> список всех столбцов в таблице
SHOW COLUMNS FROM таблица [FROM db_name]; 

--> показать структуру таблицы в формате "CREATE TABLE"
SHOW CREATE TABLE table_name; 
 

--> Создать таблицу
CREATE TABLE my_contacts         
(
    --> Поле:rows_0, тип:целое, длина:11, не пустое
    rows_0 INT(11) NOT NULL,     
    --> Поле:rows_1, тип:целое, длина:3, может быть (null), по умолчанию 1
    rows_1 TINYINT DEFAULT 1,    
    --> Поле:rows_2, тип:строка, длина:20
    rows_2 VARCHAR(20),          
    --> Поле:rows_3, тип:большие блоки текстовых данных
    rows_3 BLOB,                 
    --> Поле:rows_4, тип:Дата+Время
    rows_4 DATETIME,             
 
    PRIMARY KEY (rows_0, rows_1) --> составной первичный ключ из двух полей
);
 
--> Удаление таблицы my_contacts
DROP TABLE my_contacts; 
 
--> Посмотреть как выглядит таблица my_contacts, сокращенно от DESCRIBE
DESC my_contacts;                
 
--> Переименовать таблицу
ALTER TABLE projects             
    RENAME TO project_list
 
 
ALTER TABLE my_contacts
	--> добавить столбец
	ADD COLUMN `phone` VARCHAR (10)
	
	--> переименовать поле number в proj_id и установка типа,
	--> change позволяет изменить как имя, так и тип данных столбца
	CHANGE COLUMN number proj_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
	
	--> modify используется для изменения ТОЛЬКО типа данных
	MODIFY COLUMN phone INT(11)
	
	--> удалить столбец
	DROP   COLUMN phone
	
	--> добавить составной первичный ключ
	ADD    PRIMARY KEY (rows_0, rows_1);
	

Добавление новых данных
?INSERT INTO my_contacts ( столбец1, столбец2,   ...)
    --> Экранирование апострофа
    VALUES ('значение1', 'don\'t или don''t worry', ...); 


 

Обновление данных
?UPDATE your_table
   SET первый_столбец= 'новое_значение ',
      второй_столбец = 'старое_значение';
 
UPDATE movie_table
SET category =
CASE
    WHEN drama    = 'Д' THEN 'драма'
    WHEN comedy   = 'Д' THEN 'комедия'
    WHEN action   = 'Д' THEN 'боевик'
ELSE ' разное '
END;


 

Удаление записей
?DELETE FROM clown_info
       WHERE activities = 'yes';


 

Выборка данных
?SELECT
CASE product_one
     WHEN 25 THEN product_two
     ELSE product_one
     END AS result
FROM DDI.downloads_from 
WHERE product_one=25 OR product_two=25 ORDER BY count DESC LIMIT 5;
 
SELECT DISTINCT last_name, first_name, age  --> DISTINCT исключает дубликаты
    FROM my_contacts
    WHERE birthday [=,>=,<=,<>] '1975-09-05'
        --> Поиск first_name с текстом Verginiya
        AND first_name LIKE '%Verginiya%'
        --> Записи где first_name не NULL
        AND first_name IS NOT NULL
        --> Записи где поле age принемает значения от 5 до 10
        OR  age BETWEEN 5 AND 10
        --> Записи где age принимает значения (...)
        AND age NOT IN (1,2,3,4,5,6,7,8,9,) 
        --> Те записи у которых в списке интересов первым стоит животные
        AND SUBSTRING_INDEX (interests,',',1 ) = 'животные';
    GROUP BY first_name
    --> Двойная сортировка ASC и DESC(обратный порядок)
    ORDER BY first_name ASC, last_name DESC
    --> 30 записей начиная с нулевой
    LIMIT 0,30";
 
-->UNION объединяет результаты этих трех разных запросов в одну общую таблицу
-->UNION ALL работает точно так же, как UNION, если не считать того,
-->что он возвращает все значения из столбцов — вместо одного
-->экземпляра из каждой группы дубликатов.
SELECT title FROM job_current   
UNION
SELECT title FROM job_desired
UNION
SELECT title FROM job_listings;

 

Таблица, находящаяся в форме 1НФ, должна выполнять следующие два правила.
Каждая запись должна содержать N атомарные значения.
Каждая запись должна обладать уникальным идентификатором, который называется первичным ключом 

Таблица 1НФ находится в 2НФ, если все столбцы таблицы являются частью первичного ключа ИЛИ она имеет одностолбцовый первичный ключ. Вторая нормальная форма, или 2НФ:
Правило 1. Таблица находится в 1НФ. 
Правило 2. Таблица не имеет частичных функциональных зависимостей. 

Третья нормальная форма, или ЗНФ:
Правило 1. Таблица находится в 2НФ.
Правило 2. Таблица не имеет транзитивных зависимостей. Транзитивная функциональная зависимость означает наличие связей между не ключевыми столбцами.
