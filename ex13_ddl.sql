/*

        ex13_ddl.sql
        
        1. ex01 ~ ex12 > DML 수업(SELECT)
        2. DDL > 테이블(구조)
        3. DML 수업(insert, update, select)
        4. 데이터베이스 설계
        5. PL/SQL
        -----------------------------------
        6. 프로젝트



            DDL
                - Data Definition Language
                - 데이터 정의어
                - 테이블, 뷰, 사용자, 인덱스 등의 DB 오브젝트를 생성/수정/삭제하는 명령어
                - DB구조를 생성/수정/삭제하는 명령어
                
                a. create : 생성
                b. drop : 삭제
                c. alter : 수정
                
                - 사용하는 사람
                    -데이터베이스 관리자
                    -데이터베이스 개발자
                    -프로그래머(일부사용,안쓸수도있음)


                
                테이블 생성하기 > 스키마 정의 > 컬럼 정의 > 컬럼의 이름,자료형,제약사항 정의
                
                
                테이블 생성하기
                
                CREAT TABLE 테이블명(
                    컬럼 정의,
                    컬럼 정의,
                    컬럼명 자료형(길이) NULL 제약사항
                );
                    
                    
                제약사항, Constraint
                    - 해당 컬럼에 들어가는 데이터(값)에 대한 조건(규칙)
                        1. 조건을 만족하면 > 대입
                        2. 조건을 불만족하면 > 에러 발생 > 무결성 유지
                    - 데이터 무결성을 보장하는 도구
                    
                    
                        [제약]

                    1. NOT NULL
                        - 해당 컬럼은 반드시 값을 가져야 한다.
                        - 해당 컬럼에 값이 없으면 에러 발생 !!
                        - 즉, 필수값이다
                    
                    2. PRIMARY KEY, PK
                        - 기본키
                        - 테이블의 레코드(행)를 구분하기 위한 (대표)식별자 역할
                        - *** 모든 테이블은 반드시 한개의 기본키가 존재해야한다 ***
                        - PRIMARY KEY = UNIQUE + NOT NULL
                    
                    3. FOREIGN KEY
                        - 나중에 . . .
                    
                    4. UNIQUE
                        - 유일하다 > 레코드간의 중복값을 가질 수 있다 ! 
                        - NULL을 가질 수 있다 > 식별자가 될 수 없다 ! (NOT NULL제약도 가능하다)
                        ex) 초등학교 교실
                            -학생(번호(PK), 이름(NN), 직책(UQ))
                                1. 홍길동 = 반장
                                2. 아무개 = null
                                3. 고양이 = 부반장
                                4. 강아지 = null
                    
                    5. CHECK
                        - 사용자 정의형 제약 사항
                        - where절 조건 > 컬럼의 제약 사항으로 사용
                    
                    6. DEFAULT
                        - 기본값을 만들어줌
                        - INSERT/UPDATE 작업 시 > 해당 컬럼에 값을 안넣으면 NULL 대신 미리 설정한 값을 대입한다.
                        


*/

-- 1. NOT NULL
-- 메모 테이블
create table tblMemo( --테이블 생성
    --컬럼명 자료형(길이) NULL 제약사항
    
    seq number(3) NULL,   --메모번호
    name varchar2(30) NULL, -- 작성자
    memo varchar2(1000) NULL, -- 메모내용
    regdate date NULL           -- 작성날짜
);

select*from tblMemo;
select to_char(regdate,'yyyy-mm-dd hh24:mi:ss') from tblMemo;
                        

insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다','2024-07-25'); --시간을 안적으면 그날의 자정이다 = 00:00:00
            
insert into tblMemo(seq,name,memo,regdate)
            values(2,'홍길동','메모입니다',to_date('2024-07-25 17:37:30', 'yyyy-mm-dd hh24:mi:ss')); -- 시간까지 넣는 방법
            
insert into tblMemo(seq,name,memo,regdate)
            values(3,'홍길동', null, sysdate); -- 현재시간을 알아서 얻어옴
            
insert into tblMemo(seq,name,memo,regdate)
            values(5,'null', null, null); -- 아무것도 안들어가면 의미가 없다




--------- NOT NULL 제약

drop table tblMemo; --테이블 삭제

select*from tblMemo;
create table tblMemo(

    --컬럼명 자료형(길이) NOT NULL 제약사항
    
    seq number(3) NOT NULL,         --메모번호(NN->NOT NULL)
    name varchar2(30) NULL,     -- 작성자
    memo varchar2(1000) NOT NULL,   -- 메모내용(NN)
    regdate date NULL           -- 작성날짜
);

insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);

--SQL 오류: ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO") 가장 흔한 에러
insert into tblMemo(seq,name,memo,regdate)
            values(2,'홍길동',null,sysdate); --에러남 왜? 메모내용이 NOT NULL인데 NULL값이기 때문
            
insert into tblMemo(seq,name,memo,regdate)
            values(3,'홍길동','',sysdate); --에러남 왜? SQL은 빈문자열('')도 NULL값이다





----------- PK 제약

drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) PK 제약사항
    
    seq number(3) primary key,         --메모번호(PK)
    name varchar2(30),     -- 작성자
    memo varchar2(1000) not null,   -- 메모내용(NN)
    regdate date           -- 작성날짜
);


insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);

-- ORA-00001: unique constraint (HR.SYS_C007076) violated = 유니크 제약을 위반했다(유일한 값을 가져야되는데 위반함)
insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate); --PK 제약이 걸려서 에러남(1 seq가 중복되서)
            
