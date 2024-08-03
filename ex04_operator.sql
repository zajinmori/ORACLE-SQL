/*

    ex04_operater.sql
    
    연산자, Operator
    
    1. 산술 연산자
        - +, -, *, /
        - %가 없음 > 함수로 제공(mod())
    
    2. 문자열 연산자(concat)
        - +(x) > ||(o)
        
    3. 비교 연산자
        - >, >=, <, <=
        - =(==), <>(!=)
        - 논리값 반환 > boolean존재x > 명시적표현불가능 > select절에서 사용x
        - 조건절에서 사용
        
    4. 비교 연산자
        - and(&&), or(||), not(!)
        - 컬럼 리스트(select)에서 사용 불가
        - 조건절에서 사용
        
    5. 대입 연산자
        - =
        - 컬럼 = 값
        - update문에서 사용
        - 복합 대입 연산자(+=, -=) 없음
    
    6. 3항 연산자
        - 없음
        - 제어문이 없기 때문
        
    7. 증감 연산자
        - 없음
        
    8. SQL 연산자
        - SQL에서만 볼 수 있는 연산자
        - 자바 > 객체 instanceof 타입
        - 오라클 > in,between, like, is 등..
    

*/

-- 산술 연산자
select
    population, area,
    population + area,
    population - area,
    population * area,
    population / area
from tblcountry;


-- 문자열 연산자
select name || capital
from tblcountry;


-- 비교 연산자
--select name > capital
--from tblcountry;
--select name <> capital
--from tblcountry; -> 안됨





/*

    컬럼의 별칭(Alias)  as 별칭
        - 결과셋의 컬럼명을 원하는 컬럼명으로 바꾸는 기술
        - *** 결과셋의 컬럼명이 식별자로 적합하지 않을 때 > 적합한 식별자로 바꿔줌
        

*/

select
    name,
    age-1 as 만나이, --컬럼명 별칭 붙이기
    age-1 as age,
    couple
from tblmen;


select
    *
from tblwomen;



select name, age, height from tblmen;

select tblmen.name, tblmen.age,tblmen.height from tblmen;

select hr.tblmen.name, hr.tblmen.age, hr.tblmen.height from hr.tblmen; --원래 테이블의 이름

--hr계정으로 접속해있으면 hr을 생략하고 tbl(테이블)도 생략한다.


--테이블 별칭을 쓰는 이유는 그냥 다 쓰기가 귀찮아서..
select m.name, m.age,m.height from tblmen m; --테이블 별칭은 as를 안쓴다. -> tblmen > m (바꾸면 무조건 바꾼m으로 바꿔줘야한다) 

select tblmen.name, tblmen.age,tblmen.height
from tblmen m;  -- from절이 먼저 실행되는 이유//



