/*


    ex08_aggregation_function.sql
    
    
    메서드
        - 함수, 프로시저 등..
        - 클래스안에서 선언한 함수
        
        
    함수, Function
        1. 내장 함수(Built-in Function)
        2. 사용자 정의 함수(User Function) > 표준SQL(X), PL/SQL(O)
        
        
        
        
    집계 함수, Aggregation Function
        - Java Stream > count(), sum(), max(), min(), average()
        - Vㅔ리 쉬움 > 나중에 하는 수업과 결함 > Vㅔ리 어려움ㅋㅋ
        
        
        
        1. count()
        2. sum()
        3. avg()
        4. max()
        5. min()
        
        
        
            
            1. count()
                - 결과 테이블의 레코드 수를 반환한다.
                - number count(컬럼명)
                - **** null값은 제외한다 ****
                
        
        
        
        
        
         

*/


select*from tblcountry;
select count(*)from tblcountry; -- count == 레코드 수

select name from tblcountry;
select count(name) from tblcountry;

select population from tblcountry;
select count(population) from tblcountry; --13이 나온다 왜냐면 null은 없는 값이기 때문이다.


--총 직원은 몇명?
select count(*) from tblinsa; -- 60명

--연락처가 있는 직원은 몇명?
select count(tel) from tblinsa; --57명
--연락처가 없는 직원은 몇명?
select count(*) - count(tel) from tblinsa; --3명


--연락처가 있는 직원은 몇명?
select count(*) from tblinsa where tel is not null; --57명
--연락처가 없는 직원은 몇명?
select count(*) from tblinsa where tel is null; --3명


--tblinsa 어떤 부서들 있나? > 부서가 총 몇개??
select count(DISTINCT buseo) from tblinsa; --7개



-- tblcomedian 남자수? 여자수?
select * from tblcomedian;

select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

-- tblcomedian 남자수? 여자수? > 1개의 테이블 > 자주 사용함 !!!!
select 
    count(case
        when gender='m' then '남자'
    end),
    count(case
        when gender='f' then '여자'
    end)
from tblcomedian; -- 8 / 2 1개의 테이블에 남자수 여자수를 넣어봄



select 
    count(case
        when gender='m' then 1
    end),
    count(case
        when gender='f' then 1
    end)
from tblcomedian; -- 8 / 2 then 값을 의미 없게 만들어도 됨




--tblinsa 기획부 몇명? 총무부 몇명? 개발부 몇명? > 1개의 테이블
select 
    count(case
        when buseo='기획부' then 0
    end)as 기획부,
    count(case
        when buseo='총무부' then 0
    end)as 총무부,
    count(case
        when buseo='개발부' then 0
    end)as 개발부,
    count(case
        when buseo not in('기획부','총무부','개발부') then 0 -- not in = 기획부,총무부,개발부를 빼고라는 뜻
    end)as 나머지,
    count(*) as 총직원수
from tblinsa;





select
    name as "employee name", --식별자에 띄어쓰기 넣고 싶을때 ""쓰기 근데 식별자에 띄어쓰기는 지양해야함
    buseo as "select"        --암튼 두개는 절때 하지말것
from tblinsa;




/*


    2. sum()
        -해당 컬럼값의 합을 구한다.
        - number sum(컬럼명)
        - 숫자형에만 가능하다.
        





*/

select * from tblcountry;

select count(area) from tblcountry; --14 : 레코드개수


select sum(area) from tblcountry;   --3459 : 수치의 합
select sum(name) from tblcountry;   --ORA-01722: invalid number : 문자는 안된다
select sum(ibsadate) from tblcountry; --ORA-00904: "IBSADATE": invalid identifier : 날짜도 안된다.
select sum(*) from tblcountry;      --ORA-00936: missing expression : *도 안된다.


select
    sum(basicpay) as "지출 급여 합",
    sum(sudang) as "지출 수당 합",
    sum(basicpay) + sum(sudang) as " 총 지출",
    sum(basicpay + sudang) as "총 지출"
from tblinsa;






/*


    3.  avg()
        - 해당 컬럼값의 평균값을 구한다.
        - number avg(컬럼명)
        - 숫자형에만 적용 가능
        - null은 제외


*/

-- tblinsa 평균 급여를 구하시오
select sum(basicpay) from tblinsa; --총 급여
select sum(basicpay)/60 from tblinsa; --1556526 직원수가 추가되면 문제가 생김
select sum(basicpay)/count(*) from tblinsa; --count(*)를 쓰면 직원이 추가가되어도 상관없음

select avg(basicpay) from tblinsa; --avg를 사용 / GOAT..


-- tblcountry 14개국의 평균 인구수?
select sum(population) /14 from tblcountry; --202652 > 14475
select sum(population) /count(*) from tblcountry; --14475

select avg(population) from tblcountry; --15588 왜??
select count(*) from tblcountry; --14개국가
select count(population) from tblcountry; --13개국가(케냐의 인구수가 없다)
select sum(population) / count(population) from tblcountry; --15588

-- 회사 > 성과급 지급 > 3개의 팀 > 성과급(이익)의 출처:1팀
-- 1. 균등 지금 > 총성과급 /모든직원수 = sum() / count(*)
-- 2. 차등 지급 > 총성과급 /1팀직원수 = sum() / count(1팀직원수) = avg() 즉, null값은 제외하고 나눈다.







/*

    4. max()
        - 최댓값 반환
        - object max(컬럼명)
    
    
    5. min()
        - 최솟값 반환
        - object min(컬럼명)
        
        
        
    -컬럼명 + 반환값 > 숫자형, 문자형, 날짜시간형 = object라고 표현

*/

select max(basicpay), min(basicpay) from tblinsa;   --숫자형
select max(name), min(name) from tblinsa;           --문자형
select max(ibsadate), min(ibsadate) from tblinsa;   --날짜시간형






-- 집계함수 정리

select
    count(*) as 직원수,
    sum(basicpay) as 총급여합,
    avg(basicpay) as 평균급여,
    max(basicpay) as 최고급여,
    min(basicpay) as 최저급여
from tblinsa; 


-- 집계함수 사용 시 주의점 !! + *** 집계 함수의 특성 ***
    --ORA-00937: not a single-group group function
        -- 컬림 리스트(SELECT절)에서는 집계 함수(count(*))와 일반컬럼(name)을 동시에 사용할 수 없다.
            -- 왜?? name은 개인의 데이터이고 count(*)은 모두의 데이터이기 때문에 둘이 같이 있을 수가 없다.
            
    --ORA-00934: group function is not allowed here
        --where절에는 집계 함수를 사용할 수 없다.
            -- 왜?? where절은 개인에 대한 조건절이기 때문이다. > 집합 값을 사용 불가능..
                -- 서브쿼리로 해결 !!

--요구사항] 직원들 이름과 총직원수를 가져오시오
select name, count(*) from tblinsa; --ORA-00937: not a single-group group function / 같이 쓸 수 없다..!


--요구사항] 평균 급여보다 더 많이 받는 직원들 ??
select avg(basicpay) from tblinsa; --1556526

select * from tblinsa where basicpay >= 1556526; --27명  <-1556526 평균값이 변할수 있어서 좋지 않은 쿼리다
select * from tblinsa where basicpay >= avg(basicpay); --ORA-00934: group function is not allowed here / where절에는 집계 함수를 사용할 수 없다.













