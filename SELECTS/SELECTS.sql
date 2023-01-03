--SELECTS FOR ADMIN PANEL
--Пользователи
SELECT id_user, login, balance, pur_balance ,ref_balance, ref_percent,name, id_referral FROM Users
JOIN User_types ON User_types.id_type = Users.id_type;
--Пополнение баланса
SELECT id_b_log,Users.id_user, Users.login, value, Purchase_methods.title, requisites, date_time, Users.id_referral, use_bonus,Balance_log.description 
FROM Balance_log 
JOIN Users ON Balance_log.id_user = Users.id_user
JOIN Purchase_methods ON Purchase_methods.id_p_method = Balance_log.id_p_method;

--Заказы
SELECT id_p_log,Orders.id_user,login, Orders.number * Products.Price ,Products.title,Orders.number,Orders.date_time,Orders.is_done, Orders.information FROM Orders
JOIN Users ON Orders.id_user = Users.id_user
JOIN Products ON Orders.id_product = Products.id_product

--Управление ролями
SELECT id_user, login, name, id_referral FROM Users
JOIN User_types ON User_types.id_type = Users.id_type;
SELECT id_user, login, balance, pur_balance ,ref_balance, ref_percent,name, id_referral FROM Users JOIN User_types ON User_types.id_type = Users.id_type;


SELECT id_user, login, balance, pur_balance ,ref_balance, ref_percent,name, id_referral FROM
Users JOIN User_types ON User_types.id_type = Users.id_type;

SELECT id_category, id_category_top, title, description FROM Product_categories;

SELECT id_product, id_category, title, price FROM Products;
