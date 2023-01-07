
--Таблица типов пользователей и их разрешений
CREATE TABLE User_types
( 
	id_type SERIAL NOT NULL PRIMARY KEY,
  	name text NOT NULL,
  	permissions text
);

--Таблица пользователей
CREATE TABLE Users
(
	id_user bigint NOT NULL PRIMARY KEY, --id пользователя в ТГ
	id_type int NOT NULL, --тип из списка типов
	id_referral int, --id того, от кого реферальная ссылка
	login text, --username пользователя
  	balance numeric NOT NULL, --баланс
	pur_balance numeric NOT NULL, --баланс от пополнений
	bonus int, --Использовать бонус 10% к пополнению (кол-во бонусов)
	date_time timestamp not NULL
	ref_balance numeric NOT NULL, --баланс от рефералов
	ref_percent int NOT NULL, --процент от покупок рефералов
	FOREIGN KEY(id_type) REFERENCES User_types(id_type),
	FOREIGN KEY(id_referral) REFERENCES Users(id_user)
);

--Таблица категорий товаров
CREATE TABLE Product_categories
( 
	id_category SERIAL NOT NULL PRIMARY KEY,
	id_category_top int,
  	title text NOT NULL,
  	description text
);
--Таблица товаров
CREATE TABLE Products
( 
	id_product SERIAL NOT NULL PRIMARY KEY,
	id_category int NOT NULL,
  	title text NOT NULL,
	description text,
  	price numeric,
	FOREIGN KEY(id_category) REFERENCES Product_categories(id_category)
);

--Таблица методов пополнения баланса
CREATE TABLE Purchase_methods
( 
	id_p_method SERIAL NOT NULL PRIMARY KEY,
  	title text NOT NULL,
  	description text
);

--Таблица пополнения баланса
CREATE TABLE Balance_log
( 
	id_b_log SERIAL NOT NULL PRIMARY KEY,
	id_user bigint NOT NULL,
	id_p_method int NOT NULL, --id метода пополнения
  	requisites text NOT NULL, --реквизиты пополнения
	date_time timestamp NOT NULL,
  	value numeric, --значение пополнения
	description text, --описание
	use_bonus bool NOT NULL,
	first_add bool NOT NULL,
	FOREIGN KEY(id_user) REFERENCES Users(id_user),
	FOREIGN KEY(id_p_method) REFERENCES Purchase_methods(id_p_method)
);
--Таблица покупок
CREATE TABLE Orders
( 
	id_p_log SERIAL NOT NULL PRIMARY KEY,
	id_user bigint NOT NULL, --id пользователя, что сделал заказ
	id_product int NOT NULL, --id продукта
  	information text NOT NULL, --информация о заказе
	date_time timestamp NOT NULL, --дата заказа
  	is_done bool, --статус заказа выполнен/не выполнен
	id_admin bigint, --id админа, что взял заказ
	FOREIGN KEY(id_user) REFERENCES Users(id_user),
	FOREIGN KEY(id_product) REFERENCES Products(id_product)
);

--таблица вывода средств
create table Withdraws
(
	id_w_log SERIAL not null primary key,
	id_user BIGINT not null,
	pay_type text not null,
	rekvisits text not null,
	value numeric not null,
	id_operator bigint default 0,
	date_time timestamp not null,
	is_done bool,
	FOREIGN KEY(id_user) REFERENCES Users(id_user)
);
