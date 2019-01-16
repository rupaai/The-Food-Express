SET SERVEROUTPUT ON;
create or replace procedure show_all_canonical(unum in userInfo.unum%TYPE)
  is
  m varchar2(30);
  p integer;
  mid number;
  cursor cur is
  select restaurant1.rname@site_gulshan as rname from restaurant1@site_gulshan 
  UNION
  select restaurant2.rname@site_khilgaon as rname from restaurant2@site_khilgaon;
  men cur%ROWTYPE;
begin
  
  open cur;
  loop
      fetch cur into men;
      exit when cur%notfound;
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(men.rname));
  end loop;
  close cur;
end show_all;
/


SET SERVEROUTPUT ON;
create or replace procedure show_all_Notcanonical(unum in userInfo.unum%TYPE)
  is
  m varchar2(30);
  p integer;
  mid number;
  cursor cur is
  select rname from restaurant;
  men cur%ROWTYPE;
begin
  
  open cur;
  loop
      fetch cur into men;
      exit when cur%notfound;
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(men.rname));
  end loop;
  close cur;
end show_all;
/
