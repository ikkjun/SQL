-- 1. 테이블을 생성하시오.
/*  컬럼명        data type   길이  default
    id          NUMBER      5
    name        char        25
    salary      number      7,2
    title       char        25      사원
    in_date     date                sysdate
    dept_name   char        25
*/

-- 2. 예제 1에서 생성한 테이블에 시퀀스를 활용하여 데이터를 입력하시오.

-- 3. 예제 2에서 입력한 데이터를 수정하시오.

-- 4. 예제 1에서 생성한 테이블의 모든 데이터를 삭제하시오.

-- 5. dept_name과 title을 합성한 컬럼을 만드시오.

-- 6. s_emp 테이블에서 salary가 1000이상인 직원 출력

-- 7. s_emp 테이블에서 입사일이 2015년 12월 31일 이전인 직원

-- 8. s_emp에서 월급이 1000이상 1500이만인 직원 출력

-- 9. s_emp에서 dept_id가 110이나 113인 직원 출력

-- 10. s_emp에서 16년에 입사한 직원 출력

-- 11. s_emp에서 dept_id가 110이나 113이면서 salary가 2000 이상인 직원 출력

-- 12. dept_id별 평균 급여를 계산해서 보여주시오.

-- 13. dept_id별로 직책이 사원인 직원들의 평균 급여를 계산해서 보여주시오.

-- 14. 각 지역(region_id)별로 몇 개의 부서가 있는지를 나타내시오.

-- 15. 각 부서별로 평균 급여를 구하되 평균 급여가 2000 이상인 부서만 나타내시오.

-- 16. 각 직책별로 급여의 총합을 구하되 직책이 부장인 사람은 제외하시오.
--     단, 급여총합이 8000(만원) 이상인 직책만 나타내며, 급여 총합에 대한 오름차순으로 정렬하시오.

-- 17. 각 부서별로 직책이 사원인 직원들에 대해서만 평균 급여를 구하시오.

-- 18. 각 부서내에서 각 직책별로 몇 명의 인원이 있는지를 나타내시오.

-- 19. 각 부서(dept id) 내에서 몇 명의 직원이 근무하는지를 나타내시오 

-- 20. 각 부서별로 급여의 최소값과 최대값을 나타내시오. 단, 최소값과 최대값이 같은 부서는 출력하지 마시오.

-- 21. 최근 12개월동안의 날짜(yyyymm)출력하기
select to_char(add_months(sysdate,-1 * level), 'yyyymm') "최근 12개월 동안의 날짜" 
from dual
connect by level <= 12;

-- 22. 15년도 월별 입사자의 수를 세어서 출력하시오. 단, 1월 12월까지 월별로 출력하시오. 입사자가 없는달은 0으로 출력하시오.
/*
    없는게 나와야 한다. -> outer join을 사용해야 한다.
    nvl(왼쪽 컬럼, 0)
*/
select * 
from (
    select dept_id, to_char(start_date,'mm') 입사월
    from s_emp
    where extract (year from start_date) = 2015
    )
pivot (
    count (*)
    for 입사월
    in ('01' "1월", 
        '02' "2월", 
        '03' "3월", 
        '04' "4월", 
        '05' "5월", 
        '06' "6월", 
        '07' "7월", 
        '08' "8월", 
        '09' "9월", 
        '10' "10월", 
        '11' "11월", 
        '12' "12월"
        )
    )
;

-- 23. 직원(S_EMP)테이블과 부서(S_DEPT)테이블을 JOIN하여, 사원의 이름과 부서, 부서명을 나타내시오.
select e.name, d.id, d.name
from s_emp e, s_dept d
where d.id = e.dept_id
;

-- 24. 서울 지역에 근무하는 사원에 대해 각 사원의 이름과 근무하는 부서명을 나타내시오.
select e.name 이름, d.name 부서명
from s_emp e, s_dept d, s_region r
where r.id = d.region_id
and d.id = e.dept_id
and r.name like '서울%'
;

-- 25. 직원 테이블(S_EMP)과 급여 테이블(SALGRADE)을 JOIN하여 사원의 이름과 급여, 그리고 해당 급여등급을 나타내시오.
select e.name 이름, e.salary 급여, s.grade 급여등급
from s_emp e, salgrade s
where e.salary between s.losal and hisal
;

