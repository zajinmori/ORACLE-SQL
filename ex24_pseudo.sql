/*

        ex24_pseudo.sql
        
        
        의사 컬럼, pseudo column
            - 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
            
            
            rownum
                - 행 번호
                - 결과셋의 행번호 반환
                - 오라클 전용


*/
select
    name, buseo,     --컬럼(속성). 레코드(객체)에 따라 각자 다른 값을 가진다
    100,             --상수. 모든 레코드(객체)가 동일한 값을 가진다
    substr(name,2),  --함수. 레코드(객체)에 따라 다른 값을 가진다
    rownum           --의사 컬럼.
from tblinsa;

select name, buseo, rownum from tblinsa where rownum = 1; --제일 첫번째거를 가져와라
select name, buseo, rownum from tblinsa where rownum <= 5; --위에서부터 5개를 가져와라

-- 게시판 > 페이징
-- 1페이지 > where rownum between 1 and 10
-- 2페이지 > where rownum between 11 and 20 --잘못된 구문이다
-- ...

select name, buseo, rownum from tblinsa where rownum >= 1 and rownum <= 10;
select name, buseo, rownum from tblinsa where rownum >= 11 and rownum <= 20; --안됨
select name, buseo, rownum from tblinsa where rownum >= 21 and rownum <= 30; --안됨


-- *** 1. rownum은 from절이 실행하는 순간 생성된다 ***
-- *** 2. where절에 의해서 결과셋에 변화가 생기면 rownum은 다시 계산된다 ***

select name, buseo, rownum  -- 2. rownum > 1번에서 만들어진 rownum을 그냥 가져온다(읽기만)
from tblinsa;               -- 1. from절이 실행되는 순간 모든 레코드에 rownum할당 ***


select name, buseo, rownum  --3. 읽기
from tblinsa                --1. 할당
    where rownum = 1;       --2. 조건
    
select name, buseo, rownum  --3. 읽기
from tblinsa                --1. 할당
    where rownum = 3;       --2. 조건


select name, buseo, rownum  --3. 읽기
from tblinsa                --1. 할당
    where rownum <= 3;       --2. 조건    


select name, buseo, rownum  --3. 읽기
from tblinsa                --1. 할당
    where rownum >= 5 and rownum <=10;       --2. 조건



-- rownum 사용법
--rownum + sub qurey > 원하는 영역을 가져오기
-- sub query = 1~2개

-- 급여가 많은 1~3등 가져오기
select name, basicpay
from tblinsa
    where rownum <=3
order by basicpay desc; --급여순이 아니라 처음 rownum으로 나옴

select name, basicpay, rnum, rownum from (select name, basicpay,rownum as rnum-- rnum은 전rownum(필요없는값)
                                    from tblinsa                    
                                    order by basicpay desc)
                                        where rownum <=3;         


-- 급여가 많은 5~10등 가져오기
select*from(select name, basicpay from tblinsa order by basicpay desc)
    where rownum >=5 and rownum <= 10; -- 안됨

select b.*, rownum 
    from (select a.*, rownum as rnum 
        from(select name, basicpay 
            from tblinsa order by basicpay desc) a)b --테이블을 a로 별칭을 지어주고 *에다 a.을 붙히면 *와 다른 컬럼을 같이 쓸 수 있다
                where rnum >= 5 and rnum <= 10; 
                        


--최종완성형 !!!!!
create or replace view vwBasicpay
as
select
* 
from (select a.*, rownum as rnum 
        from(select name, basicpay 
            from tblinsa order by basicpay desc) a);

select * from vwbasicpay where rnum between 1 and 10;
select * from vwbasicpay where rnum between 11 and 20;
select * from vwbasicpay where rnum between 21 and 30;





















