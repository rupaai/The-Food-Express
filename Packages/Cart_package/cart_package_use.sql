declare 
	menu_name varchar2(30) := &menu_name;
  cnt integer := &cnt;
  unum number := &unum;
  cnum number := &cnum;
  price integer;
  rnum number;
  mnum number;
  random number;
  cursor cur is
  Select mnum, price, rnum from menu where mname = menu_name;

begin 
	open cur;
  loop 
    fetch cur into mnum,price, rnum;
    exit when cur%NOTFOUND;
    random := cart_package.add_to_cart_func(unum, mnum, price, cnt, rnum);
  end loop;
  close cur;

  cart_package.add_comment_proc(cmnt, unum, cnum);
  cart_package.show_menu_proc_gulshan(rnum);
end; 
/