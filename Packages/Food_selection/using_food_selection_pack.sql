set serveroutput on;
set verify off;
declare
  food_type varchar2(30) := &type;
  menu_cur   sys_refcursor;
  mname varchar2(30);
  price integer;
  res_name varchar2(30) := '&res_name';
  res number;
  lid location.lnum%TYPE;
  fnum number;
  id number := 1;
  lid number;
  menu_name varchar2(30) := &menu_name;
  cnt integer := &cnt;
  unum number := &unum;
  price integer;
  rnum number;
  mnum number;
  random number;
  cursor cur is
  Select mnum, price, rnum from menu where mname = menu_name;
begin
    select fnum into fnum from food_type@site_gulshan;
    select round(dbms_random.value(1,2)) num into lid from dual;
    if lid = 1
    then 
    dbms_output.put_line('Your location is Gulshan.');
    menu_cur := food_selection_package.search_func_gulshan(fnum);
    else
      dbms_output.put_line('Your location is dhanmondi.');
      menu_cur := food_selection_package.search_func_dhanmondi(fnum);
    loop
      fetch menu_cur into mname, price, rname;
      exit when menu_cur%NOTFOUND;
      dbms_output.put_line(id || '  ' || mname || '  ' || price || '  ' || rname);
      id := id + 1;
    end loop;

    if res IS NULL
  then 
      DBMS_OUTPUT.PUT_LINE('No such restaurant is found!!!');
  else
    select location.lnum into lid from location inner join restaurant on location.lnum = restaurant.lnum where rnum = res;
    case
      when lid = 1
        then 
          food_selection_package.show_menu_proc_gulshan(res);
      when lid = 2
        then 
          food_selection_package.show_menu_proc_dhanmondi(res);
      else
        DBMS_OUTPUT.PUT_LINE('not available!');
      end case;
  end if;

  commit;
Exception
  WHEN NO_DATA_FOUND THEN
        res := NULL;
end;
/