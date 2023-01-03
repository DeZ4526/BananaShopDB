--Добавление нового типа пользователя
CREATE FUNCTION Add_User_type(_name text, _permissions text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM User_types WHERE name = _name) = 0 THEN
		INSERT INTO User_types (name, permissions) VALUES (_name, _permissions);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Удалениe типа пользователя
CREATE FUNCTION Dell_User_type(_name text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM User_types WHERE name = _name) = 1 THEN
		DELETE FROM User_types WHERE name = _name; 
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql; 

--Изменить тип пользователя
CREATE FUNCTION Change_User_type(userId bigint, UserType text) RETURNS bool AS $$
BEGIN
	IF ((SELECT Count(*) FROM User_types WHERE name = UserType) = 1 AND 
	(SELECT Count(*) FROM Users WHERE Users.id_user = userId) = 1)
	THEN
		UPDATE Users SET id_type=(SELECT id_type FROM User_types WHERE name = UserType) WHERE id_user = userId;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;