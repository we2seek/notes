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