-- 26. 직원(S_EMP)테이블과 고객(S_CUSTOMER)테이블에서 사원의 이름과 사번, 그리고 각 사원의 담당고객 이름을 나타내시요. 단, 고객에 대하여 담당영업사원이 없더라도 모든 고객의 이름을 나타내고, 사번 순으로 오름차순 정렬하시오.
select e.name 사원이름, e.id 사번, c.name 담당고객
from s_emp e, s_customer c
where c.sales_rep_id = e.id(+)
order by 사번
;

-- 27. 직원 중에 '김정미' 와 같은 직책(title)을 가지는 사원의 이름과 직책, 급여, 부서번호를 나타내시오(SELF JOIN을 사용할 것)
select t2.name, t1.title, t2.salary
from s_emp t1, s_emp t2
where t1.title = t2.title
and t1.name = '김정미'
and t2.name not like '김정미'
;

-- 28. s_emp테이블에서 dept_id가 110인 직원이름, 부서, 직급 테이블과 dept_id가 113인 테이블의 합집합을 나타내시오. 단, id를 기준으로 정렬하시오.
select *
from s_emp
where dept_id = 110

union

select *
from s_emp
where dept_id = 113
order by 1
;

-- 29. s_emp 테이블에서 김정미와 같은 dept_id를 갖는 직원명, 직급, dept_id를 출력하시오.
select *
from s_emp
where dept_id = (
    select dept_id
    from s_emp
    where name = '김정미'
    )
;

-- 30. s_dept 테이블에서 지역 번호가 3인 부서의 id가 s_emp테이블에서 dept_id와 동일한 직원들의 이름과 dept_id를 출력하시오.
select name, dept_id
from s_emp
where dept_id in (
    select id
    from s_dept
    where region_id = 3
    )
;

-- 31. s_emp 테이블에서 부서별로 가장 적은 salary를 받는 직원의 name과 salary를 통해 직원의 name, dept_id, salary를 출력하시오.
select name, dept_id, salary
from s_emp
where (dept_id, salary) in (
    select dept_id, min(salary)
    from s_emp
    group by dept_id
    )
;

-- 32. inline view로 s_emp 테이블에서 사원인 직원들의 부서번호를 s_dept 테이블에서 찾아 직원들의 name, title, 부서명(name)을 출력하시오.
select e.name, e.title, d.name
from (select name, title, dept_id
    from s_emp
    where title = '사원') e, s_dept d
where e.dept_id = d.id
;

-- 33. 가장 적은 평균 급여를 받는 직책에 대해 그 직책과 평균급여를 나타내시오.
select title, avg(salary)
from s_emp
group by title
having avg(salary) = (
    select min(avg(salary))
    from s_emp
    group by title
    )
;

-- 34. s_emp 테이블에서 dept_id가 113인 직원들의 id, name, mailid, start_date를 복사한 emp_113테이블을 만드시오.
create table emp_113("직원id", "직원명", "메일아이디", "입사일")
as select id, name, mailid, start_date
from s_emp
where dept_id = 113
;

-- 35. 예제 34에서 만든 테이블에 s_emp 테이블에서 입사일이 2016년 1월 1일 이전에 입사한 직원들의 id, name, mailid, start_date를 삽입하시오.
insert into emp_113
select id, name, mailid, start_date
from s_emp
where start_date < to_date('2016-01-01', 'yyyy-mm-dd')
;

-- 36. s_emp 테이블에서 name이 안창환인 사람의 dept_id를 title이 사장인 사람들의 부서번호로 변경해라
update s_emp
set dept_id = (select dept_id
                from s_emp
                where title = '사장')
where name = '안창환'
;

-- 37. s_emp 테이블에서 봉급 순위 6등부터 10등까지 가져오기
select *
from (select rownum rnum, name, salary
        from (select name, salary
                from s_emp
                order by salary desc, name)
        where rownum <= 10)
where rnum >= 6
;

-- 38. 시퀀스 s_emp_id 생성해라. 단 시퀀스는 1씩 증가하고, 26부터 시작하며, 최대값은 9999999이고, 미리 만들어 놓지 말고, 반복은 하지 않도록 작성해라.
create sequence s_emp_id
    increment by 1
    start with 26
    maxvalue 9999999
    nocache
    nocycle
