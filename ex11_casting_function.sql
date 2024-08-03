/*

    ex11_casting_function.sql
    
    Java : (자료형)데이터
    

    형변환 함수
        1. varchar2 to_char(숫자형) : 숫자 > 문자열 / 잘 안씀..
        2. varchar2 to_char(날짜형) : 날짜 > 문자열 / 진짜 많이 씀 !!!!
        3. number to_number(문자형) : 문자열 > 숫자 / 진짜 잘 안씀..
        4. date to_date(문자형)     : 문자열 > 날짜 / 꽤 많이 씀 !!!!!
        
        
        
        
        
        
        1. varchar2 to_char(숫자형[, 형식문자열]) : 숫자 > 문자열
            
            형식문자열 구성요소 (like %d, %s)
                a. 9 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 공백으로 치환 (like %5d)
                b. 0 : 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 치환    (like %05d)
                c. $ : 통화 기호
                d. L : 통화 기호(지역에 맞게 바꿔줌)
                e. . : 소숫점
                f. , : 천단위 표기
          
*/
select
    100, --오른쪽정렬 = 숫자
    '100' --왼쪽정렬 = 문자열

from dual; 

select
    100, 
    to_char(100), --숫자를 문자열로 바꿈
    '@'||to_char(100,'99999')||'@',  -- 99999는 다섯자리의 문자열로 바꿔라. 근데 한칸이 더나옴 왜? 부호표시공간이다
    '@'||to_char(100,'00000')||'@',  -- 00000은 다섯자리의 문자열을 만들고 여백에 0으로 채워라.
    to_char(100,'$999'), -- $표시를 넣어줌.. 액수를 쓸때 쓰면 좋을듯
    to_char(100,'L999'), -- 원화표시가 나옴
    '$' || ltrim( to_char(100,'999')) -- 사실 이렇게 써도 됨
from dual;

select
    3.14,
    to_char(3.14,'9.99'), -- .을 찍을 수 있다. 라는 의미
    to_char(3.14,'9.9'), -- 두자리까지만 나옴
    1000000,
    to_char(1000000, '9,999,999'), -- ,를 세자리마다 찍는다
    to_char(1000000, '9,99,9999') -- 내가 찍는데로 그대로 찍힌다
from dual;








/*

        ************************** 굉장히 중요
        2. varchar2 to_char(날짜형, 형식문자열) : 날짜 > 문자열
            (like Calendar.get(Calendar.YEAR) 역할)
            
            형식 문자열 구성요소
                a. yyyy
                b. yy
                c. month
                d. mon
                e. mm
                f. day
                g. dy
                h. ddd
                i. dd
                j. d
                k. hh
                l. hh24
                m. mi
                n. ss
                o. am(pm)
        
        
    
*/
select sysdate from dual; --sysdate함수 (현재시각) : 24/07/25


select to_char(sysdate, 'yyyy')from dual;   -- 2024 > 년(네자리)
select to_char(sysdate, 'yy')from dual;     -- 24 > 년(두자리)
select to_char(sysdate, 'month')from dual;  -- 7월 > 월 (풀네임)
select to_char(sysdate, 'mon')from dual;    -- 7월 > 월 (약어)
select to_char(sysdate, 'mm')from dual;     -- 07 > 월(숫자만)
select to_char(sysdate, 'day')from dual;    -- 목요일 > 요일(풀네임)
select to_char(sysdate, 'dy')from dual;     -- 목 > 요일(약어)
select to_char(sysdate, 'ddd')from dual;    -- 207 > 일(올해의 며칠)
select to_char(sysdate, 'dd')from dual;     -- 25 > 일(이번달의 며칠)
select to_char(sysdate, 'd')from dual;      -- 5 > 일(이번주의 며칠==요일)/1:일요일, 7:토요일
select to_char(sysdate, 'hh')from dual;     -- 12 > 시(12H)
select to_char(sysdate, 'hh24')from dual;   -- 12 > 시(24H)
select to_char(sysdate, 'mi')from dual;     -- 35 > 분
select to_char(sysdate, 'ss')from dual;     -- 23 > 초
select to_char(sysdate, 'am')from dual;     -- 오후 > 오전/오후 구분
select to_char(sysdate, 'pm')from dual;     -- 오후 > 오전/오후 구분


select
    sysdate, -- 24/07/25(기본값)
    to_char(sysdate, 'yyyy-mm-dd'), -- 2024-07-25
    to_char(sysdate, 'hh24:mi:ss'), -- 12:38:29
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2024-07-25 12:38:57
    to_char(sysdate, 'day am hh:mi:ss') -- 목요일 오후 12:39:49
from dual;


-- 휴일 입사 or 평일 입사 구분
select
    name, to_char(ibsadate, 'yyyy-mm-dd day')as ibsadate,
    case
        --when to_char(ibsadate, 'day') = '일요일' then '휴일 입사' 한글을 쓰면 다른 나라에서 오류가 날수도있음
        when to_char(ibsadate, 'd') in ('1','7') then '휴일 입사' --1:일요일 7:토요일 이다
        else '평일 입사'
    end
from tblinsa;


--예제] 요일별 입사한 인원 수?
select
    count(decode(to_char(ibsadate, 'd'), '2', 1))as 월요일,
    count(decode(to_char(ibsadate, 'd'), '3', 1))as 화요일,
    count(decode(to_char(ibsadate, 'd'), '4', 1))as 수요일,
    count(decode(to_char(ibsadate, 'd'), '5', 1))as 목요일,
    count(decode(to_char(ibsadate, 'd'), '6', 1))as 금요일,
    count(decode(to_char(ibsadate, 'd'), '7', 1))as 토요일,
    count(decode(to_char(ibsadate, 'd'), '1', 1))as 일요일
from tblinsa;






/*

        3. number to_number(문자형) : 문자열 > 숫자 (굳이 잘 안쓴다. 암시적 형변환을 해줘서..)       
*/
select
    to_number('100'),
    to_number('100')*2,
    '100'*2 --문자열 100에 2를 곱했는데 곱해진다 .. 왜?? 암시적 형변환이 되었기 때문. SQL은 이런경우가 대다수다
from dual;




/*
        *****************이것도 중요하다
        4. date to_date(문자형)     : 문자열 > 날짜
            

*/
select
    *
from tblinsa
    where ibsadate >= '2010-01-01'; -- date >= varchar2 -> 암시적형변환이 일어났따.


select
    '2010-01-01', -- 자료형->varchar2(문자열)
    to_date('2010-01-01'), -- 자료형->date(날짜)
    to_char(to_date('2010-01-01'),'day'),
    --to_char('2010-01-01', 'day') -- 이건 안된다
    to_date('2010-01-01','yyyy-mm-dd'),
    to_date('20100101','yyyymmdd'), --되긴 되는데 /로 구분을 해주는게 좋다.
    to_date('2010-01-01 12:30:30','yyyy-mm-dd hh24:mi:ss') -- 년월일은 알아서 형변환을 해주는데 시분초는 안된다. 뒤에 형식 문자열을 붙여야한다.
from dual;





