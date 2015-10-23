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
