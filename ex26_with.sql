/*


        ex26_with.sql
        
        
        
        
        


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
            WITH 서브쿼리       : 임시뷰를 만든다.
            SELECT 컬럼리스트   : 컬럼 소스(테이블 지정 후 어떤 컬럼을? 즉, 컬럼지정 -> 컬럼을 가져와라)
            FROM 테이블명       : 데이터 소스(어떤 테이블로부터? 즉, 테이블지정 -> 데이터를 가져와라)
            WHERE 검색조건      : 조건을 지정, 원하는 레코드만 걸러낸다.
            GROUP BY 그룹기준   : 특정 컬럼값을 기준으로 여러 그룹을 나눈다.
            HAVING 검색조건     : 조건을 지정, 원하는 그룹만 걸러낸다.
            ORDER BY 정렬기준   : 결과셋의 레코드 순서를 정한다.
            
            
       *** 순서 ***
            1번, WITH,
            6번, SELECT
            
            2번, FROM (***무조건 첫번째)
            3번, WHERE
            
            4번, GROUP BY
            5번, HAVING
            
            7번, ORDER BY (***무조건 마지막)
            
            
            
            
            with절
                -인라인뷰에 이름을 붙이는 기술
                
                with 테이블명 as 서브쿼리
                select문;



*/
        
select* from(select 
                name, buseo, jikwi 
            from tblinsa
                where city = '서울');


with seoul as (select 
                name, buseo, jikwi 
            from tblinsa
                where city = '서울')
                select * from seoul;
                
                

select * from(select name, age, couple from tblmen where weight < 90)a
    inner join (select name, age, couple from tblwomen where weight > 60)b
        on a.couple = b.name;


with men as (select name, age, couple from tblmen where weight < 90),
    women as (select name, age, couple from tblwomen where weight > 60)
select * from men
    inner join women
        on men.couple = women.name;







/*

    null 함수
        - null을 치환하는 함수
        
            null value
            1. nvl(컬럼, 값)
            2. nvl2(컬럼, 값, 값)


*/


--케냐의 null을 0으로 바꿔줘
select
    name,
        case
            when population is not null then population
            when population is null then 0
        end
from tblcountry;


---------1. nvl(컬럼, 값) 사용
select
    name,
    nvl(population, 0)
from tblcountry;


select
    name,
    nvl(population, '조사안됨') --population의 자료형이 number이기 때문에 무조건 숫자만 들어가야함
from tblcountry;




----------2. nvl2(컬럼, 값, 값)
select
    name,
    nvl2(population, 1, 2) --null이 아니면=1 / null이면=2
from tblcountry;

select
    name,
    nvl2(population, '조사완료', '조사미완료') --nvl2는 문자로 반환도 가능하다
from tblcountry;







create table tblitem(
    seq number primary key,
    name varchar2(30) not null,
    color varchar2(30) not null
);

insert into tblitem (seq, name, color)
    values ((select nvl(max(seq),0)+1 from tblitem), '마우스', 'white'); --nvl(max(seq),0)+1 <- seq가 null일경우 0을 돌려준다
    
insert into tblitem (seq, name, color)
    values ((select nvl(max(seq),0)+1 from tblitem), '키보드', 'white'); --(select max(seq)+1 from tblitem) <- seq를 만들어주는 서브쿼리
    
insert into tblitem (seq, name, color)
    values ((select nvl(max(seq),0)+1 from tblitem), '모니터', 'white');   
    

select * from tblitem;

drop table tblitem;





























