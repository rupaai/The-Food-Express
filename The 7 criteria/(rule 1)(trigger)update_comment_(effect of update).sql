set serveroutput on;
set verify off;
declare
cmto varchar2(30) := '&com';
procedure update_comment_level3(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type)
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

set serveroutput on;
set verify off;
declare
cmto varchar2(30) := '&com';
procedure update_comment_level1(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type)
  is

  com number;
  n number;
  unum number;
  cnum number;
  begin
    select max(conum) into com from commenta;
    com := com + 1;
    select dbms_random.value(1, com) num n from dual; --randomly updating one
    update commenta set co = cmnto where conum = n;
end;
/