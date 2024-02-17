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

-- 22. 15년도 월별 입사자의 수를 세어서 출력하시오. 단, 1월 12월까지 월별로 출력하시오. 입사자가 없는달은 0으로 출력하시오.

-- 23. 직원(S_EMP)테이블과 부서(S_DEPT)테이블을 JOIN하여, 사원의 이름과 부서, 부서명을 나타내시오.

-- 24. 서울 지역에 근무하는 사원에 대해 각 사원의 이름과 근무하는 부서명을 나타내시오.

-- 25. 직원 테이블(S_EMP)과 급여 테이블(SALGRADE)을 JOIN하여 사원의 이름과 급여, 그리고 해당 급여등급을 나타내시오.

-- 26. 직원(S_EMP)테이블과 고객(S_CUSTOMER)테이블에서 사원의 이름과 사번, 그리고 각 사원의 담당고객 이름을 나타내시요. 단, 고객에 대하여 담당영업사원이 없더라도 모든 고객의 이름을 나타내고, 사번 순으로 오름차순 정렬하시오.

-- 27. 직원 중에 '김정미' 와 같은 직책(title)을 가지는 사원의 이름과 직책, 급여, 부서번호를 나타내시오(SELF JOIN을 사용할 것)

-- 28. dept_id가 110인 직원이름, 부서, 직급 테이블과 dept_id가 113인 테이블의 합집합을 나타내시오. 단, id를 기준으로 정렬하시오.

-- 29. s_emp 테이블에서 김정미와 같은 dept_id를 갖는 직원명, 직급, dept_id를 출력하시오.

-- 30. s_emp 테이블에서 지역 번호가 3인 직원의 id와 dept_id와 동일한 직원들의 이름, dept_id를 출력하시오.

-- 31. s_emp 테이블에서 부서별로 가장 적은 salary를 받는 직원의 name과 salary를 통해 직원의 name, dept_id, salary를 출력하시오.

-- 32. inline view로 s_emp 테이블에서 사원인 직원들의 부서번호를 s_dept 테이블에서 찾아 직원들의 name, title, 부서명(name)을 출력하시오.

-- 33. 가장 적은 평균 급여를 받는 직책에 대해 그 직책과 평균급여를 나타내시오.

-- 34. s_emp 테이블에서 dept_id가 113인 직원들의 id, name, mailid, start_date를 복사한 emp_113테이블을 만드시오.

-- 35. 예제 34에서 만든 테이블에 s_emp 테이블에서 입사일이 2016년 1월 1일 이전에 입사한 직원들의 id, name, mailid, start_date를 삽입하시오.

-- 36. s_emp 테이블에서 name이 안창환인 사람의 dept_id를 title이 사장인 사람들의 부서번호로 변경해라

-- 37. s_emp 테이블에서 봉급 순위 6등 부터 10등까지 가져오기

-- 38. 시퀀스 s_emp_id 생성해라. 단 시퀀스는 1씩 증가하고, 26부터 시작하며, 최대값은 9999999이고, 미리 만들어 놓지 말고, 반복은 하지 않도록 작성해라.

-- 39. s_emp 테이블의 이름 컬럼에 인덱스 생성하시오.

-- 40. decode 함수 이용해서 S_EMP테이블에서 각 사원의 이름과 급여, 급여등급을 나타내시오. 급여가 4000만원 이상이면 A등급, 3000만원 이상이면 B등급, 2000만원 이상이면 C등급, 1000만원 이상이면 D등급, 1000만원 이상이면 E등급으로 나타내시오.

-- 41. case문을 사용해서 id, name 컬럼과 salary가 1000미만인 경우 very low,  5000이하인 경우 low, 5000이상인 경우 high 나머지는 medium입력되는 컬럼 작성하기

-- 42. 부서별 title인원을 구하시오. 없으면 0으로 표시해라.

-- 43. rollup를 사용해서 dept_id가 106, 112, 113인 직원의 dept_id와 title별 인원수를 출력하라.

-- 44. cube를 사용해서 dept_id가 106, 112, 113인 직원의 dept_id와 title별 인원수를 출력하라.

-- 45. salary가 높은 사람이 1등이 되도록 id, name, salary, rank 칼럼을 작성하시오.

-- 46. 부서(dept_id)별로 salary가 높은 사람이 1등이 되도록 하는 rank 컬럼, dept_id, name, salary를 출력하시오.

-- 47. 자신의 급여가 자신이 속한 부서의 평균 급여보다 적은 직원에 대해 이름, 급여, 부서번호를 출력하시오.

-- 48. 본인의 급여가 각 부서별 평균 급여 중 어느 한 부서의 평균 급여보다 적은 급여를 받는 직원에 대해 이름, 급여, 부서번호를 출력하시오.