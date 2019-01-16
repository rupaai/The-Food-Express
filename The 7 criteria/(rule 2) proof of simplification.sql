set serveroutput on;
create or replace procedure withoutSimplify
is
	mname menu.mname%TYPE;
	mnum menu.mnum%TYPE;
	fnum menu.fnum%TYPE;
	cursor cur is 
	select mnum, mname, fnum from menu inner join restaurant on menu.rnum = restaurant.rnum where lnum = 1;

begin

	open cur;
	loop
		fetch cur into mnum, mname, fnum;
		exit when cur%notFound;
		dbms_output.put_line(mname || ': '|| mname);
	end loop;
	close cur;
end withoutSimplify;
/

create or replace procedure withSimplify
is
	mname menu.mname%TYPE;
	mnum menu.mnum%TYPE;
	fnum menu.fnum%TYPE;
	cursor cur is 
	with A as (select mnum, fnum, rnum, mname from menu)
	select mnum, mname, fnum from A inner join (select rnum from restaurant where lnum = 1) B
	on A.rnum = B.rnum;

begin
	open cur;
	loop
		fetch cur into mnum, mname, fnum;
		exit when cur%notFound;
		dbms_output.put_line(mname || ': '|| mname);
	end loop;
	close cur;
end withSimplify;
/

begin
	dbms_output.put_line('BEFORE SIMPLIFY:');
	dbms_output.put_line('-----------------');
	withoutSimplify;
	dbms_output.put_line('-------------------------------------------');
	dbms_output.put_line('AFTER SIMPLIFY:');
	dbms_output.put_line('------------------');
	withSimplify;
	
end;
/