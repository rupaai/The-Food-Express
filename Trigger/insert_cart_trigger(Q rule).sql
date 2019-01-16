set serveroutput on;
CREATE OR REPLACE TRIGGER insert_cart_trigger
BEFORE insert 
on selectionCart
FOR EACH ROW
WHEN (new.unum > 0)
DECLARE 
	total number;
	
BEGIN
	select sum(price) into total from selectionCart where unum = :new.unum; 
	dbms_output.put_line('Total for id'||:new.unum || ' = '||total);
end;
/