--Добавление нового типа продукта
CREATE FUNCTION Add_Product_category(_title text, _description text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Product_categories WHERE title = _title) = 0 THEN
		INSERT INTO Product_categories (title, description) VALUES (_title, _description);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;
--Добавление нового подтипа продукта 
CREATE FUNCTION Add_Product_category(_id_category_top int, _title text, _description text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Product_categories WHERE title = _title) = 0 THEN
		INSERT INTO Product_categories (id_category_top, title, description) VALUES (_id_category_top,_title, _description);
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION Dell_Product_category(_title text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Product_categories WHERE title = _title) = 1 THEN
		DELETE FROM Products WHERE id_category = (SELECT id_category FROM Product_categories WHERE title = _title);
		DELETE FROM Product_categories WHERE title = _title;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;

--Изменить заголовок категории продуктов
CREATE FUNCTION Set_Title_ProductCategory(_id_category int, new_title text) RETURNS bool AS $$
BEGIN
	IF (SELECT Count(*) FROM Product_categories WHERE id_category = _id_category) = 1
	THEN
		UPDATE Product_categories SET title=new_title WHERE id_category = _id_category;
		RETURN true;
	ELSE
		RETURN false;
	END IF;
END;
$$ LANGUAGE plpgsql;