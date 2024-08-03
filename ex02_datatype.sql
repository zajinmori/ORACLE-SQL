/*

    ex02_datatype.sql
    
    
    관계형 데이터베이스
        - 변수(x) > 변수가 있으면 프로그래밍언어다.
        - SQL > 대화형 언어 > DB와 대화를 목적으로 하는 언어
        - 데이터 조작 > 자료형 -> 테이블을 정의할 때 사용 > 컬럼의 자료형
        
        
        
    포준 SQL 자료형 == 오라클 자료형
    
    1. 숫자형
        - 정수, 실수
            a. number
                - (유효자리)38자리 이하의 숫자를 표현하는 자료형
                - ex)1234567890123456789012345678901234567800000000000
                - 5~22 byte
                
                - number를 표기하는 법
                    a. number : 정수or실수
                    b. number(precision) : 정수만 저장
                    c. number(precision, scale) : 정수/실수 저장
                
    2. 문자형 > 주로 varchar2 사용
        - 문자, 문자열 (따로 구분없이 모든게 문자열이다)
        
            char vs nchar (n의 의미?) = 오라클 인코딩 vs UTF16
            varchar2 vs nvarchar2
            
            char vs varchar2 (var의 의미?) = 고정 자릿수 vs 가변 자릿수
            nchar vs nvarchar2
            
            
            a. char 
                - 고정 자릿수 문자열 -> 공간(컬럼)의 크기가 불변 > 
                - char(n) : 최대 n자리 문자열 (n == byte)
                    - char(n byte)
                    - n의 범위 : 1바이트 ~ 2000바이트
                - char(n char) : n == 글자수 > UTF-8
                
            b. nchar(100% 한글들어갈때 자주 사용)
                - 고정 자릿수 문자열 -> 공간(컬럼)의 크기가 불변 
                - national language > 오라클 인코딩과 상관없이 n이 붙으면 해당 컬럼을 UTF16으로 저장
                - nchar(n) : 최대 n자리 문자열 (n==문자수)
                - n의 범위 : 1자 ~ 1000자
            
            c. varchar2
                - variable character
                - 바차투
                - 가변 자릿수 문자열 -> 공간(컬럼)의 크기가 가변
                - varchar2(n) : 최대 n자리 문자열, n(바이트)
                - n의 범위 : 1바이트 ~ 4000바이트
                
            d. nvarchar2
                - 가변 자릿수 문자열 -> 공간(컬럼)의 크기가 가변
                - national language > 오라클 인코딩과 상관없이 n이 붙으면 해당 컬럼을 UTF16으로 저장
                - nvarchar2(n) : 최대 n자리 문자열 (n==문자수)
                - n의 범위 : 1자 ~ 2000자
            
            
            
            e. clob(블로그,게시판 등)
                - charactor large object
                - 대용량 텍스트
                - 4GB까지 저장
                - 참조형(속도가 상대적으로 느림)
            
            f. nclob
                - national charactor large object > 오라클 인코딩과 상관없이 n이 붙으면 해당 컬럼을 UTF16으로 저장
                - 대용량 텍스트
                - 4GB까지 저장
                - 참조형(속도가 상대적으로 느림)
    
    
    3. 날짜/시간형
            a. date
                - 년월일시분초
            
            b. timestamp
                - 년월일시분초 + 밀리초 + 나노초
            
            c. interval
                - 시간
                - 틱값 저장용
            
            
    
    4. 이진 데이터형
            a.blob
                - 비 텍스트 데이터
                - 이미지, 동영상, 음악, 실행파일, 압축파일 등..
                - 잘 안쓴다 ..!
                ex) 게시판(첨부파일) > 파일명만 저장
                
            
    



    테이블 선언하기
         create table 테이블명 (컬럼, 컬럼, 컬럼);
        
         create table 테이블명 (
           컬럼 선언,
           컬럼 선언,
           컬럼 선언,
           컬럼명 자료형
        );

*/

--수업 >DB Object 식별자(컬럼x) > 헝가리언 표기법 

drop table tbltype; --테이블삭제

create table tbltype(
    --num number
    --num number(3) --3자리까지 저장하겠다는 뜻 : -999 ~ 999 까지(정수만)
    --num number(4,2) --4:전체자릿수 / 2:소수이하자릿수 -99.99 ~ 99.99 (정수, 실수)
    
    --txt char(10) -- 최대 10byte > 영어 한글자 : 1byte / 한글 한글자 : 3byte
    txt1 char(10),
    txt2 varchar2(10)
);

--현재 계정이 소유한 테이블 목록
select * from tabs;
--툴을 통해서도 확인가능 '테이블(필터링됨)' 클릭


--데이터 추가하는 법
--insert into 테이블명(컬럼명) values(값);

--num number
insert into tbltype(num)values(100);  --정수 리터럴
insert into tbltype(num)values(3.14); --실수 리터럴
insert into tbltype(num)values(12345678901234567890123456789012345678901234567890);--40자리까지. 그 뒤는 0으로나옴

--num number(3)
insert into tbltype(num)values(999);
insert into tbltype(num)values(-999);
insert into tbltype(num)values(1000);

-- num number(4,2)
insert into tbltype(num)values(100);
insert into tbltype(num)values(3.14);
insert into tbltype(num)values(99.99);
insert into tbltype(num)values(-99.99);

--txt char(10)
insert into tbltype(txt)values(100); --형변환
insert into tbltype(txt)values('abc'); --문자 리터럴 모든걸 ''로.
insert into tbltype(txt)values('abcdefghijk');
insert into tbltype(txt)values('홍길동님');


--char(10)      : 'abc' > 'abc       ' = 불변이니까 남은 7칸을 채움
--varchar2(10)  : 'abc' > 'abc' = 가변이니까 남은 7칸을 없애버림

-- txt1 char(10),txt2 varchar2(10)
insert into tbltype(txt1, txt2)values('abc', 'abc');
insert into tbltype(txt1, txt2)values('abcdefghij', 'abcdefghij');





--데이터 읽어오기(데이터확인)
SELECT*from tbltype;




