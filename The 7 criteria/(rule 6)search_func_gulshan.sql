SET SERVEROUTPUT ON;
 create or replace function semi_join_func(fnum in food_type.fnum%type)
	return sys_refcursor 
  is
  menu_cur   sys_refcursor;
	begin
    open menu_cur
    for 
    whit A (select * from menu_t1@site_gulshan T where exists 
    (select * from (select menu_acc.mnum@site_gulshan from menu_acc@site_gulshan   
    where exists (select * from (select restaurant1.rnum@site_gulshan 
    from restaurant1@site_gulshan) C where C.rnum@site_gulshan = M.rnum@site_gulshan)
    B where T.mnum@site_gulshan = B.mnum@site_gulshan)) select A.mname@site_gulshan, 
    A.rnum@site_gulshan, price from A inner join menu_acc@site_gulshan 
    on A.mnum@site_gulshan = menu_acc.mnum@site_gulshan inner join restaurant1@site_gulshan on
    restaurant1.rnum@site_gulshan = menu_acc.rnum@site_gulshan where fnum = fnum;

    --select menu_acc.mname@site_gulshan, menu_acc.rnum@site_gulshan, price, rname 
    --from menu_t1@site_gulshan inner join menu_acc@site_gulshan 
    --on menu_t1.mnum@site_gulshan = menu_acc.mnum@site_gulshan
    --inner join restaurant1@site_gulshan 
    --on menu_acc.rnum@site_gulshan = restaurant1.rnum@site_gulshan 
    --where fnum = fnum;
    close menu_cur;
    return menu_cur;	
end search_func_gulshan;
/


