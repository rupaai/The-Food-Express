
set serveroutput on;
set verify off;

declare
  res_id number := &res;
  price number := &price;
  duration number := &tme;
  rating number := &rating;
  result number;
begin
  result := quality_linear_reg_func(price, duration, rating);
end;
/

