DROP DATABASE IF EXISTS steam;
CREATE DATABASE steam;
USE steam;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(100),
	email VARCHAR(120) UNIQUE,
	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED UNIQUE,
	
	INDEX users_fstnam_lstnam_idx(first_name, last_name)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
	id SERIAL,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media (
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),    	
    SIZE INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`(
	user_id SERIAL,
	nickname CHAR(20) NOT NULL,
	gender CHAR(1),
	birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    country VARCHAR(50),
    hometown VARCHAR(50),
    
    FOREIGN KEY (photo_id) REFERENCES media(id)
);
  
ALTER TABLE `profiles` ADD CONSTRAINT user_id_fK
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON UPDATE CASCADE 
    ON DELETE RESTRICT;
    
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended', 'followed'),
    
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, 
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

ALTER TABLE friend_requests 
ADD CHECK(initiator_user_id <> target_user_id);

DROP TABLE IF EXISTS games;
CREATE TABLE games (
	id SERIAL,
	name VARCHAR(255),
	game_developer VARCHAR(255),
	available_from DATE,
	genre VARCHAR(255),
	
	INDEX game_name_idx(name)
);

DROP TABLE IF EXISTS shop;
CREATE TABLE shop(
	id SERIAL,
	name VARCHAR(255),
	price BIGINT,
	sale DECIMAL(5,2),
	
	FOREIGN KEY (id) REFERENCES games(id),
	FOREIGN KEY (name) REFERENCES games(name)
);
   
DROP TABLE IF EXISTS user_games;
CREATE TABLE user_games (
	user_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	game_name VARCHAR(255),
	`status` ENUM('free download', 'purchased', 'in the wish list', 'not purchased', 'followed'),
	
	PRIMARY KEY (user_id, game_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (game_name) REFERENCES games(name)
);

DROP TABLE IF EXISTS user_workshop;
CREATE TABLE user_workshop (
	id SERIAL,
	works_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	filename VARCHAR(255),
	SIZE INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (works_type_id) REFERENCES media_types(id) 
);

DROP TABLE IF EXISTS games_market;
CREATE TABLE games_market(
	id_item BIGINT UNSIGNED NOT NULL,
	category VARCHAR(50),
	game VARCHAR(255),
	price BIGINT,
	
	FOREIGN KEY (game) REFERENCES games(name)
);





    
	
	
	
	



