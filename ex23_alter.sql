/*

            ex23_alter.sql

            
            DDL > 객체 조작
                - 객체 생성 : create
                - 객체 수정 : alter
                - 객체 삭제 : drop
                
                
            DML > 데이터 조작
                - 데이터 생성 : insert
                - 데이터 수정 : update
                - 데이터 삭제 : delete
                
            
            
            
            테이블 수정
                - 테이블 수정 > 테이블 정의(스키마) 수정 > 컬럼 수정 > 컬럼명 or 자료형(길이) or 제약사항 수정
                - ******"되도록 테이블을 수정하는 상황을 만들면 안된다 !!!!!!!!!!"
                - 사전에 테이블 설계를 최대한 문제없게 ! 만들어야한다 ..
                
                
            테이블을 수정해야 하는 상황 발생..!
                1. 테이블 삭제(drop) > 테이블 DDL(create)수정 > 수정된 DDL로 다시 테이블 생성
                    a. 기존 테이블에 데이터가 없을 경우 > 아무 문제 없음
                    b. 기존 테이블에 데이터가 있을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정된 테이블 생성 > 데이터 복구
                        - 개발 중에 사용 가능
                        - 공부 중에 사용 가능
                        - 서비스 운영 중에는 많이 부담..
                                    
                2. alter 명령어 사용 > 기존 테이블의 구조를 변경
                    a. 기존 테이블에 데이터가 없을 경우 > 아무 문제 없음
                    b. 기존 테이블에 데이터가 있을 경우 > 상황에 따라 다름
                        - 개발 중에 사용 가능
                        - 공부 중에 사용 가능
                        - 서비스 운영 중에는 1번보다는 덜 부담..

*/
drop table tbledit;

-- DDL
create table tbledit(
    seq number primary key,
    name varchar2(20) not null
);

-- DML
insert into tbledit values (1,'마우스');
insert into tbledit values (2,'키보드');
insert into tbledit values (3,'모니터');


-- case 1. 새로운 '컬럼'을 추가하기---------------------------------------------
alter table 테이블
    add (컬렘 정의);
    
alter table tbledit
    add (price number);

--ORA-01758: table must be empty to add mandatory (NOT NULL) column = price number컬럼을 추가할때 이미 null이 생성되어 있어서 에러남
alter table tbledit
    add (qty number not null);
    

--그래서 데이터를 다 지워보기 > 빈데이터일때는 null제약을 위반하지 않아서 컬럼 추가가 가능
delete from tbledit;
    
    
--다시 데이터 채워넣기 (데이터가 많아지면 굉장히 피곤한 일이다)
insert into tbledit values (1,'마우스',1000,1);
insert into tbledit values (2,'키보드',2000,1);
insert into tbledit values (3,'모니터',3000,2);


--컬럼 하나 더 추가하기
alter table tbledit
    add(color varchar2(30) default 'white' not null); --default를 써서 'white'가 기본값으로 들어가있다 = not null제약을 위반하지 않는다.

select * from tbledit;






-- case 2. 컬럼을 삭제하기------------------------------------------------------
alter table 테이블명
    drop column 컬럼명;
    
alter table tbledit
    drop column name;
    
--ORA-12983: cannot drop all columns in a table 모든 컬럼을 지울수 없다
alter table tbledit
    drop column seq; --primary key삭제?!?!? > 절때 금지 !!!!!!!!!!


select * from tbledit;



-- case 3. 컬럼을 수정하기------------------------------------------------------

--SQL 오류: ORA-12899: value too large for column "HR"."TBLEDIT"."NAME" (actual: 31, maximum: 20) --길이가 너무 길다(오버플로우 발생)
insert into tbledit values (4, '맥북 M3 프로 2024 고급형');


-- case 3.1 컬럼 '길이' 수정하기(확장/축소)-------------------------------------
alter table 테이블명
    modify(컬럼 정의);
    
alter table tbledit
    modify(name varchar2(100)); -- 길이 확장

--ORA-01441: cannot decrease column length because some value is too big = 이미 길이가 긴게 들어있어서 축소불가능
alter table tbledit
    modify(name varchar2(20)); -- 길이 축소



-- case 3.2 컬럼 제약 사항 수정하기 (not null)----------------------------------
alter table tbledit
    modify(name varchar2(100) null); -- not null -> null로 바뀜 (자료형과 길이는 기존꺼를 써야한다)


alter table tbledit
    modify(name varchar2(100) not null); -- null -> not null로 바뀜
    
    
    
alter table tbledit
    modify(name varchar2(100) unique); -- 나머지 제약도 동일한 방식으로 수정한다
    
    
desc tbledit;




-- case 3.3 컬럼의 자료형을 수정하기--------------------------------------------
delete from tbledit;
alter table tbledit
    modify (seq varchar2(30)); -- 데이터를 지우고 해야한다




-- case 4 제약 사항 조작하기----------------------------------------------------
drop table tbledit;


create table tbledit(
    seq number,
    name varchar2(20)
);


--PK 추가
alter table tbledit
    add constraint tbledit_seq_pk primary key(seq);

insert into tbledit values (1, '강아지');
insert into tbledit values (1, '강아지');


--unique 추가
alter table tbledit
    add constraint tbledit_name_uq unique(name);

insert into tbledit values (1, '강아지');
insert into tbledit values (1, '강아지');
insert into tbledit values (2, '강아지');

-- !!! not null은 alter로 추가 할 수 없다


--unique 삭제
alter table tbledit
    drop constraint tbledit_name_uq;



select * from tbledit;
desc tbledit;

























