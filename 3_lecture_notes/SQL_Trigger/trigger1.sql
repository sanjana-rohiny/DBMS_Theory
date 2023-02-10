
DELIMITER //
create trigger tr1
before insert on Staff
for each row
	begin
		if (new.salary < 5000) then
			signal sqlstate '45000' set message_text = 'Error..! min salary should be > 5000 : Transation NOT Allowed...! ';
		end if
	end //

DELIMITER ;

