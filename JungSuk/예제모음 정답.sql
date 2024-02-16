-- 1. 테이블을 생성하시오.
/*  컬럼명        data type   길이  default
    id          NUMBER      5
    name        char        25
    salary      number      7,2
    title       char        25      사원
    in_date     date                sysdate
    dept_name   char        25
*/

-- 2. 예제 1에서 생성한 테이블에 데이터를 입력하시오.

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

-- 19. 각 부서(dept id) 내에서 몇 명의 직원이 근무하는지를 나타내시오 -- 101: 1, 102: 2, 103: 1, 104: 1, 105: 1, -- 106: 2, 110: 4, 111: 3, 112: 3, 113: 5, 118: 2

-- 20. 각 부서별로 급여의 최소값과 최대값을 나타내시오. 단, 최소값과 최대값이 같은 부서는 출력하지 마시오.

-- 21. 최근 12개월동안의 날짜(yyyymm)출력하기
select to_char(add_months(sysdate,-1 * level), 'yyyymm') "최근 12개월 동안의 날짜" 
from dual
connect by level <= 12;

-- 22. 15년도 월별 입사자의 수를 세어서 출력하시오. 단, 1월 12월까지 월별로 출력하시오. 입사자가 없는달은 0으로 출력하시오.
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

select * from salgrade;

select *
from s_emp
;

select *
from s_dept
;

select *
from s_region
;