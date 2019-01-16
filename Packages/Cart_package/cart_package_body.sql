CREATE OR REPLACE PACKAGE BODY cart_package AS 
   
procedure add_comment_proc(cmnt in commenta.co%TYPE, unum in userinfo.unum%type,cnum in selectionCart.cnum%type)
  is
  com number := 0;
  --cursor cur is
  --select conum from commenta;
  begin
  select max(conum) into com from commenta@site_gulshan;
  com := com + 1 ;  
    insert into commenta@site_gulshan (conum, unum, cnum, co) values (com, unum, cnum, cmnt);
    --insert into commenta@site_dhanmondi (conum, unum, cnum, co) values (com, unum, cnum, cmnt);
    --insert into commenta@site_khilgaon (conum, unum, cnum, co) values (com, unum, cnum, cmnt);
    commit;
end add_comment_proc;
/

function add_to_cart_func(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type)
  return number
  is
  cursor cur is
  select cnum from selectionCart;
  cnum number := 0;
  total integer;
  begin

    open cur;
    loop
    fetch cur into cnum;
    exit when cur%notfound;
  end loop;
  close cur;  
      total := (price * cnt);
  cnum := cnum + 1;
  insert into selectionCart (cnum, unum, mnum, count, price) values (cnum, unum, mnum, cnt, total);
  insert into selectionCart@site_gulshan (cnum, unum, mnum, count, price) values (cnum, unum, mnum, cnt, total);
  --insert into selectionCart@site_khilgaon (cnum, unum, mnum, count, price) values (cnum, unum, mnum, cnt, total);
    commit;
    return 0;
end add_to_cart_func;
/
procedure update_comment(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type)
  is
  com number;
  n number;
  unum number;
  cnum number;
  begin
    select max(conum) into com from commenta;
    com := com + 1;
    select dbms_random.value(1, com) num n from dual;
    select unum, cnum into unum, cnum from commenta@site_gulshan where conum = n;
    if unum IS NULL 
     then
      select unum, cnum into unum, cnum from commenta@site_gulshan where conum = n;
      delete commenta@site_khilgaon where conum = n;
      insert into commenta@site_khilgaon values(n, unum, cnum, cmto);
      else
        delete commenta@site_gulshan where conum = n;
        insert into commenta@site_gulshan values(n, unum, cnum, cmto);
    end if;
    
end;
/
END cart_package; 