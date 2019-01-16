set serveroutput on;
set verify off;

create or replace procedure db_profile_estimator
	is
	cursor cur is 
	select object_name from dba_objects
	where object_type = 'TABLE'
	and owner = 'SYSTEM'
	and created > '3-oct-18';
	type namesarray IS VARRAY(8) OF VARCHAR2(16); 
    tab varchar2(30);
    cnt integer;
    profile integer;
    total integer;
    sze integer;
begin
	names := namesarray('LOCATION', 'USERINFO', 'RESTAURANT', 'SELECTIONCART', 'FOOD_TYPE', 'MENU', 'RATINGS', 'COMMENTA'); 
	total := names.count;
	for i in 1..total
	loop
  	select count(*) into cnt from names(i);
	select sum(data_length) into sze from user_tab_columns where table_name = ''||names(i)||'';
	profile := cnt * sze * 8;
	dbms_output.put_line('Table 1'||tab||': Row_count - '|| cnt ||' Size - '||sze||' profile Size - '||profile);
	end loop;
	commit;
end;
/

  	
