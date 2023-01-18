--Operator
CREATE USER Operator WITH PASSWORD 'myPassword';
GRANT SELECT ON User_types TO Operator;
GRANT SELECT, UPDATE(balance, ref_balance) ON Users TO Operator;
GRANT SELECT ON Product_categories TO Operator;
GRANT SELECT ON Products TO Operator;
GRANT SELECT ON Purchase_methods TO Operator;
GRANT SELECT, INSERT, UPDATE ON Balance_log TO Operator;
GRANT SELECT, INSERT, UPDATE ON Orders TO Operator;
GRANT SELECT ON Withdraws TO Operator;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO Operator;
--Admin
CREATE USER master_banan WITH PASSWORD 'myPassword';
GRANT SELECT, INSERT, UPDATE ON User_types TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Users TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Product_categories TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Products TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Purchase_methods TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Balance_log TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Orders TO master_banan;
GRANT SELECT, INSERT, UPDATE ON Withdraws TO master_banan;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO master_banan;

--Удалить роль
REVOKE ALL ON DATABASE bananashop FROM Operator;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM Operator;
drop user Operator;
--Просмотреть роли
SELECT * FROM pg_user;