/*


        ex15_insert.sql
        
            - DML
            - 테이블에 데이터를 추가하는 명령어
            
            insert into 테이블명 (컬럼리스트) values (값리스트);
            


*/

drop table tblMemo; --테이블 삭제

select*from tblMemo;

create table tblMemo(

    
    
    seq number(3) primary key,           
    name varchar2(30)default'익명' ,     
    memo varchar2(1000) ,                
    regdate date default sysdate not null        
);

create sequence seqMemo;

-- 1. 표준
    -- 원본 데이터에 정의된 컬럼 순서대로 > 컬럼 리스트와 값 리스트 생성
    -- 특별한 목적이 없으면 이 방식을 사용 > 가장 무난
insert into tblMemo(seq,name,memo,regdate)
                    values(seqMemo.nextval,'홍길동','메모입니다',sysdate);
                    
--------------------------------------------------------------------------------                    
                    
                    
                    
-- 2. 컬럼리스트와 값리스트의 순서는 원본 테이블과 상관없다
    -- 컬럼 리스트의 순서와 값리스트의 순서는 일치해야 한다.

insert into tblMemo(regdate,seq,name,memo)
                    values(sysdate,seqMemo.nextval,'홍길동','메모입니다');
                    
--------------------------------------------------------------------------------



-- 3. SQL 오류: ORA-00947: not enough values 값이 부족하다는 에러

insert into tblMemo(seq,name,memo,regdate)
                    values(seqMemo.nextval,'홍길동','메모입니다');

--------------------------------------------------------------------------------


-- 4. 00913. 00000 -  "too many values" 값이 많다는 에러

insert into tblMemo(seq,name,memo)
                    values(seqMemo.nextval,'홍길동','메모입니다',sysdate);

--------------------------------------------------------------------------------

-- 5. null컬럼을 조작 하는 방법
    -- 5-1. null 상수 사용

insert into tblMemo(seq,name,memo,regdate)
                    values(seqMemo.nextval,'홍길동',null,sysdate);


    -- 5-2. 컬럼 생략
insert into tblMemo(seq,name,regdate)
                    values(seqMemo.nextval,'홍길동',sysdate);

--------------------------------------------------------------------------------


-- 6. default 컬럼 조작 하는 방법
     -- 6-1. 컬럼 생략하는 방식으로 null을 대입하면 default호출된다
insert into tblMemo(seq,memo,regdate)
                    values(seqMemo.nextval,'메모입니다',sysdate);        -- '익명'이라고 잘 들어감
     
     
     -- 6-2. null 상수 > default 동작 안함
insert into tblMemo(seq,name,memo,regdate)
                    values(seqMemo.nextval,null,'메모입니다',sysdate);   --익명이 안들어가고 null이 들어감
     
     -- 6-3. default 상수
insert into tblMemo(seq,name,memo,regdate)
                    values(seqMemo.nextval,default,'메모입니다',sysdate); -- default를 직접 넣으면 '익명'이 잘 들어감




--------------------------------------------------------------------------------


-- 7. 단축
    -- 7-1. 컬럼 리스트는 생략할 수 있다
insert into tblmemo values (seqMemo.nextval,'홍길동','메모입니다',sysdate);


    -- 7-2. 컬럼 리스트를 생략하면 테이블 원본의 컬럼리스트의 순서대로 값리스트를 만들어야한다.
    --SQL 오류: ORA-00932: inconsistent datatypes: expected NUMBER got DATE
insert into tblmemo values (sysdate, seqMemo.nextval,'홍길동','메모입니다'); 


    -- 7-3. null 입력
insert into tblmemo values (seqMemo.nextval,'홍길동',sysdate); --값이 모자라다. null컬럼 생략이 불가능 !
insert into tblmemo values (seqMemo.nextval,'홍길동',null,sysdate); --null을 직접 적어주면 가능 !


    -- 7-4. default 컬럼
insert into tblmemo values (seqMemo.nextval,'메모입니다',sysdate); --역시나 값이 모자라다
insert into tblmemo values (seqMemo.nextval,default,'메모입니다',sysdate); --default를 직접 적어주면 가능 !




--------------------------------------------------------------------------------
drop table tblmemocopy;

-- 8. 복사
    -- tblmemo 테이블 > 복사 > 새 테이블 생성(tblmemocopy)    
create table tblMemocopy(
   
    seq number(3) primary key,           
    name varchar2(30)default'익명' ,     
    memo varchar2(1000) ,                
    regdate date default sysdate not null        
);


insert into tblmemocopy select * from tblmemo; -- 복사하는 방법 (Sub Query)
insert into tblmemocopy select * from tblmemo where name = '홍길동'; --조건에 맞는거만 부분복사도 가능하다


select*from tblmemo;
select*from tblmemocopy;


--------------------------------------------------------------------------------


-- 9. dummy 테이블 만들기(테스트, 공부용)
    -- tblmemo 테이블 > 복사 > 새 테이블 생성(tblmemocopy)
    -- 9-1. 테이블 구조 복사(o)
    -- 9-2. *** 제약 사항 복사(x) ***
create table tblmemocopy
as
select * from tblmemo;  -- 초간단 테이블복사.. but 제약사항은 복사를 안해준다


select*from tblmemocopy;
desc tblmemocopy;








