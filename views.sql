USE steam;

DROP VIEW IF EXISTS pers_inf_users;
CREATE OR REPLACE VIEW pers_inf_users AS 
SELECT first_name, last_name, email, phone
FROM users;

DROP VIEW IF EXISTS full_inf_account;
CREATE OR REPLACE VIEW full_inf_account AS 
SELECT users.email, nickname, country, hometown
FROM users LEFT OUTER JOIN `profiles`
ON users.id = `profiles`.user_id ;

DROP VIEW IF EXISTS games_inf;
CREATE OR REPLACE VIEW games_inf AS 
SELECT games.name, games.game_developer, price, sale
FROM games LEFT OUTER JOIN shop
ON games.id = shop.id; 

DROP VIEW IF EXISTS from_mess_inf;
CREATE OR REPLACE VIEW from_mess_inf AS
SELECT users.first_name, body
FROM users RIGHT OUTER JOIN messages 
ON users.id = messages.from_user_id;

DROP VIEW IF EXISTS to_mess_inf;
CREATE OR REPLACE VIEW to_mess_inf AS
SELECT body, users.first_name 
FROM users RIGHT OUTER JOIN messages 
ON users.id = messages.to_user_id;


