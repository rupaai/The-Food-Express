create or replace package cart_package as 

	procedure add_comment_proc(cmnt in commenta.co%TYPE, unum in userinfo.unum%type,cnum in selectionCart.cnum%type);
	function add_to_cart_func(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type)
  return number;
  procedure update_comment(unum in userinfo.unum%type,mnum in menu.mnum%type, price in menu.price%type, cnt integer, rnum in menu.rnum%type);

cart_package;
/