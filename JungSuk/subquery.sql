-- 스칼라 서브쿼리가 join보다 훨씬 빠르다
select e.name, e.dept_id
, (select name from s_dept where id = e.dept_id)
from s_emp e -- scalar subquery
;

select e.name, e.dept_id, d.name from s_emp e, s_dept d
where e.dept_id = d.id; -- join

-- 7.7
-- 가장 적은 평균 급여를 받는 직책에 대해 그 직책과 평균급여를 나타내시오.
select min(avg(salary))
from s_emp
group by title
order by avg(salary);

select title, avg(salary) from s_emp
group by title
having avg(salary) = (
select min(avg(salary))
from s_emp
group by title
)
;