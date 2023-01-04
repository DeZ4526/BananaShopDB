--Взять заказ
CREATE FUNCTION Get_Order(_id_order bigint, _id_admin bigint) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Orders WHERE id_p_log = _id_order AND id_admin IS NULL) = 1
	THEN
		UPDATE Orders SET id_admin=_id_admin WHERE id_p_log = _id_order;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Выполнить заказ
CREATE FUNCTION Done_Order(_id_order bigint) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Orders WHERE id_p_log = _id_order) = 1
	THEN
		UPDATE Orders SET is_done=true WHERE id_p_log = _id_order;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Добавить заказ
CREATE FUNCTION Add_Order(_id_user int, _id_product int, _information text) RETURNS bool AS $$
DECLARE
    _id_ref bigint;
BEGIN
	IF ((SELECT Count(*) FROM users WHERE id_user = _id_user) = 1 AND
	   (SELECT Count(*) FROM Products WHERE _id_product = id_product) = 1 AND
	   (SELECT balance FROM Users WHERE id_user = _id_user) >= (SELECT price FROM Products WHERE _id_product = id_product)) THEN
		
		INSERT INTO Orders (id_user, id_product ,information, date_time, is_done) 
		VALUES 
		(_id_user, _id_product,_information, now(), false);
		
		_id_ref = (SELECT id_referral FROM Users WHERE id_user = _id_user);
		
		UPDATE Users SET 
		balance = balance - (SELECT price FROM Products WHERE _id_product = id_product)
		WHERE id_user = _id_user;
		
		RETURN Add_Balance_ref(_id_ref, 
							   CAST (_id_user AS text), 
							   ((SELECT price FROM Products WHERE _id_product = id_product)/ 100 * (SELECT ref_percent FROM Users WHERE id_user =_id_ref)));
		
		--!UPDATE Users SET 
		--balance = balance + (((SELECT price FROM Products WHERE _id_product = id_product))/ 100 * ref_percent), 
		--ref_balance = ref_balance + ((SELECT price FROM Products WHERE _id_product = id_product)/ 100 * ref_percent) 
		--WHERE id_user = (SELECT id_referral FROM Users WHERE id_user = _id_user);
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Пополнить баланс через реферальную систему 
CREATE FUNCTION Add_Balance_ref(_id_user bigint, _requisites text, _value numeric) RETURNS bool AS $$
DECLARE
    _first_add bool;
BEGIN
	IF (SELECT Count(*) FROM users WHERE id_user = _id_user) = 0 THEN
		RETURN false;
	END IF;
		IF (SELECT Count(*) FROM Balance_log WHERE id_user = _id_user) = 0  THEN
		_first_add = true;
	ELSE
		_first_add = false;
	END IF;
	
	IF(SELECT count(*) FROM Purchase_methods WHERE title='REFERAL_SYSTEM') = 0 THEN
		PERFORM Add_Purchase_method('REFERAL_SYSTEM', 'REFERAL_SYSTEM');
	END IF;
	
	INSERT INTO Balance_log (id_user, id_p_method ,requisites ,value ,description ,date_time,use_bonus, first_add) VALUES 
	(_id_user, (SELECT SUM(id_p_method) FROM Purchase_methods WHERE title='REFERAL_SYSTEM'),_requisites,_value,'REFERAL_SYSTEM', now(), false, _first_add);
	UPDATE users SET balance=balance+_value, ref_balance = ref_balance+_value WHERE id_user = _id_user;
	RETURN true;
END;
$$ LANGUAGE plpgsql;

--Пополнить баланс
CREATE FUNCTION Add_Balance(_id_user int, id_purchase_method int, _requisites text, _value numeric, _description text, use_bonus bool) RETURNS bool AS $$
DECLARE
    _first_use bool;
BEGIN
	IF ((SELECT Count(*) FROM users WHERE id_user = _id_user) = 0 AND
	   (SELECT Count(*) FROM Purchase_methods WHERE id_purchase_method = id_p_method) = 0) THEN
		RETURN false;
	END IF;
	IF (SELECT Count(*) FROM Balance_log WHERE id_user = _id_user) = 0  THEN
		_first_use = true;
	ELSE
		_first_use = false;
	END IF;
	
	IF (use_bonus = false) THEN
		INSERT INTO Balance_log (id_user, id_p_method ,requisites ,value ,description ,date_time,use_bonus, first_add) VALUES 
		(_id_user, id_purchase_method,_requisites,_value,_description, now(), false, _first_use);
		UPDATE users SET balance=balance+_value, pur_balance = pur_balance+_value WHERE id_user = _id_user;
		RETURN true;
	END IF;
	IF (SELECT Sum(bonus) FROM users WHERE id_user = _id_user) > 0 AND use_bonus THEN
		INSERT INTO Balance_log (id_user, id_p_method ,requisites ,value ,description ,date_time, use_bonus, first_add) VALUES 
		(_id_user, id_purchase_method,_requisites,_value + (_value / 100 * 10),_description, now(), true, _first_use);
		UPDATE users SET 
			balance=balance + _value + (_value / 100 * 10), 
			pur_balance = pur_balance+_value + (_value / 100 * 10), 
			bonus=bonus - 1 
			WHERE id_user = _id_user;
	ELSE
		RETURN false;
	END IF;
	RETURN true;
END;
$$ LANGUAGE plpgsql;