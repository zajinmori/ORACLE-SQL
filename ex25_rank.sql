/*

        ex25_rank.sql
        
        
        순위 함수
            - rownum 기반으로 만들어진 함수
            
                1. rank() over(order by 컬럼명 [asc|desc])
                    -동일값 = 동일 순위
                    -누적o..
                
                2. dense_rank() over(order by 컬럼명 [asc|desc])
                    -동일값 = 동일 순위
                    -누적x !
                
                3. row_number() over(order by 컬럼명 [asc|desc])
                    -rownum 동일 !!

*/

-- tblinsa, 급여순으로 가져오시오. +순위표시  
---------rownum 사용
select a.*, rownum from
(select 
    name, buseo, basicpay 
from tblinsa
order by basicpay desc)a;


------1. rank() over(order by 컬럼명 [asc|desc]) 사용 --같은값이면 같은등수이다 근데 같은값 다음은 누적이되어서 점프한다
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum   --rank() -> rownum을 계산해줌
from tblinsa;


-------2. dense_rank() over(order by 컬럼명 [asc|desc]) 사용 --같은값이면 같은등수이다 근데 같은값 다음은 누적이 안된다.


select
    name, buseo, basicpay,
    dense_rank() over(order by basicpay desc) as rnum 
from tblinsa;




--------3. row_number() over(order by 컬럼명 [asc|desc]) 사용 --rownum이랑 결과가 같다 ! 

select
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum 
from tblinsa;





-- 급여 5위 / 어쨌든 서브쿼리를 1번은 써야함
select * from (select
                name, buseo, basicpay,
                row_number() over(order by basicpay desc) as rnum 
                from tblinsa)
                    where rnum = 5;


-- 순위 함수(+ order by)
-------------------------------------------------------------------------------
-- 순위 함수(+ order by + partition by) > order by + group by > 그룹별 순위

--부서별 급여 순위 partition by 사용
select
    name, buseo, basicpay,
    rank() over(partition by buseo order by basicpay desc) as rnum
from tblinsa;



select * from(select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblinsa)
    where rnum = 1; --전직원 연봉 1위



--부서별 급여 1위
select*from(select
    name, buseo, basicpay,
    rank() over(partition by buseo order by basicpay desc) as rnum
from tblinsa)
    where rnum = 1;


-- with절 사용
with aaa as (select
    name, buseo, basicpay,
    rank() over(partition by buseo order by basicpay desc) as rnum
    from tblinsa)
select * from aaa where rnum = 1; 












