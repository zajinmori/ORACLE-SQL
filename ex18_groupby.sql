/*

        ex18_groupby.sql
        
        
         [WITH<sub QUERY>]
        
        SELECT column_list
        FROM table_name
        
        [WHERE search_condition] 
        
        [GROUP BY group_by_expression]
        
        [HAVING serch-condition]
        
        [ORDER BY order_expression [ASC|DESC]];
        


        ORDER BY절
            - 정렬
            - ORDER BY 컬럼명 [생략](오름차순)
            - ORDER BY 컬럼명 [ASC](오름차순)
            - ORDER BY 컬럼명 [DESC](내림차순)
        
    
        
        역할
            SELECT 컬럼리스트   : 컬럼 소스(테이블 지정 후 어떤 컬럼을? 즉, 컬럼지정 -> 컬럼을 가져와라)
            FROM 테이블명       : 데이터 소스(어떤 테이블로부터? 즉, 테이블지정 -> 데이터를 가져와라)
            WHERE 검색조건      : 조건을 지정, 원하는 레코드만 걸러낸다.
            GROUP BY 그룹기준   : 특정 컬럼값을 기준으로 여러 그룹을 나눈다.
            ORDER BY 정렬기준   : 결과셋의 레코드 순서를 정한다.
            
            
       *** 순서 ***
            4번, SELECT
            1번, FROM (***무조건 첫번째)
            2번, WHERE
            3번, GROUP BY
            5번, ORDER BY (***무조건 마지막)
        
        
        
        
        GROUP BY 절
            - 특정 기준으로 레코드를 그룹으로 나눈다(수단)
                > 각각의 그룹을 대상으로 집계 함수를 실행한다(목적)
    
*/

-- 부서별 평균 급여 ??
select*from tblinsa;

select round(avg(basicpay)) from tblinsa; --1556527
select distinct buseo from tblinsa;

select round(avg(basicpay)) from tblinsa where buseo = '총무부'; --1714857
select round(avg(basicpay)) from tblinsa where buseo = '개발부'; --1387857
select round(avg(basicpay)) from tblinsa where buseo = '영업부'; --1601513
select round(avg(basicpay)) from tblinsa where buseo = '기획부'; --1855714
select round(avg(basicpay)) from tblinsa where buseo = '인사부'; --1533000
select round(avg(basicpay)) from tblinsa where buseo = '자재부'; --1416733
select round(avg(basicpay)) from tblinsa where buseo = '홍보부'; --1451833

-- 1개의 select문(GROUP BY 사용법)
select 
    buseo,
    round(avg(basicpay))as "부서별 평균 급여",
    count(*)as "부서별 인원수",
    sum(basicpay)as "부서별 총지급액",
    max(basicpay)as "부서내 최고급여",
    min(basicpay)as "부서내 최저급여"
from tblinsa
    group by buseo;
    
    
-- 남자가 몇명 ? 여자가 몇명 ?

select 
    count(decode(gender, 'm', 1))as 남자수,
    count(decode(gender, 'f', 1)) as 여자수
from tblcomedian; --컬럼으로 구분가능 -> 경직된 방법(성별이 늘어나면 직접 대처해야함)


select
    gender, count(*)
from tblcomedian
    group by gender; --레코드값으로 구분가능 -> 유연한 방법(성별이 늘어나도 알아서 대처함)
    


select 
    jikwi, count(*)
from tblinsa
    group by jikwi;
    
    
select 
    city, count(*)
from tblinsa
    group by city
        order by count(*) desc;


select
    name, count(*)
from tblinsa
    group by name;


--다중그룹 만들기
select
    buseo, jikwi, count(*)
from tblinsa
    group by buseo, jikwi; --부서와 직위별로 나눔 = 다중그룹
    


select
    buseo, jikwi, count(*)
from tblinsa
    group by jikwi,buseo; --순서가 바뀌어도 큰 영향이 없다



-- 급여별 그룹
-- 100만원 이하 받는 그룹
-- 100~200만원 이하 받는 그룹
-- 200만원 이상 받는 그룹
select
    basicpay, count(*)
from tblinsa
    
    group by basicpay;

select
    basicpay,
    (floor(basicpay / 1000000) +1)*100 || '만원 이하'
from tblinsa;



select
    floor(basicpay / 1000000),count(*),
    (floor(basicpay / 1000000) +1)*100 || '만원 이하'
from tblinsa
    group by floor(basicpay / 1000000);
    
    
    
-- 여자수? 남잣?
select * from tblinsa;

select
    substr(ssn,8,1), count(*)
