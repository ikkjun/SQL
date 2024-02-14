select * from user_objects
where object_type = 'TABLE'
;

select count(*) from user_objects
where object_type = 'TABLE'
;

create table emp_temp where s_emp
delete from emp_temp;
select * from emp_temp;
truncate table emp_temp;

create sequence c_emp_id
increment by 1
start with 26
maxvalue 9999999
nocache
nocycle
;

select c_emp_id.nextval from dual; -- 게시판에서 새로운 글 작성되는 경우에도 사용, 민족키에서도 사용
insert into s_emp (id, name, salary) values(c_emp_id.nextval + 100000, '홍길동', 0);
select * from s_emp where name = '홍길동'
order by id desc
;

truncate table tmp;
select count(*) from tmp;
select * from tmp order by id;

insert into tmp(id, name, salary)
select s_emp_id.nextval, name, salary from tmp; -- 자기 자신에서 select한다음 insert한다. key값은 계속 달라지므로 테스트 데이터를 만드는 데 유용하다.

drop index s_emp_idx_name;
create index s_emp_idx_name
on s_emp(name, salary)
;
select * 
from s_emp
;