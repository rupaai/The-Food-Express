CREATE OR REPLACE PACKAGE BODY theory_package AS 
   procedure proof_left_side
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
procedure proof_right_side
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


procedure quality_linear_reg_func(p in number, d in number, 
r in number) 
is

t1 number;
t2 number;
t3 number;
t4 number;
hyp number;

res_id number;
price number;
duration number;
rating number;
quality number;
cursor cur is select res_id, price, duration, rating, quality from quality_prediction;
cost_func number;
dif_sqr number;
cnt number;
alpha number;
iter number;
feat number;

predict_quality number;
begin
  iter := 2;
  t1 := 0;
  t2 := 0;
  t3 := 0;
  t4 := 0;
  feat := 0;
  dif_sqr := 0;
  cnt := 0;
  alpha := 0.005;
  for i in 1..iter loop
    open cur;
    fetch cur into res_id, price, duration, rating, quality;
    loop
      exit when cur%notfound;
      cnt := cnt + 1;
      hyp := t1 + t2 * price + duration* t3 + rating * t4;
      -- sum of (h(x) - y)
      dif_sqr := dif_sqr + (hyp - quality);
    end loop;
    close cur;
    
    cost_func := dif_sqr/cnt;
    cost_func := alpha * cost_func;

    -- optimization 
    t1 := t1 - cost_func;
    t2 := t2 - cost_func;
    t3 := t3 - cost_func;
    t4 := t4 - cost_func;

  end loop;
    

  predict_quality := t1 + t2*p + t3*d + t4*r;

  DBMS_OUTPUT.PUT_LINE('Predicted Quality of the Restaurant is  '|| predict_quality ||' when price = '|| p ||', time = '|| d ||', rating = '|| r);
end;
/


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

 procedure withoutSimplify
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
procedure withSimplify
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

procedure show_all_canonical(unum in userInfo.unum%TYPE)
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


procedure show_all_Notcanonical(unum in userInfo.unum%TYPE)
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

 procedure db_profile_estimator
  is
  cursor cur is 
  select object_name from dba_objects
  where object_type = 'TABLE'
  and owner = 'SYSTEM'
  and created > '3-oct-18';
  type namesarray IS VARRAY(8) OF VARCHAR2(16); 
    tab varchar2(30);
    cnt integer;
    profile integer;
    total integer;
    sze integer;
begin
  names := namesarray('LOCATION', 'USERINFO', 'RESTAURANT', 'SELECTIONCART', 'FOOD_TYPE', 'MENU', 'RATINGS', 'COMMENTA'); 
  total := names.count;
  for i in 1..total
  loop
    select count(*) into cnt from names(i);
  select sum(data_length) into sze from user_tab_columns where table_name = ''||names(i)||'';
  profile := cnt * sze * 8;
  dbms_output.put_line('Table 1'||tab||': Row_count - '|| cnt ||' Size - '||sze||' profile Size - '||profile);
  end loop;
  commit;
end;
/

function semi_join_func(fnum in food_type.fnum%type)
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


END theory_package; 