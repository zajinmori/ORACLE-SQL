/*

        ex19_subquery.sql
        
        
        Sub Query
            - 하나의 SQL안에 또 다른 SQL을 사용하는 기술
            
            
                1. Main Query
                    - 일반 SQL 구문(select, insert, update, create 등..)
                    - 또 다른 SQL을 포함하는 바깥쪽 SQL
                
                2. Sub Query ***자주 씀***
                    - 하나의 SQL안에 포함된 또 다른 SQL
                    - select(main) <- select(sub)
                    - insert(main) <- select(sub)
                    - update(main) <- select(sub)
                    - delete(main) <- select(sub)
                    - 서브 쿼리 삽입 위치 > 대부분의 절에 가능(select절, where절, order by절 ..)
                        > 값을 넣을수 있는 곳이면 사용 가능 > 상수 or 컬럼명 or 함수 호출 or 서브 쿼리



*/

-- Sub Query 사용법

-- 인구수가 가장 많은 나라의 이름 ? 
select max(population) from tblcountry; -- 120660
select name from tblcountry where population = 120660; --120660 상수를 넣으면 위험..

--where절(개인에 대한 조건)에서는 집계함수를 아예 못 쓴 다 ! ! ! ! 
select name from tblcountry where population = max(population);

--서브쿼리 사용 ! (소괄호를 꼭 붙혀야함) 1.from 2.where 3.select 순서로 실행
select name from tblcountry where population = (select max(population) from tblcountry);



-- 몸무게가 가장 많이 나가는 사람 ??
select*from tblcomedian;

select max(weight) from tblcomedian; --129

select * from tblcomedian where weight = 129; --유민상

select * from tblcomedian where weight = (select max(weight) from tblcomedian); -- 서브쿼리 사용
select * from tblcomedian where weight = (select min(weight) from tblcomedian); -- 가장 적게 나가는 사람(min사용)



-- 평균 급여보다 많이 받는 직원 ??
select * from tblinsa where basicpay >=(select avg(basicpay)from tblinsa);



-- 남자중에 키가 166cm인 사람의 여자친구의 키는 ?? 
select * from tblmen where height = 166; --양세형
select * from tblwomen where couple = (select name from tblmen where height = 166); --169cm






/*


    서브쿼리의 삽입 위치
        1. 조건절 > 비교값으로 사용하기 위해
            a. 반환값이 1행 1열 > 단일값 반환 > 상수로 취급 > 값 1개 -> =을 사용 ***가장 많이 사용***
            b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교          -> in을 사용
            c. 반환값이 1행 n열 > 다중값 반환 > 그룹 비교            -> n컬럼 : n컬럼
            d. 반환값이 n행 n열 > 다중값 반환 > 열거형 + 그룹 비교   -> in + 그룹 비교


*/

--- 반환값이 n행 1열

-- 급여가 260만원 이상 받는 직원이 근무하는 부서의 직원명단
--ORA-01427: single-row subquery returns more than one row = 부서가 2개가 나왔다 > 값이 1개가 아니라 2개
select * from tblinsa
    where buseo = (select buseo from tblinsa where basicpay >= 2600000);

select * from tblinsa
    where buseo in ('기획부' ,'총무부');
    
-- in을 사용하면 다중값도 가능
select * from tblinsa
    where buseo in (select buseo from tblinsa where basicpay >= 2600000);

--------------------------------------------------------------------------------

-- 반환값이 1행 n열 > 다중값 반환

-- '홍길동'과 같은 지역, 같은 부서인 직원명단 > 서울사는 기획부 직원 명단
select city, buseo from tblinsa where name = '홍길동';

select * from tblinsa where city = '서울' and buseo = '기획부';

select * from tblinsa
    where city = (select city from tblinsa where name = '홍길동')
    and buseo = (select buseo from tblinsa where name = '홍길동');
    
-- 그룹 비교 제일 깔끔함 (순서를 꼭 맞춰줘야함)
select * from tblinsa
    where (city, buseo) = (select city, buseo from tblinsa where name = '홍길동');    



--------------------------------------------------------------------------------

-- 반환값이 n행 n열

