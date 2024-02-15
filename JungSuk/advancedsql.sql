select * from newtable;
insert into newtable(name, salary) values('조익준',1000);
insert into newtable values(15,'김익준',1100,'사장',sysdate,'총무','서울');
insert into newtable values(15,'가익준',1200,'직원',sysdate,'총무','경기');
insert into newtable values(15,'나익준',1300,'주임',sysdate,'총무','강원');

select name, salary, nvl(dept_name, '미정') from newtable;

create table newEmp
as select *
from s_emp;
select * from newEmp;
delete newEmp;

select name, decode(trunc(salary/1000),0,'E', 1,'D',2,'C',3,'B','A') 급여등급
from s_emp
;

select id, name,
    case
    when salary < 1000 then 'Very Low'
    when salary >= 1000 and salary <= 3000 then 'Low'
    when salary > 5000 then 'high'
    else 'Medium'
    end
    급여등급
from s_emp;