insert into tblMemo(seq,name,memo,regdate)
            values(2,'홍길동','메모입니다',sysdate); --seq만 PK제약이기 때문에 seq만 중복되지 않으면 정상 삽입이 된다.

-- SQL 오류: ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")
insert into tblMemo(seq,name,memo,regdate)
            values(null,'홍길동','메모입니다',sysdate);




-----------UNIQUE 제약

drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) UNIQUE 제약사항
    
    seq number(3) primary key,         --메모번호(PK)
    name varchar2(30) unique,            -- 작성자(UQ)
    memo varchar2(1000) not null,        -- 메모내용(NN)
    regdate date                         -- 작성날짜
);

insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);

--ORA-00001: unique constraint (HR.SYS_C007079) violated
insert into tblMemo(seq,name,memo,regdate)
            values(2,'홍길동','메모입니다',sysdate); --에러남 왜? 이름에 UNIQUE제약이 걸려있는데 같은 값이라서
            
insert into tblMemo(seq,name,memo,regdate)
            values(3,'아무개','메모입니다',sysdate);    

insert into tblMemo(seq,name,memo,regdate)
            values(4,null,'메모입니다',sysdate); --null도 들어갈 수 있다
            






------------CHECK 제약
drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) CHECK 제약사항
    
    seq number(3) primary key,   --메모번호(PK)
    name varchar2(30) ,          -- 작성자
    memo varchar2(1000) ,        -- 메모내용
    regdate date,                -- 작성날짜
    priority number(1) check(priority between 1 and 3),  -- 중요도( 1:중요, 2:보통, 3:안중요)
    category varchar2(10) check(category in('할일','공부','약속'))               --카테고리(할일,공부,약속,가족,개인)
);

insert into tblMemo(seq,name,memo,regdate,priority,category)
            values(1,'홍길동','메모입니다',sysdate, 2, '공부');
            
--ORA-02290: check constraint (HR.SYS_C007080) violated
insert into tblMemo(seq,name,memo,regdate,priority,category)
            values(1,'홍길동','메모입니다',sysdate, 5, '공부'); --에러남 왜? 체크제약(1~3사이만)을 위반했기 때문
            
--ORA-02290: check constraint (HR.SYS_C007081) violated
insert into tblMemo(seq,name,memo,regdate,priority,category)
            values(1,'홍길동','메모입니다',sysdate, 2, '코딩'); --에러남 왜? category에는 '코딩'이 없기 때문






---------------DEFAULT 제약

drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) DEFAULT 제약사항
    
    seq number(3) primary key,           --메모번호(PK)
    name varchar2(30)default'익명' ,     -- 작성자
    memo varchar2(1000) ,                -- 메모내용
    regdate date default sysdate         -- 작성날짜
);

insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);
            
insert into tblMemo(seq,name,memo,regdate)
            values(2,null,'메모입니다',sysdate); --null 명시
            
insert into tblMemo(seq,name,memo,regdate)
            values(3,'','메모입니다',sysdate);
            
insert into tblMemo(seq,memo,regdate)
            values(4,'메모입니다',sysdate); --컬럼 생략 -> DEFAULT제약 사용법1
            
insert into tblMemo(seq,name,memo,regdate)
            values(5,default,'메모입니다',default); --DEFAULT제약 사용법2
            
            
            
            
            
            
            
/*

        제약 사항을 만드는 방법
            - 1~3 결과는 동일 but 가독성,코드관리 차이
        
            1. 컬럼 수준에서 만드는 방법
                - 위의 방식
                - 컬럼을 선언할 때 제약 사항도 같이 선언한다 !
                - 예제 수준..
            
            2. 테이블 수준에서 만드는 방법
                - 컬럼 선언하고 제약 사항 선언을 분리한다 !
                - 코드 관리 차원
                - 프로젝트 수준 ..!
            
            3. 외부에서 만드는 방법
                - 코드 관리 차원
                - 프로젝트 수준 ..!
                - 나중에..  !!! ex23_alter.sql에 있음 !!!

*/
            
            
            
            
            
            
            
            
 ------------------------ 컬럼 수준에서 만드는 방법
 
 
drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) DEFAULT 제약사항
    
    seq number(3) constraint tblmemo_seq_pk primary key , --메모번호(PK) -> 컬럼수준에서 제약사항 만들기
    name varchar2(30) ,                 -- 작성자
    memo varchar2(1000) ,                -- 메모내용
    regdate date default sysdate         -- 작성날짜
);

--ORA-00001: unique constraint (HR.TBLMEMO_SEQ_PK) violated  동일값에러 but TBLMEMO_SEQ_PK PK에 이름을 붙혀놔서 찾기 수월하다
insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);            
            
            
            
            
---------------------- 테이블 수준에서 만드는 방법            
            
drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    --컬럼명 자료형(길이) DEFAULT 제약사항
    
        seq number(3),                     --메모번호(PK)
    name varchar2(30) ,                    -- 작성자
    memo varchar2(1000) ,                -- 메모내용
    regdate date,                       -- 작성날짜
    constraint tblmemo_seq_pk primary key(seq), --테이블 수준에서 제약사항 만들기
    --constraint tblmemo_name_uq unique(name)
);            
           
 insert into tblMemo(seq,name,memo,regdate)
            values(1,'홍길동','메모입니다',sysdate);          
           
           
           
           
            
