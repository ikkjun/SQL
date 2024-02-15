-- 모든 행 삭제
select * from newtable;
delete newtable;

-- 직원 테이블에 존재하는 모든 title을 중복없이 출력
select distinct title from s_emp;

-- 직원 테이블을 dept_id 내림차순, salary 오름차순으로 정렬
select *
from s_emp
order by dept_id desc, salary asc
;

-- 직원 테이블에서 2015년도 이전에 입사한 직원의 수를 출력
select count(name)
from s_emp
where start_date < to_date('2015-01-01', 'yyyy-mm-dd')
;

-- 연봉이 1000 이상 5000 이하인 직원
-- 박구곤, 손명성, 이은선, 서의홍, 김심선, 전지영, 김정미, 신기웅, 이상헌, 최순철, 최정선, 김석우, 서정주, 이용호
select name
from s_emp
where salary between 1000 and 5000
;

-- 부서(dept_id)별 평균급여를 계산
select dept_id, round(avg(salary), 2)
from s_emp
group by dept_id
;

-- 부서별로 직책이 사원인 직원들의 평균 급여를 계산
select dept_id, avg(salary)
from s_emp
where title = '사원'
group by dept_id
;

-- 지역별로 몇 개의 부서가 있는지를 나타내시오. 
-- 중복되는 부서명 제거하고 싶다
select * -- r.name 지역, count(d.name) 
from s_emp e, s_region r, s_dept d
where e.dept_id = d.id
and d.region_id = r.id;
group by r.name
;

-- 각 부서별로 평균 급여를 구하되 평균 급여가 2000이상인 부서만
select dept_id, avg(salary) 
from s_emp
group by dept_id
having avg(salary) >= 2000
;

-- 각 직책별로 급여의 총합을 구하되 직책이 부장인 사람은 제외
-- 급여총합이 8000 이상인 직책만 급여총합 오름차순 
select title, sum(salary)
from s_emp
where title not like '%부장'
group by title
having sum(salary) >= 8000
order by sum(salary)
;

-- 부서 내에서 각 직책별로 몇 명의 인원이 있는지
select dept_id, title, count(name)
from s_emp
group by dept_id, title
order by dept_id desc
;

-- 13. 각 부서 내에서 몇 명의 직원이 근무
select dept_id, count(name)
from s_emp
group by dept_id
;

-- 14. 각 부서별로 급여의 최소값과 최대값 출력. 최소값과 최대값이 같은 부서는 출력하지 말기
select dept_id, max(salary), min(salary)
from s_emp
group by dept_id
having max(salary) <> min(salary)
;

-- 15. 직원과 부서 join하여 사원의 이름과 부서, 부서명을 나타내시오.
select e.name, e.dept_id, d.name
from s_emp e, s_dept d
where d.id = e.dept_id
;

-- 16. 서울 지역에 근무하는 사원에 대해 각 사원의 이름과 근무하는 부서명을 나타내시오.
select e.name, d.name
from s_emp e, s_dept d, s_region r
where d.id = e.dept_id
and r.id = d.region_id
and r.name like '서울%'
;

-- 17. 직원 테이블과 급여 테이블을 join하여 직원의 이름, 급여, 해당 등급 
select e.name, e.salary, s.grade
from s_emp e, salgrade s
where e.salary between s.losal and s.hisal 
;

-- 18. 직원 테이블과 고객 테이블에서 사원의 이름과 사번, 사원의 담당고객 이름
-- 고객에 대하여 담당영업사원이 없더라도 모든 고객의 이름, 사번순으로 오름차순
select e.name, e.id, c.name
from s_emp e, s_customer c -- c.sales_rep_id
where c.sales_rep_id = e.id (+)
order by e.id
;

-- 19. 직원 중에 '김정미'와 같은 직책을 가지는 사원의 이름과 직책, 급여, 부서번호를 나타내시오. self-join
select t2.name, t1.title, t2.salary, t2.dept_id
from s_emp t1, s_emp t2
where t1.name = '김정미'
and t2.title = '과장'
and t2.name <> '김정미'
;

-- 20. 가장 적은 평균급여를 받는 직책에 대해 그 직책과 평균급여 출력
select title, avg(salary)
from s_emp
group by title
having avg(salary) = (
select min(avg(salary))
from s_emp
group by title
)
;

-- 21. s_emp 테이블에서 각 사원의 이름과 급여, 급여 등급을 나타내시오.
select name, salary, decode(trunc(salary/1000), 0, 'E', 1, 'D', 2, 'C', 3, 'B', 'A') 급여등급
from s_emp
;

-- 22. 자신의 급여가 자신이 속한 부서의 평균 급여보다 적은 직원에 대해 이름, 급여, 부서 번호를 출력
select t1.name, t1.salary, t1.dept_id, t2.avgSal
from s_emp t1, (
select dept_id, round(avg(salary),2) avgSal
from s_emp
group by dept_id
) t2
where t2.dept_id = t1.dept_id;
and t1.salary < t2.avgSal
;

-- 23. 본인의 급여가 각 부서별 평균 급여 중 어느 한 부서의 평균급여보다 적은 급여를 받는 직원에 대해 이름, 급여, 부서번호 출력(any)
select name, salary, dept_id 
from s_emp
where salary < any(select avg(salary) 
                    from s_emp
                    group by dept_id)
;
select dept_id, round(avg(salary),2)
from s_emp
group by dept_id
;

-- 24. 본인이 다른 사람의 관리자로 되어 있는 직원의 사번, 이름, 직책, 부서번호를 나타내시오.
select id, name, title, dept_id
from s_emp e
where exists (select id
                from s_emp
                where manager_id = e.id)
;
-- 25. 직원 테이블에서 이름을 사전순으로 정렬하여 5개의 데이터만 나타내시오.
select * 
from s_emp
where rownum <= 5
order by name asc
;

select * 
from s_emp
;
select * from s_region;
select * from s_dept;

update s_emp
set start_date = to_date('2014-01-01', 'yyyy-mm-dd')
where name = '홍길동'
;

delete s_emp where name = '홍길동';