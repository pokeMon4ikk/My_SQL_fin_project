USE steam;

SELECT 
	first_name, 
	last_name 
FROM 
	users 
WHERE 
	id > 100;

SELECT 
	u.id AS user_id,
	u.first_name AS name 
FROM 
	users AS u;

SELECT 
	email 
FROM 
	users 
ORDER BY 
	first_name; 

SELECT 
	first_name 
FROM 
	users 
ORDER BY 
	last_name;

SELECT 
	nickname 
FROM 
	`profiles` 
WHERE 
	user_id > 500;

SELECT 
	* 
FROM 
	games 
WHERE 
	id BETWEEN 5 AND 10;

SELECT 
	* 
FROM 
	users 
WHERE 
	first_name LIKE 'À%';

SELECT 
	body 
FROM 
	messages 
WHERE 
	from_user_id >= 500;

SELECT 
	body 
FROM 
	messages
WHERE 
	from_user_id IN (SELECT id FROM users WHERE first_name LIKE 'À%'); 

SELECT 
	first_name, last_name, nickname 
FROM 
	users, `profiles` 
WHERE 
	users.id = `profiles`.user_id; 

SELECT  
	users.first_name, body
FROM  
	users LEFT OUTER JOIN messages 
ON 
	users.id = messages.from_user_id;


SELECT  
	users.first_name, body
FROM  
	users RIGHT OUTER JOIN messages 
ON 
	users.id = messages.from_user_id;

SELECT COUNT(id) FROM users;

SELECT COUNT(phone) FROM users WHERE phone LIKE '%926%';

SELECT id, COUNT(body) FROM messages GROUP BY id;

SELECT name FROM games WHERE name IN(SELECT name FROM shop WHERE price > 1000);

SELECT 
	from_user_id, users.first_name, body 
FROM 
	users 
RIGHT OUTER JOIN 
	messages 
ON 
	users.id = messages.from_user_id;
 
SELECT 
	to_user_id, users.first_name, body 
FROM 
	users 
RIGHT OUTER JOIN 
	messages 
ON 
	users.id = messages.to_user_id;















