/*


        ex21_view.sql
        
        
        View, 뷰
            - 데이터베이스 객체 중 하나(테이블,제약사항,시퀀스,뷰...)
            - 가상 테이블, 뷰 테이블 등 으로 불린다.
            - 테이블처럼 사용한다 (***)
            - SQL(select)문을 저장하는 객체이다 (*******)
            
            
            
            View의 사용목적
                - 자주 쓰는 쿼리(select)를 저장
                - 복잡하고 긴 쿼리(select)를 저장
                - 저장 객체 > 모든 DB object > 오라클에 저장 > 사용자끼리 공유/재사용 가능 > 협업 편리함 증가
                - 권한 통제 (밑에 예시있음)
            
            
         create [or replace] view 뷰이름
         as
         select문;

*/

--view 만들어보기
create or replace view vwInsa
as --연결부(연결만해줌 is라고 쓰기도)
select * from tblinsa; 
-- 테이블의 복사본 느낌..


select * from vwinsa;


--view를 활용해서 '개발부'사람들로만 만들어보기
create or replace view vwInsa --or replace 는 vwinsa가 없으면 만들고 있으면 수정하라는 의미
as 
select * from tblinsa where buseo = '개발부'; --개발부 사람만 뽑아서 테이블을 만듬

update tblinsa set city = '제주' where num = 1060;

select * from vwinsa;   --복사본도 수정된다(2)
select * from (select * from tblinsa where buseo = '개발부'); --view작동 매커니즘 (이렇게쓰면 1회용이고 vwinsa처럼 이름을 붙히면 재사용이 가능하다)  
select * from tblinsa;  --원본을 수정하면(1)




--view로 만들정도의 쿼리
    -- 자주 쓰는 쿼리(select)를 저장
    -- 복잡하고 긴 쿼리(select)를 저장

-- 비디오대여점 사장님 > 출근 > 날마다 반복업무 > view로 만들기
create or replace view vwCheck
as
select
    m.name as 회원,
    v.name as 비디오,
    r.rentdate as 언제,
    r.retdate as 반납,
    g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    round(sysdate - (r.rentdate + g.period)) as 연체일,
    round((sysdate - (r.rentdate + g.period)) * g.price * 0.1) as 연체료
from tblrent r
    inner join tblvideo v
        on v.seq = r.video
            inner join tblgenre g
                on g.seq = v.genre
                    inner join tblmember m
                        on m.seq = r.member;

select * from vwcheck; --깔끔..





-----------권한통제의 예
create or replace view vwInsa
as
select name, buseo, jikwi, tel from tblinsa;

--신입사원 > 담당업무 > 전직원에게 문자 메시지 발송 > 전직원 연락처?
--데이터베이스 로그인 > system, hr > 신입사원용 계정 생성 > tblinsa 접근 권한 부여(SQL은 일부컬럼만 볼 수 있게는 못함)
-- tblinsa 접근권한(x)
-- vwinsa 접근권한(o)
create or replace view vwInsa
as
select name, buseo, jikwi, tel from tblinsa; -- 이름, 부서, 직위, 전화번호 만 나오게 테이블을 만듬


select * from vwinsa;
select * from tblinsa;






--뷰 사용시 주의점 !!!
-- 1. select > 실행o > 뷰는 '읽기 전용'으로만 사용한다 !!!!!!

-- 2. insert > 실행o > 절대 사용금지 !!!!!!!!!
-- 3. update > 실행o > 절대 사용금지 !!!!!!!!!
-- 4. delete > 실행o > 절대 사용금지 !!!!!!!!!

-- 단순 뷰 > 뷰의 select문이 1개의 테이블로 구성
create or replace view vwTodo
as
select * from tblTodo;

select*from vwtodo;
insert into vwtodo values(21,'뷰만들기',sysdate,null);
update vwtodo set completedate = sysdate where seq =21;
delete from vwtodo where seq = 21;


-- 복합 뷰 > 뷰의 select문이 2개 이상의 테이블로 구성
select * from vwcheck;
insert into vwcheck (컬럼리스트) values (값리스트);
delete from vwcheck where 기본키 = ?;


--vwTodo va vwCheck > 어떤게 단순뷰? 복합뷰? -> 파악불가.. 그래서 select만 사용하자 !