-- 급여가 200만원 이상 받는 직원과 같은 지역, 같은 부서의 직원명단

select * from tblinsa
    where (buseo,city) in (select buseo, city from tblinsa where basicpay >= 2600000);







/*


    서브쿼리의 삽입 위치
        1. 조건절 > 비교값으로 사용하기 위해
            a. 반환값이 1행 1열 > 단일값 반환 > 상수로 취급 > 값 1개 -> =을 사용 ***가장 많이 사용***
            b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교          -> in을 사용
            c. 반환값이 1행 n열 > 다중값 반환 > 그룹 비교            -> n컬럼 : n컬럼
            d. 반환값이 n행 n열 > 다중값 반환 > 열거형 + 그룹 비교   -> in + 그룹 비교


        2. 컬럼 리스트 > 결과셋의 컬럼값으로 사용
             - **** 반 드 시 ! 1행 1열을 반환하는 서브쿼리만 사용할 수 있다 !! **** 
                > Scalar 쿼리(원자값 반환)
            a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환
            b. 상관 서브 쿼리 > 메인 쿼리의 일부 컬럼값을 서브쿼리에서 사용
                > **** 대부분의 컬럼리스트의 서브 쿼리는 상관 서브 쿼리이다 ****

*/

--a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환
select
    name, buseo, basicpay,
    (select avg(basicpay) from tblinsa)
from tblinsa;


--ORA-01427: single-row subquery returns more than one row 레코드가 하나만 나와야한다 직위가 60개가 나오기때문
select
    name, buseo, basicpay,
    (select jikwi from tblinsa)
from tblinsa; --레코드를 늘린 경우

--ORA-00913: too many values
select
    name, buseo, basicpay,
    (select jikwi, sudang from tblinsa where num = 1001)
from tblinsa; --컬럼을 늘린 경우


--------------------------------------------------------------------------------


--b. 상관 서브 쿼리 > 메인 쿼리의 일부 컬럼값을 서브쿼리에서 사용
-- 속해 있는 부서별로 평균 급여가 나오게 한것
select
    a.name, a.buseo, a.basicpay,
    (select avg(basicpay) from tblinsa where buseo = a.buseo) --a.buseo는 메인쿼리에서 가져온 부서이다. 메인쿼리에 a.은 생략가능 서브쿼리안에만 a.을 붙혀서 구분 지으면된다
from tblinsa a;


-- 남자의 이름, 키, 몸무게 ?? + 여자친구의 이름, 키, 몸무게 ???
select 
    name,
    height,
    weight,
    couple, 
    (select height from tblwomen where name = tblmen.couple),-- 테이블 이름이 다르기 때문에 별칭을 안붙히고 테이블이름을 붙혔다
    (select weight from tblwomen where name = tblmen.couple)
from tblmen ;







/*


    서브쿼리의 삽입 위치
        1. 조건절 > 비교값으로 사용하기 위해
            a. 반환값이 1행 1열 > 단일값 반환 > 상수로 취급 > 값 1개 -> =을 사용 ***가장 많이 사용***
            b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교          -> in을 사용
            c. 반환값이 1행 n열 > 다중값 반환 > 그룹 비교            -> n컬럼 : n컬럼
            d. 반환값이 n행 n열 > 다중값 반환 > 열거형 + 그룹 비교   -> in + 그룹 비교


        2. 컬럼 리스트 > 결과셋의 컬럼값으로 사용
             - **** 반 드 시 ! 1행 1열을 반환하는 서브쿼리만 사용할 수 있다 !! **** 
                > Scalar 쿼리(원자값 반환)
            a. 정적 서브 쿼리 > 모든 행에 동일한 값을 반환
            b. 상관 서브 쿼리 > 메인 쿼리의 일부 컬럼값을 서브쿼리에서 사용
                > **** 대부분의 컬럼리스트의 서브 쿼리는 상관 서브 쿼리이다 ****
                
                
        3. from절에서 사용
            - 서브쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 메인 쿼리를 실행한다.
            - 인라인 뷰(Inline View)라고 한다.

*/

select * from (select * from tblinsa);
select * from (select * from tblinsa where buseo = '기획부');

















