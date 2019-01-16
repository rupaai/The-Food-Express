--location fragmentation
	declare
	--user fragment
	
	cursor user is select * from userInfo inner join location on userInfo.lnum = location.lnum
	where lname = 'Gulshan';
	unum userInfo.unum%TYPE;
	uname userInfo.uname%TYPE;
	age userInfo.age%TYPE;
	phone userInfo.phone%TYPE;
	pass userInfo.pass%TYPE;
	lnum userInfo.lnum%TYPE;
	ln location.lnum%TYPE;
	lname location.lname%TYPE;

	begin
	open user;
	loop
		fetch user into unum, uname, age, phone, pass, lnum, ln, lname;
		exit when user%NOTFOUND;
		insert into user1@site_gulshan values (unum, uname, age, phone, pass, lnum);
	end loop;
	close user;	
	commit;
	end;
	/

	declare
	cursor cur_food is 
	select * from selectionCart;
	food cur_food%ROWTYPE;
begin
	open cur_food;
	loop
	fetch cur_food into food;
	exit when cur_food%NOTFOUND;
	insert into selectionCart@site_gulshan values(food.cnum, food.unum, food.mnum, food.count, food.price);
	end loop;
	close cur_food;
	commit;
END;
/

--restaurant fragment
	declare
	
	cursor rest is select * from restaurant left join location on restaurant.lnum = location.lnum
	where lname = 'Gulshan';
	rnum restaurant.rnum%TYPE;
	rname restaurant.rname%TYPE;
	lnum_r restaurant.lnum%TYPE;
	ln_r location.lnum%TYPE;
	lname_r location.lname%TYPE;
	begin
	open rest;
	loop
		fetch rest into rnum, rname, lnum_r, ln_r, lname_r;
		exit when rest%NOTFOUND;
		insert into restaurant1@site_gulshan values (rnum, rname, lnum_r);
	end loop;
	close rest;	
	commit;
	end;
	/

	declare
	cursor cur_rate is 
	select * from ratings where rating between 7 and 10;
	rate cur_rate%ROWTYPE;
begin
	open cur_rate;
	loop
	fetch cur_rate into rate;
	exit when cur_rate%NOTFOUND;
	insert into ratings1@site_gulshan values(rate.rtnum, rate.unum, rate.rnum, rate.mnum, rate.rating);
	end loop;
	close cur_rate;
	commit;
END;
/


declare
	cursor cur_acc is 
	select mnum, mname, fnum from menu inner join restaurant on menu.rnum = restaurant.rnum where lnum = 1;
	acc cur_acc%ROWTYPE;
begin
	open cur_acc;
	loop
	fetch cur_acc into acc;
	exit when cur_acc%NOTFOUND;
	insert into menu_t1@site_gulshan values(acc.mnum, acc.mname, acc.fnum);
	end loop;
	close cur_acc;
	commit;
END;
/

declare
	cursor cur_acc is 
	select mnum, mname, price, menu.rnum from menu inner join restaurant on menu.rnum = restaurant.rnum where lnum = 1;
	acc cur_acc%ROWTYPE;
begin
	open cur_acc;
	loop
	fetch cur_acc into acc;
	exit when cur_acc%NOTFOUND;
	insert into menu_acc@site_gulshan values(acc.mnum, acc.mname, acc.price, acc.rnum);
	end loop;
	close cur_acc;
	commit;
END;
/

--location fragmentation
	declare
	cursor loc is select * from location where lname = 'Gulshan';
	l location%ROWTYPE;

	begin
	open loc;
	loop
		fetch loc into l;
		exit when loc%NOTFOUND;
		insert into location1@site_gulshan values (l.lnum, l.lname);
	end loop;
	close loc;
	commit;
	end;
	/

	declare
	cursor cur_food is 
	select * from food_type;
	food cur_food%ROWTYPE;
begin
	open cur_food;
	loop
	fetch cur_food into food;
	exit when cur_food%NOTFOUND;
	insert into food_type@site_gulshan values(food.fnum, food.fname);
	end loop;
	close cur_food;
	commit;
END;
/