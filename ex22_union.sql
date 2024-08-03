/*

        ex22_union.sql


        관계대수연산
            1. 셀렉션 > select where
            2. 프로젝션 > select column
            3. 조인 > join
            4. 합집합(union), 차집합(minus), 교집합(intersect)
            
    
            합집합(union)
                - 테이블과 테이블을 합치는 연산
                - 스키마가 동일한 결과셋끼리만 가능
                - 자료형을 맞추면 가능


*/
----------------합집합(union) 하는 법

select * from tblmen
union
select * from tblwomen;

--결과셋을 맞춤 but 의미가없다
select name, height from tblmen
union
select title, seq from tbltodo;

-- 회사 > 게시판 > 부서별 게시판
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

-- 사장님 > 모든 부서의 게시판 열람 > 한번에 !!!
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;



-- 야구선수 > 공격수, 수비수
select * from 공격수;
select * from 수비수;

-- 전체 선수 목록
select 공통컬럼리스트 from 공격수
union
select 공통컬럼리스트 from 수비수;



-- 다량 데이터 관리
-- sns > 많은 데이터 누적 > select 속도 저하 > 테이블 분리(기간별)
select * from 게시판;

select * from 게시판2024; --연도별로 테이블 분리
select * from 게시판2023;
select * from 게시판2022;

select * from
    (select * from 게시판2024 --연도별로 테이블 분리
    union
    select * from 게시판2023
    union
    select * from 게시판2022)
        where 조건; -- 모든 게시판에 조건이 붙음


create table tblAAA(
    name varchar2(30) not null,
    color varchar2(30) not null
);

create table tblBBB(
    name varchar2(30) not null,
    color varchar2(30) not null
);


insert into tblAAA values ('강아지','검정');
insert into tblAAA values ('고양이','노랑');
insert into tblAAA values ('토끼'  ,'갈색');
insert into tblAAA values ('거북이','녹색');
insert into tblAAA values ('강아지','회색');

insert into tblBBB values ('강아지','검정');
insert into tblBBB values ('고양이','노랑');
insert into tblBBB values ('호랑이','주황');
insert into tblBBB values ('사자'  ,'회색');
insert into tblBBB values ('고양이','검정');


select * from tblAAA;
select * from tblBBB;


----------------합집합(union)
-- union > 수학의 '집합' > 중복 제거
select * from tblAAA
union
select * from tblBBB;


-- union all > 중복 포함(전체값)
select * from tblAAA
union all
select * from tblBBB;





--------------교집합(intersect)
-- intersect > 교집합
select * from tblAAA
intersect
select * from tblBBB;




--------------차집합(minus) > 순서에 따라 다름
-- minus > 차집합
select * from tblAAA
minus
select * from tblBBB;


select * from tblBBB
minus
select * from tblAAA;







