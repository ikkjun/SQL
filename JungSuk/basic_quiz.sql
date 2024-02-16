select dept_id, avg(salary)
from s_emp
where title = '사원'
group by dept_id
;


-- 18. 각 부서내에서 각 직책별로 몇 명의 인원이 있는지를 나타내시오.
select d.name, e.title, count(e.name) from s_emp e, s_dept d 
where e.dept_id = d.id
group by d.name, e.title
order by name
;

-- 19. 각 부서(dept id) 내에서 몇 명의 직원이 근무하는지를 나타내시오 -- 101: 1, 102: 2, 103: 1, 104: 1, 105: 1, -- 106: 2, 110: 4, 111: 3, 112: 3, 113: 5, 118: 2
select dept_id, count(name)
from s_emp
group by dept_id
;
-- 20. 각 부서별로 급여의 최소값과 최대값을 나타내시오. 단, 최소값과 최대값이 같은 부서는 출력하지 마시오.
select d.name, min(salary), max(salary)
from s_emp e, s_dept d 
where e.dept_id = d.id
group by d.name
having min(salary) not like max(salary)
;

select * 
from s_emp
;

select *
from s_dept
;

select level*2 from dual
connect by level <= 5;

select to_char(add_months(sysdate,-1 * level), 'yyyymm') "최근 12개월 동안의 날짜" 
from dual
connect by level <= 12;

select to_number(to_char(sysdate,'yyyymm')) from dual;