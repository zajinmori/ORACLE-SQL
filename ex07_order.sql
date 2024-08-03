/*


    ex07_order.sql
    
    
    
    
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
            ORDER BY 정렬기준   : 결과셋의 레코드 순서를 정한다.
            
            
       *** 순서 ***
            3번, SELECT
            1번, FROM (***무조건 첫번째)
            2번, WHERE
            4번, ORDER BY (***무조건 마지막)
    



*/

select*from tblinsa;

select*from tblinsa order by basicpay;
select*from tblinsa order by sudang desc;



--자료형 확인
select*from tblinsa order by basicpay; --숫자형
select*from tblinsa order by name; --문자형
select*from tblinsa order by ibsadate; --날짜시간형

--다중 정렬
select*from tblinsa order by buseo asc; --부서 1차정렬
select*from tblinsa order by buseo asc, jikwi asc; -- 부서,직위 2차정렬 
select*from tblinsa order by buseo asc, jikwi asc, basicpay asc; -- 부서,직위,급여 3차정렬 



-- Java는 첨자가 0부터 시작한다. (컴파일 언어)
-- SQL은 첨자가 1부터 시작한다. (스크립트 언어)
select
    num, name, buseo, jikwi
from tblinsa
    order by 3 asc; --buseo 정렬함 > num,name,buseo > 부서가 3번째이기 때문이다. / 관리하기 힘드니까 최대한 쓰지 말것.
    

--가공된 값을 정렬 기준으로 사용
SELECT * from tblinsa order by basicpay desc;
SELECT * from tblinsa order by basicpay+sudang desc;



-- 남자 > 여자 순으로 정렬
select                                      
    name,ssn,
    case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'    -- 순 서
    end as gender                           -- 2번
from tblinsa                                -- 1번
    order by gender asc;                    -- 3번
    
    
select                                      
    name,ssn,
    case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'    -- 순 서
    end as gender                           -- 2번
from tblinsa                                -- 1번
    order by 3 asc;                         -- 3번 
-- case가 3번째 컬럼이니까 3을 썼다


--직위순으로 정렬 : 부장>과장>대리>사원순으로
select
    name, jikwi,
    case
        when jikwi ='부장'then 1
        when jikwi ='과장'then 2
        when jikwi ='대리'then 3
        when jikwi ='사원'then 4
    end
from tblinsa
    order by 3 asc;
-- case가 3번째 컬럼이니까 3을 썼다





-- 뒤에 쓸데없는 번호를 지우는 방법
select
    name, jikwi
    
from tblinsa
    order by case
        when jikwi ='부장'then 1
        when jikwi ='과장'then 2
        when jikwi ='대리'then 3
        when jikwi ='사원'then 4
    end asc;









