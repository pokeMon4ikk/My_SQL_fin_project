USE steam;

-- PROCEDURES

-- check status of the game for user

DROP PROCEDURE IF EXISTS own_games_info;
DELIMITER //
CREATE PROCEDURE own_games_info (gameS_name VARCHAR(255))
BEGIN 
	SELECT user_id, `status`
	FROM user_games
	WHERE gameS_name = game_name;
END //
DELIMITER ;

CALL own_games_info('Kingdom Come: Deliverance');

-- add new games

DROP PROCEDURE IF EXISTS add_new_games;
DELIMITER //
CREATE PROCEDURE add_new_games (nam VARCHAR(255), dev VARCHAR(255), gen VARCHAR(255))
BEGIN
	INSERT INTO games (name, genre, game_developer) VALUES (nam, gen, dev);
END //
DELIMITER ;

CALL add_new_games('Night of the Dead', 'Action, Adventure, Indie, Simulation, Early Access', 'jacktostudios');

SELECT * FROM games;

-- TRIGGERS

-- check name and surname are not NULL 

DROP TRIGGER IF EXISTS checkTrigger;
DELIMITER //
CREATE TRIGGER checkTrigger BEFORE INSERT ON users FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.first_name)) THEN
		SET NEW.first_name = 'No Name';
	END IF;
	IF(ISNULL(NEW.last_name)) THEN
		SET NEW.last_name = 'No Surname';
	END IF;
END //
DELIMITER ;

INSERT INTO users (first_name, last_name, email, phone)
VALUES (NULL, NULL, 'Kuzmaking@mail,ru', '891654531323');


-- Make the all literas UPPER

DROP TRIGGER IF EXISTS makeliteraUPPER;
DELIMITER //
CREATE TRIGGER makeliteraUPPER BEFORE INSERT ON games FOR EACH ROW 
BEGIN
    	SET NEW.name = UPPER(NEW.name);
END //
DELIMITER ;

INSERT INTO games (`name`) VALUES ('cs:go');







