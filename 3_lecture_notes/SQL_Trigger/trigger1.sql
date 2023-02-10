
DELIMITER //
create trigger tr1
before insert on Event
for each row
	begin
		INSERT INTO Prizes (prizeid, prize_money, eventid, rank1, yr)
    		VALUES (NULL, 1500, NEW.eventid, 1, YEAR(CURRENT_TIMESTAMP));
    
	end;
	 //

DELIMITER ;

