select 1, 1+1, sysdate from s_emp;

select name || ' ' || mailid from s_emp;

select * from s_emp
where start_date >= to_date('15-03-03', yy-mm-dd);

-- 다음달의 마지막 날이 몇 일인지 구하시오
select to_char(last_day(add_months(sysdate,1)),'mm-dd') 다음_달의_마지막_날 from dual;

-- 각 부서별 평균급여를 출력
select dept_id, round(avg(salary),2)
from s_emp
where title = '사원'
group by dept_id;

-- 각 부서별로 평균 급여를 구하되 평균 급여가 2000이상인 부서만 나타내시오.
-- 118, 101, 102, 104
select dept_id 부서, round(avg(salary),2) 평균급여
from s_emp
group by dept_id
having round(avg(salary),2) >= 2000
order by 부서
;

-- 각 지역별로 몇 개의 부서가 있는지를 나타내시오.
-- 4, 2, 2, 2, 1
select region_id 지역번호, count(name) 부서개수 from s_dept
group by region_id
order by region_id
;

-- 각 직책별로 급여의 총합을 구하되 직책이 부장인 사람은 제외
-- 단, 급여 총합이 8,000 이상인 직책만 나타내며, 급여 총합 오름차순 정렬
-- 사원: 8090, 과장: 11500
select title 직책, sum(salary) 급여총합
from s_emp
where title not like '부장'
group by title
having sum(salary) >= 8000
order by 급여총합
;

-- 각 부서별(dept_id)로 직책(title)이 사원인 직원들에 대해서만 평균 급여 구하기
-- 사원 10명
select dept_id 부서, avg(salary) 평균_급여
from s_emp
where title = '사원'
group by dept_id
order by dept_id
;

-- 각 부서(dept_id) 내에서 각 직책(title)별로 몇 명의 인원이 있는지를 나타내시오.
select dept_id 부서, title 직책, count(title) 직책_별_인원
from s_emp
group by dept_id, title
order by dept_id
;

-- 각 부서(dept_id) 내에서 몇 명의 직원이 근무하는지를 나타내시오
-- 101: 1, 102: 2, 103: 1, 104: 1, 105: 1, 
-- 106: 2, 110: 4, 111: 3, 112: 3, 113: 5, 118: 2
select dept_id 부서, count(dept_id) 부서_별_인원
from s_emp
group by dept_id
order by dept_id
;

-- 각 부서(dept_id)별로 급여(salary)의 최소값과 최대값을 나타내시오
-- 단 최소값과 최대값이 같은 부서는 출력하지 마시오.
-- 102: 2450, 3500 / 106: 0, 795 / 110: 0, 3000 / 111: 795, 2400 /
-- 112: 750, 2100 / 113: 800, 2300 / 118: 3200, 5000
select dept_id, min(salary), max(salary)
from s_emp
group by dept_id
having min(salary) not like max(salary)
order by dept_id
;

select * from s_emp, s_dept
where s_emp.dept_id = s_dept.id
;

-- 직원 중에 '김정미'와 같은 직책(title)을 가지는 사원의 이름과
-- 직책, 급여, 부서번호를 나타내시오(self-join)
-- 김정미의 직책? 과장
-- 그 직책인 사람? 전지영, 신기웅, 이상헌, 최순철 
select m.name, w.title, m.salary, m.dept_id
from (select * from s_emp where name = '김정미') w, s_emp m
where w.title = m.title
and m.name not like '김정미'
;

select e2.name, e1.title 
from s_emp e1, s_emp e2
where e1.title = e2.title
and e1.name = '김정미'
and e2.name <> '김정미';

select * from s_emp
where title = '과장'
and name <> '김정미';
