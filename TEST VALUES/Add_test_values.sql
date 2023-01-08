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
SELECT Add_Product('Бакс','Бакс' ,100, 3);
SELECT Add_Product('Тест','Бакс', 50, 3);
SELECT Add_Product('Набор 1','Бакс', 50, 2);
SELECT Add_Product('Набор 2','Бакс', 100, 2);
SELECT Add_Product('Набор 3','Бакс', 150, 13);
SELECT * FROM Products;

SELECT Add_Purchase_method('VISA', 'Card');
SELECT Add_Purchase_method('MIR', 'Card');
SELECT Add_Purchase_method('Qiwi', 'On-line');
SELECT * FROM Purchase_methods;

--Добавление пользователей
SELECT Add_User(1, 1,'admin', 1000, 10, 10);
SELECT Add_User(2, 2,'moder', 0, 1, 10);
SELECT Add_User(3, 3,'user', 0, 1, 10);
SELECT Add_User(4, 3, 'user_1', 0, 1, 10);
SELECT Add_User(5, 3, 'user_2', 0, 1, 10);
SELECT Add_User(6, 3, 'user_3', 0, 1, 10);
SELECT Add_User(7, 3, 'user_4', 0, 1, 4, 10);
SELECT Add_User(8, 3, 'user_5', 0, 1, 4, 10);
SELECT Add_User(9, 3, 'user_6', 0, 1, 4, 10);
SELECT Add_User(10, 3,'user_7', 0, 1, 5, 10);
SELECT Add_User(11, 3,'user_8', 0, 1, 5, 10);
SELECT Add_User(12, 3,'user_9', 0, 1, 5, 10);
SELECT Add_User(13, 3,'user_10', 0, 1000, 5, 10);
SELECT * FROM Users;


SELECT Add_Balance(13, 1, 'TEST1', 1005, 'login: 1123, pass:1111', true);
SELECT Add_Order(13, 1, 'login: 1123, pass:1111');
SELECT Get_Order(2, 1);
SELECT Done_Order(1);
SELECT * FROM Orders;
SELECT * FROM Balance_log;
