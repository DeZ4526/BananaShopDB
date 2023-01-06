--Добавить пользователя
CREATE FUNCTION Add_User(_id_user bigint, _login text, user_type int, _balance numeric, _bonus int, _ref_percent int) RETURNS bool AS $$
BEGIN
	IF ((SELECT Count(*) FROM Users WHERE _login = login) = 0 AND 
		(SELECT Count(*) FROM User_types WHERE id_type = user_type) = 1) THEN
		INSERT INTO Users (id_user,login, id_type, balance, bonus, ref_percent, ref_balance, pur_balance) VALUES 
		(_id_user,_login, user_type, _balance,_bonus, _ref_percent, 0, 0);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Добавить пользователя с реферальной ссылки
CREATE FUNCTION Add_User(_id_user bigint,_login text, user_type int, _balance numeric, _bonus int, _id_referral int, _ref_percent int) RETURNS bool AS $$
BEGIN
	IF ((SELECT Count(*) FROM Users WHERE _login = login) = 0 AND 
		(SELECT Count(*) FROM Users WHERE id_user = _id_referral) = 1 AND
	   	(SELECT Count(*) FROM User_types WHERE id_type = user_type) = 1) THEN
		INSERT INTO Users (id_user, login, id_type, balance, bonus, id_referral,ref_percent, ref_balance,  pur_balance) VALUES 
		(_id_user, _login, user_type, _balance,_bonus, _id_referral, _ref_percent, 0, 0);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION Edit_Precent_RS(_id_user bigint, _ref_percent int) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Users WHERE id_user = _id_user) = 1  THEN
		UPDATE Users SET ref_percent = _ref_percent WHERE id_user = _id_user;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;