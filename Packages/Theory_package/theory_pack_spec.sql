CREATE OR REPLACE PACKAGE theory_package AS 
--rule 1
procedure update_comment_level3(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type);
procedure update_comment_level1(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type);

--rule 2
procedure withoutSimplify;
procedure withSimplify;

--rule 3
 procedure show_all_canonical(unum in userInfo.unum%TYPE);
procedure show_all_Notcanonical(unum in userInfo.unum%TYPE);
--rule 4
procedure proof_left_side;
 procedure proof_right_side;

--rule 5
 procedure db_profile_estimator;

--rule 6

function semi_join_func(fnum in food_type.fnum%type)
  return sys_refcursor;
--rule 7
   procedure quality_linear_reg_func(p in number, d in number, 
r in number);
   
END theory_package; 