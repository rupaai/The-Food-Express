set serveroutput on;
CREATE OR REPLACE TRIGGER update_comment_trigger
BEFORE update
on commenta
FOR EACH ROW
WHEN (new.conum > 0)
DECLARE 
	com varchar2(30);
	
BEGIN
	select co into com from commenta where conum = :new.conum; 
	dbms_output.put_line('Comment before update is'|| TO_CHAR(com));
end;
/