set serveroutput on;
create or replace procedure proof_left_side
is
	rname restaurant.rname%TYPE;
	rating restaurant.rating%TYPE;
	
	cursor cur is 
	select rname, rating from (select * from restaurant1@site_gulshan UNION select * from restaurant2@site_dhanmondi where lnum = 1) A inner join 
	(select * from ratings1@site_gulshan UNION select * from ratings2@site_gulshan where rating between 7 and 10) B
    	on A.rnum = B.rnum;

begin
	open cur;
	loop
		fetch cur into rname, rating;
		exit when cur%notFound;
		dbms_output.put_line('Restaurant Name: '|| rname || ', Rating: '|| rating);
	end loop;
	close cur;
end proof_left_side;
/
set serveroutput on;
create or replace procedure proof_right_side
is
	rname restaurant.rname%TYPE;
	rating restaurant.rating%TYPE;
	
	cursor cur is 
	select rname, rating from restaurant1@site_gulshan inner join ratings1@site_gulshan where lnum = 1
	and rating between 7 and 10;

begin
	open cur;
	loop
		fetch cur into rname, rating;
		exit when cur%notFound;
		dbms_output.put_line('Restaurant Name: '|| rname || ', Rating: '|| rating);
	end loop;
	close cur;
end proof_right_side;
/
begin
	dbms_output.put_line('([R1:pR1] UN [R2:qR2]) JN F ([S1: rS1] UN [S2: tS2])');
	dbms_output.put_line('-----------------');
	proof_left_side;
	dbms_output.put_line('-------------------------------------------');
	dbms_output.put_line('[(R1 UN R2) JN (S1 UN S2): (pR1 or qR2) and (rS1 or tS2) and F]:');
	dbms_output.put_line('------------------');
	proof_right_side;
	
end;
/