from tblinsa
    group by substr(ssn,8,1);


select
    count(*)
from tblinsa
    group by (case when ssn like '%-2%' then 1 end);


-- 한 일의 개수? 아직 안한 일 개수??
select
    case
        when completedate is null then '안한일'
        when completedate is not null then '한일'
    end, count(*)
from tbltodo
    group by case
        when completedate is null then '안한일'
        when completedate is not null then '한일'
    end;
    
    
    
select
    case
        when completedate is null then '안한일'
        when completedate is not null then '한일'
    end
from tbltodo
    group by case
        when completedate is null then '안한일'
        when completedate is not null then '한일'
    end ; 
    
    
    
    
-- 직위별 인원 > 과장+부장? , 사원+대리?
select
    jikwi, count(*)
from tblinsa
    group by jikwi;
    
    
select
    case
        when jikwi in('과장', '부장') then '관리직'
        when jikwi in('대리', '사원') then '현장직'
    end,
    count(*)
from tblinsa
    group by  case
        when jikwi in('과장', '부장') then '관리직'
        when jikwi in('대리', '사원') then '현장직'  -- group by에 들어가는 값은 위에 값이랑 똑같아야한다.
    end ;                                       




-- group by 사용 시 주의사항 !!! > 집계함수의 주의점과 비슷함

--ORA-00979: not a GROUP BY expression 
    -- -> group by가 포함된 select문은 목적이 그룹에 관련된 질의
    -- -> select절에서 일반 컬럼(개인 데이터)는 사용이 불가능하다.
    -- -> 집계함수 또는 group by의 기준이 되는 컬럼만 사용가능하다.

select
    count(*), name
from tblinsa
    group by jikwi;







/*


 ex18_groupby.sql
        
        
         [WITH<sub QUERY>]
        
        SELECT column_list
        FROM table_name
        
        [WHERE search_condition] 
        
        [GROUP BY group_by_expression]
        
        [HAVING serch-condition]
        
        [ORDER BY order_expression [ASC|DESC]];
        


        ORDER BY절
            - 정렬
            - ORDER BY 컬럼명 [생략](오름차순)
            - ORDER BY 컬럼명 [ASC](오름차순)
            - ORDER BY 컬럼명 [DESC](내림차순)
        
    
        
        역할
            SELECT 컬럼리스트   : 컬럼 소스(테이블 지정 후 어떤 컬럼을? 즉, 컬럼지정 -> 컬럼을 가져와라)
            FROM 테이블명       : 데이터 소스(어떤 테이블로부터? 즉, 테이블지정 -> 데이터를 가져와라)
            WHERE 검색조건      : 조건을 지정, 원하는 레코드만 걸러낸다.
            GROUP BY 그룹기준   : 특정 컬럼값을 기준으로 여러 그룹을 나눈다.
            HAVING 검색조건     : 조건을 지정, 원하는 그룹만 걸러낸다.
            ORDER BY 정렬기준   : 결과셋의 레코드 순서를 정한다.
            
            
       *** 순서 ***
            5번, SELECT
            
            1번, FROM (***무조건 첫번째)
            2번, WHERE
            
            3번, GROUP BY
            4번, HAVING
            
            6번, ORDER BY (***무조건 마지막)



*/

select
    count(*)
from tblinsa
    where basicpay >= 1500000;
    
    
    -- 개인에 대한(개인영역)
select
    buseo, count(*)             --4, 집계함수 호출
from tblinsa                    --1, 60명의 데이터를 가져온다.
    where basicpay >= 1500000   --2, 60명을 대상으로 조건을 검사한다.
    group by buseo;             --3, 2번을 통과한 사람들을 대상으로 그룹 짓는다. (나머지는 버린다)
    
    
    -- 그룹에 대한 (집합영역)
select
    buseo, count(*)                         --4, 그룹함수
from tblinsa                                --1, 60명의 데이터를 가져온다.
    group by buseo                          --2, 60명을 대상으로 그룹을 짓는다.
        having avg(basicpay)>=1500000;      --3, 그룹을 대상으로 조건을 검사한다. (조건 충족이 안되는 그룹은 버린다)
    





select
    buseo, count(*)                         
from tblinsa         
    where basicpay >= 1500000 
    group by buseo                          
        having avg(basicpay)>=1500000; 




-- 부서별(group by) 과장/부장의(where절) 인원수가 3명 이상인(having) 부서들 ? 
select
    buseo, count(*)
from tblinsa
    where jikwi in('과장','부장')
        group by buseo
            having count(*) >=3;
    



























