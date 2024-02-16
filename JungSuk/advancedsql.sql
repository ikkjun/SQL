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

select * 
from (
    select dept_id, title 
    from s_emp
)
pivot (
    count(*)
    for title 
    in('사원', '과장','부장','이사','사장')
)
order by dept_id
;

select dept_id, title, count(*) from s_emp
where dept_id in(106,112,113)
group by rollup(dept_id, title)
order by dept_id
;

select dept_id, title, count(*) from s_emp
where dept_id in(106,112,113)
group by cube(dept_id, title)
order by dept_id
;

select id, name, salary, rank() over (order by salary desc) as rank 
from s_emp;

select dept_id, name, salary,
    rank() over (
    partition by dept_id
    order by salary desc) as rank
from s_emp;

select name, salary, dept_id
from s_emp outer
where salary < (
    select avg(salary)
    from s_emp
    where dept_id = outer.dept_id)
;

select name, salary, dept_id from s_emp
where salary < any(select avg(salary)
                    from s_emp
                    group by dept_id)
;

select id, name, title, dept_id
from s_emp e
where exists (select id from s_emp
                where manager_id = e.id);
                
select id from s_emp
where manager_id = id;

select id, name, title from s_emp e
where not exists(select 'X' from s_emp
                where e.title = '사원');
                
                select 'X' from s_emp
                where e.title = '사원';