;

-- 39. s_emp 테이블의 이름 컬럼에 인덱스 생성하시오.
create index name_index
on f_emp(name);

-- 40. decode 함수 이용해서 S_EMP테이블에서 각 사원의 이름과 급여, 급여등급을 나타내시오. 급여가 4000만원 이상이면 A등급, 3000만원 이상이면 B등급, 2000만원 이상이면 C등급, 1000만원 이상이면 D등급, 1000만원 이상이면 E등급으로 나타내시오.
select name 사원이름, salary 급여, decode(trunc(salary/1000),0,'E',1,'D',2,'C',3,'B','A') 급여등급
from s_emp
;

-- 41. case문을 사용해서 id, name 컬럼과 salary가 1000미만인 경우 very low,  2500이하인 경우 low, 5000이상인 경우 high 나머지는 medium입력되는 컬럼 작성하기
select id, name,
    (case 
        when salary < 1000 then 'very low'
        when salary <= 2500 then 'low'
        when salary >= 5000 then 'high'
        else 'medium'
    end) 급여등급
from s_emp
;

-- 42. 부서별 title인원을 구하시오. 없으면 0으로 표시해라.('사장', '기획부장', '영업부장', '총무부장', '인사부장', '과장', '영업대표이사', '사원')
select *
from (select dept_id, title 
        from s_emp)
pivot (
        count(*)
        for title
        in('사장', '부장', '과장', '영업대표이사', '사원') --'기획부장', '영업부장', '총무부장', '인사부장'
)
order by dept_id
;

-- 43. rollup를 사용해서 dept_id가 106, 112, 113인 직원의 dept_id와 title별 인원수를 출력하라.
select dept_id, title, count(*)
from s_emp
where dept_id in (106,112,113)
group by rollup(dept_id, title)
order by dept_id
;

-- 44. cube를 사용해서 dept_id가 106, 112, 113인 직원의 dept_id와 title별 인원수를 출력하라.
select dept_id, title, count(*)
from s_emp
where dept_id in (106,112,113)
group by cube(dept_id, title)
order by dept_id
;

-- 45. salary가 높은 사람이 1등이 되도록 id, name, salary, rank 칼럼을 작성하시오.
select id, name, salary, rank() over (order by salary desc) rank
from s_emp
;

-- 46. 부서(dept_id)별로 salary가 높은 사람이 1등이 되도록 하는 rank 컬럼, dept_id, name, salary를 출력하시오.
select 
    rank() over (
        partition by dept_id
        order by salary desc
        ) as rank, dept_id, name, salary
from s_emp
;

-- 47. 자신의 급여가 자신이 속한 부서의 평균 급여보다 적은 직원에 대해 이름, 급여, 부서번호를 출력하시오.
select name, salary, dept_id
from s_emp outer
where salary < (select avg(salary)
                from s_emp
                where dept_id = outer.dept_id)
;

-- 48. 본인의 급여가 각 부서별 평균 급여 중 어느 한 부서의 평균 급여보다 적은 급여를 받는 직원에 대해 이름, 급여, 부서번호를 출력하시오.
select name, salary, dept_id
from s_emp
where salary < any(select avg(salary)
                    from s_emp
                    group by dept_id)
;

-- 49. 본인이 다른 사람의 관리자(manager_id)로 되어 있는 직원의 사번, 이름, 직책, 부서번호를 나타내시오.
select id, name, title, dept_id
from s_emp outer
where exists (select id
                    from s_emp
                    where outer.id = manager_id)
;

select id, name, title, dept_id
from s_emp outer
where exists (select id
                    from s_emp
                    where outer.manager_id = id)
;

-- 50. 직원(s_emp) 테이블에서 이름을 사전순으로 정렬하여 5개의 데이터만 나타내시오.
-- 강연범, 구원상, 김석우, 김심선, 김정미 
select id, name, title, dept_id
from (select rownum rnum, id, name, title, dept_id
        from s_emp
        order by name)
where rnum <= 5
;

-- 51. index를 이용해서 title이 사원이 아닌 직원의 id, name, title을 출력하시오.
select id, name, title
from s_emp e
where not exists (select 'X'
                    from s_emp
                    where e.title = '사원')
;