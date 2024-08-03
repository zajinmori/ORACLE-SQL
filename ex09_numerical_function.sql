/*


    ex09_numerical_function.sql
    
    
    숫자 함수
        -math.xxx()
        
        
        
        round()
            - 반올림 함수
            - number round(컬럼명) : 정수 반환
            - number round(컬럼명, 소수이하 자릿수) : 원하는 자릿수 반환(실수)
        
--시스템테이블
select * from tabs;
select * from dual; --X(dummy) > 1행 1열짜리 테이블

select round(3.14) from dual; --레코드 하나짜리가 필요할때 쓰는 테이블



*/

select avg(basicpay) from tblinsa; -- 1556526.66666666666666666666666666666667
select round(avg(basicpay)) from tblinsa; --1556527 : 반올림 한 정수만 나온다
select round(avg(basicpay),1) from tblinsa; --1556526.7 : 소수이하 첫째자리까지 나온다





select 
    3.5678,
    round(3.5675),
    round(3.5678, 1),
    round(3.5678, 2),
    round(3.5678, 0) --0은 안쓴거랑 똑같다
from dual;




/*
    floor(), trunc()
        - 절삭 함수
        - 무조건 내림 함수
        - number floor(컬럼명)
        - number trunc(컬럼명)
        -- number trunc(컬럼명, 소수이하 자릿수)



*/
select
    3.5678,
    floor(3.9999), --3 무조건 내림
    trunc(3.9999),  --3 
    trunc(3.5678,2) --3.56 둘째자리까지만 살림(반올림x)
from dual;



/*

    ceil()
        - 무조건 올림 함수
        - 천장 함수
        - number ceil(컬럼명)



*/
select 
    3.14,
    ceil(3.14) --4 : 무조건 올림
from dual;

select
    floor(3.9999999999999), --3 : 무조건 내림
    ceil(3.00000000000001)  --4 : 무조건 올림
from dual;




/*

    mod()
        - 나머지 함수
        - number mod(피제수, 제수)
        
*/
select
    10/3, --3.33333333333333333333333333333333333333
    floor(10/3) as 몫, -- 3
    mod(10,3) as 나머지 -- 1
from dual;

select 
    abs(10), abs(-10), -- 절대값
    power(2,2), power(3,3), --제곱값
    sqrt(4),sqrt(9),sqrt(16) --루트값
from dual;

















