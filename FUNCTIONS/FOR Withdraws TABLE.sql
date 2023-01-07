--Добавить выплату
create function Add_Withdraw(_id_user bigint, _pay_type text, _rekvisits text) returns bool as $$
begin
	if ((select count(*) from withdraws where id_user = _id_user and is_done = true) = 0 AND
		(SELECT Count(*) FROM users WHERE id_user = _id_user) = 1) then 
		insert into withdraws (id_user, pay_type, rekvisits, date_time, is_done) values 
		(_id_user, _pay_type, _rekvisits, now(), false);
		return true;
	else
		return false;
	
	end if;
END;
$$ LANGUAGE plpgsql;
