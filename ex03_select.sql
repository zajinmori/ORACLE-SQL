/*

    ex03_select.sql
    
    SQL
        - Query
        - 시퀄(SEQUEL) == SQL
        
        
    SELECT문
        - DML, DQL 성질
        - 테이블로부터 데이터를 읽어오는 역할
        - C[R]UD -> READ
        - DB(SQL)는 select로 시작해서 select로 끝난다.
        
        
        *** 각각의 절은 역할과 실행 순서가 있다 ***
        [WITH<sub QUERY>]
        
        SELECT column_list
        FROM table_name
        
        [WHERE search_condition]
        
        [GROUP BY group_by_expression]
        
        [HAVING serch-condition]
        
        [ORDER BY order_expression [ASC|DESC]];
        
        
        
        역할
            SELECT column_list : 컬럼 소스(테이블 지정 후 어떤 컬럼을? 즉, 컬럼지정)
            FROM table_name : 데이터 소스(어떤 테이블로부터? 즉, 테이블지정)
        
       *** 순서 ***
           2번, SELECT
           1번, FROM
   

*/

select * --모든 컬럼
from employees;

-- tabs(tables) : 시스템 테이블
-- > 현재 계정이 소유한 테이블 목록

-- *** select문의 결과는 항상 테이블이다 > 결과테이블(Result Table), 결과셋(ResultSet) ***
select*
from tblcountry;
-- 두개가 같은거다.
select name, capital, population, continent, area
from tblcountry;
-- -> 테이블의 모든 컬럼을 가져오는 방법


select name --단일 컬럼(이름만)
from tblcountry; 

select name,capital --다중 컬럼(이름이랑 수도까지)
from tblcountry;

select capital, name --다중 컬럼(순서를 바꿔서 -> 가능하다)
from tblcountry;

select name, name --다중 컬럼(같은거를 두번 -> 쌉가능)
from tblcountry;

select name, length(name) --다중 컬럼(같은걸 가져올땐 이런식으로 많이 씀)
from tblcountry;

select name, length(name) 
from tblcountry;



















