--По всем пополнениям
SELECT AVG(value) FROM Balance_log;

--По первым пополнениям пополнениям
SELECT AVG(value) FROM Balance_log WHERE first_add=true;

--По первым пополнениям пополнениям рефералов
SELECT AVG(value) FROM Balance_log
INNER JOIN Users ON Balance_log.id_user=Users.id_user 
WHERE Users.id_referral IS NOT NULL AND first_add=true;

--По первым пополнениям пополнениям не рефералов
SELECT AVG(value) FROM Balance_log
INNER JOIN Users ON Balance_log.id_user=Users.id_user 
WHERE Users.id_referral IS NULL AND first_add=true;

--По реферальным пополнениям от пользователя определенного типа
SELECT AVG(value) FROM Balance_log
INNER JOIN Users ON Balance_log.id_user=Users.id_user 
WHERE Users.id_referral IS NOT NULL AND Users.id_type=3;

--По нереферальным пополнениям от пользователя определенного типа
SELECT AVG(value) FROM Balance_log
INNER JOIN Users ON Balance_log.id_user=Users.id_user 
WHERE Users.id_referral IS NULL AND Users.id_type=3;

--По пополнениям пополнениям не рефералов
SELECT AVG(value) FROM Balance_log
INNER JOIN Users ON Balance_log.id_user=Users.id_user 
WHERE Users.id_referral IS NULL;
SELECT * FROM User_types

--Сколько было потрачено на бонусы
SELECT (SUM(value) / 100) * 10 FROM Balance_log
WHERE use_bonus = true;