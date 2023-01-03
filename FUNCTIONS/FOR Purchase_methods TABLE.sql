--Добавление типа оплаты
CREATE FUNCTION Add_Purchase_method(_title text, _description text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Purchase_methods WHERE _title = title) = 0 THEN
		INSERT INTO Purchase_methods (title, description) VALUES (_title, _description);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;