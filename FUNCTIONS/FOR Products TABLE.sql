--Добавление продукта
CREATE FUNCTION Add_Product(_title text,_description text, _price numeric, category int) RETURNS bool AS $$
BEGIN
	IF ((SELECT Count(*) FROM Product_categories WHERE id_category = category) = 1 AND
	   (SELECT Count(*) FROM Products WHERE title = _title) = 0
	   )THEN
		INSERT INTO Products (title, price, description, id_category) VALUES (_title, _price, _description, category);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION Dell_Product(_title text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Products WHERE title = _title) = 1 THEN
		DELETE FROM Products WHERE title = _title;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Изменить цену товара
CREATE FUNCTION Set_Price(_id_product int, new_price numeric) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Products WHERE id_product = _id_product) = 1
	THEN
		UPDATE Products SET price=new_price WHERE id_product = _id_product;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Изменить описание товара
CREATE FUNCTION Set_Description_Product(_id_product int, new_des text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Products WHERE id_product = _id_product) = 1
	THEN
		UPDATE Products SET description=new_des WHERE id_product = _id_product;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Изменить заголовок товара
CREATE FUNCTION Set_Title_Product(_id_product int, new_title text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Products WHERE id_product = _id_product) = 1
	THEN
		UPDATE Products SET title=new_title WHERE id_product = _id_product;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Добавить картинку
CREATE FUNCTION Set_JSON_IMG_Product(_id_product int, _json text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Products WHERE id_product = _id_product) = 1
	THEN
		UPDATE Products SET json_img=_json WHERE id_product = _id_product;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;