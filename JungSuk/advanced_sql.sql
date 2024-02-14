create view emp_dept as
select e.name, d.name dept_name
from s_emp e, s_dept d
where e.dept_id = d.id
;

select * from emp_dept;

select * from user_views;

select ltrim('abbcdefg', 'b') from dual;

select rowid, rownum, v.* 
from s_emp v
order by name -- 순서가 맞는다는 보장이 없다
;