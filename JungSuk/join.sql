-- 예제 9
-- 직원(s_emp) 테이블과 부서(s_dept) 테이블을 join하여, 사원의 이름과 부서, 부서명을 나타내시오.
select e.name 이름, e.dept_id 부서, d.name 부서명
from s_emp e, s_dept d
where e.dept_id = d.id
;

-- 예제 10
-- 서울 지역에 근무하는 사원에 대해 각 사원의 이름과 근무하는 부서명을 나타내시오.
select e.name 사원이름, d.name 부서명
from s_emp e, s_dept d, s_region r
where e.dept_id = d.id
and d.region_id = r.id
and r.name like '서울%'
;

-- 예제 11
-- 직원 테이블(s_emp)과 급여 테이블(salgrade)을 join하여 
-- 사원의 이름과 급여, 그리고 해당 급여등급을 나타내시오.
select e.name 이름, e.salary 급여, s.grade 급여등급
from s_emp e, salgrade s
where e.salary between s.losal and s.hisal
;

-- 예제 12
-- 직원(s_emp) 테이블과 고객(s_customer) 테이블에서 
-- 사원의 이름과 사번, 그리고 각 사원의 담당고객 이름을 나타내시오.
-- 단, 고객에 대하여 영업 사원이 없더라도 모든 고객의 이름을 나타내고,
-- 사번 순으로 오름차순 정렬하시오.
select e.name 사원이름, e.id 사번, c.name 담당고객
from s_emp e, s_customer c
where e.id(+) = c.sales_rep_id
order by 2
;

-- 예제 13
-- 직원 중에 '김정미'와 같은 직책을 가지는 사원의 이름과
-- 직책, 급여, 부서번호를 나타내시오. (self-join)
select t2.name, t1.title, t2.salary, t2.dept_id
from s_emp t1, s_emp t2
where t1.title = t2.title
and t1.title = '과장'
and t1.name = '김정미'
;

select * from s_emp;
select * from s_dept;
select * from s_region;
select * from salgrade;
select * from s_customer;