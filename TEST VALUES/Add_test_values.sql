--Заполнение таблиц
--Добавление типов пользователей
SELECT Add_User_type('Admin', 'abc');
SELECT Add_User_type('Partner', 'a');
SELECT Add_User_type('User', '');
SELECT * FROM User_types;

--Добавление категорий товаров
SELECT Add_Product_category('Fortnite', 'Fortnite');
SELECT Add_Product_category(1, 'Наборы', 'Fortnite');
SELECT Add_Product_category(2, 'В-Баксы', 'Fortnite');
SELECT Add_Product_category(1, 'Test', 'Fortnite');
SELECT Add_Product_category(2, 'Test2', 'Fortnite');
SELECT Add_Product_category(2, 'Test3', 'Fortnite');
SELECT Add_Product_category(2, 'Test4', 'Fortnite');
SELECT * FROM Product_categories;

--Добавление продуктов
SELECT Add_Product('Бакс', 100, 3);
SELECT Add_Product('Тест', 50, 3);
SELECT Add_Product('Набор 1', 50, 2);
SELECT Add_Product('Набор 2', 100, 2);
SELECT Add_Product('Набор 3', 150, 13);
SELECT * FROM Products;

SELECT Add_Purchase_method('VISA', 'Card');
SELECT Add_Purchase_method('MIR', 'Card');
SELECT Add_Purchase_method('Qiwi', 'On-line');
SELECT * FROM Purchase_methods;

--Добавление пользователей
SELECT Add_User(1,'admin', 1, 1000, 10, 10);
SELECT Add_User(2,'moder', 2, 0, 1, 10);
SELECT Add_User(3,'user', 3, 0, 1, 10);
SELECT Add_User(4,'user_1', 3, 0, 1, 10);
SELECT Add_User(5,'user_2', 3, 0, 1, 10);
SELECT Add_User(6,'user_3', 3, 0, 1, 10);
SELECT Add_User(7,'user_4', 3, 0, 1, 4, 10);
SELECT Add_User(8,'user_5', 3, 0, 1, 4, 10);
SELECT Add_User(9,'user_6', 3, 0, 1, 4, 10);
SELECT Add_User(10,'user_7', 3, 0, 1, 5, 10);
SELECT Add_User(11,'user_8', 3, 0, 1, 5, 10);
SELECT Add_User(12,'user_9', 3, 0, 1, 5, 10);
SELECT Add_User(13,'user_10', 3, 0, 1000, 5, 10);
SELECT * FROM Users;


SELECT Add_Balance(11, 1, 'TEST1', 1005, 'login: 1123, pass:1111', false);
SELECT Add_Order(11, 1, 'login: 1123, pass:1111');
SELECT * FROM Orders;
SELECT * FROM Balance_log;