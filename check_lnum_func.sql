SET SERVEROUTPUT ON;
 create or replace function check_lnum_func(lname in location.lname%TYPE)
	return number
	is
   lnum number;
	begin
    select lnum into lnum from location where lname = lname;
	return lnum;

	
    commit;
end check_lnum_func;
/
