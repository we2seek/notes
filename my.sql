--------------------------------
dump
--------------------------------
backup: 	shell> mysqldump -u root -p --databases db_name [db_name2] > dump.sql
restore:	shell> mysql -uroot -p < dump.sql
		mysql> source dump.sql
