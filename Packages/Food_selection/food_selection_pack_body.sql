CREATE OR REPLACE PACKAGE BODY food_selection_package AS 
   function search_func_gulshan(fnum in food_type.fnum%type)
   return sys_refcursor 
  is
  menu_cur   sys_refcursor;
   begin
    open menu_cur
    for 
    select menu_acc.mname@site_gulshan, menu_acc.rnum@site_gulshan, price, rname 
    from menu_t1@site_gulshan inner join menu_acc@site_gulshan 
    on menu_t1.mnum@site_gulshan = menu_acc.mnum@site_gulshan
    inner join restaurant1@site_gulshan 
    on menu_acc.rnum@site_gulshan = restaurant1.rnum@site_gulshan 
    where fnum = fnum;
    close menu_cur;
    return menu_cur; 
end search_func_gulshan;
/
   function search_func_dhanmondi(fnum in food_type.fnum%type)
    return sys_refcursor
  is
  menu_cur   sys_refcursor;
    begin
    open menu_cur
    for select menu_acc.mname, price, rname from menu_t2@site_dhanmondi inner join menu_acc@site_dhanmondi
    on menu_t2.mnum@site_dhanmondi = menu_acc@site_dhanmondi
    inner join restaurant2@site_dhanmondi on menu_t2.rnum@site_dhanmondi = restaurant2.rnum@site_dhanmondi
    where fnum = fnum;
    return menu_cur;    
end search_func_dhanmondi;
/
   
procedure show_menu_proc_gulshan(res_id in number)
  is
  m varchar2(30);
  p integer;
  mid number;
  cursor cur is
  select mnum, mname, price from menu_acc@site_gulshan where rnum = res_id ;
begin
  
  open cur;
  loop
      fetch cur into mid, m, p;
      exit when cur%notfound;
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(mid)||'         '||TO_CHAR(m)||'          '||TO_CHAR(p));
  end loop;
  close cur;
end show_menu_proc_gulshan;
/

procedure show_menu_proc_dhanmondi(res_id in number)
  is
  m varchar2(30);
  p integer;
  mid number;
  cursor cur is
  select mnum, mname, price from menu_acc@site_dhanmondi where rnum = res_id ;
begin
  
  open cur;
  loop
      fetch cur into mid, m, p;
      exit when cur%notfound;
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(mid)||'         '||TO_CHAR(m)||'          '||TO_CHAR(p));
  end loop;
  close cur;
end show_menu_proc_dhanmondi;
/

END food_selection_package; 