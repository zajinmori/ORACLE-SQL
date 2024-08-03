/*


    ex10_string_function.sql
    
    
    문자열 함수
    
    대소문자 변환
        - upper(), lower(), initcap()
        - varchar2 upper(컬럼명)
        - varchar2 lower(컬럼명)
        - varchar2 initcap(컬럼명)



*/
select
    'javaTest',
    upper('javaTest'), -- JAVATEST : 대문자로
    lower('javaTest'), -- javatest : 소문자로
    initcap('javaTest')-- Javatest : 첫글자만 대문자로
from dual;

-- employees 이름에 'de'이 포함된 사람 검색?
select first_name from employees
                        where first_name like '%de%'
                        or first_name like '%DE%'
                        or first_name like '%dE%'
                        or first_name like '%De%';
                        
select first_name from employees     
                        where upper(first_name) like '%DE%'; -- 위에거를 이런식으로 할 수 있다 > 간편
                        
                        


/*

    문자열 추출 함수
        - substr()
        - varchar2 substr(컬럼명, 시작위치, 가져올 문자 개수)
        - varchar2 substr(컬럼명, 시작위치) -> 끝까지 가져옴

*/
select 
    name,
    substr(name,1,3), -- 첫번째부터 3글자
    substr(name,1) --첫번째부터 끝까지
from tblcountry;


select
    name, ssn,
    substr(ssn,1, 2) as 생년,
    substr(ssn,3, 2) as 생월,
    substr(ssn,5, 2) as 생일,
    substr(ssn,8, 1) as 성별
from tblinsa;

--tblinsa 김,이,박,최,정 > 각각 몇명??
select*from tblinsa where name like '김%';

select*from tblinsa where substr(name,1,1)='김'; --12
select*from tblinsa where substr(name,1,1)='이'; --14
select*from tblinsa where substr(name,1,1)='박'; --2
select*from tblinsa where substr(name,1,1)='최'; --1
select*from tblinsa where substr(name,1,1)='정'; --5

select 
    count(case
        when substr(name,1,1) = '김' then 1
        
    end)as 김,
    count(case
        when substr(name,1,1) = '이' then 1
        
    end)as 이,
    count(case
        when substr(name,1,1) = '박' then 1
        
    end)as 박,
    count(case
        when substr(name,1,1) = '최' then 1
        
    end)as 최,
    count(case
        when substr(name,1,1) = '정' then 1
        
    end)as 정,
    count(case
        when substr(name,1,1) not in ('김','이','박','최','정') then 1
        end)as 나머지
from tblinsa;




/*

    문자열 길이
        - length()
        - number length(컬럼명)
        
*/
-- 대부분의 함수 > 적용 가능한 위치

-- 컬럼 리스트
select name, length(name) from tblcountry;

-- 조건절에서 사용 (O)
select
    name,
    length(name) as ln --순서가 다르니까 where절에서 ln을 쓸 수가 없다
from tblcountry
    where length(name) > 3;


-- 정렬에서 사용 (O)
select name, length(name)as ln from tblcountry
    order by ln desc; -- order by는 무조건 마지막이기 때문에 ln을 쓸 수 있다.
    
    select name from tblcountry
    order by length(name) desc;
    
    
select name, ssn from tblinsa order by substr(ssn,8,1)asc; --남 -> 여 순서로


/*

    문자열 검색
        - instr()
        - 검색어의 위치를 반환
        - number instr(컬럼명, 검색어)
        - number instr(컬럼명, 검색어, 시작위치)
        - number instr(컬럼명, 검색어, 시작위치-1) = 마지막부터 찾기
        - 못찾으면 = 0을 반환
*/
select
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님','홍길동'), -- 8
    instr('안녕하세요. 홍길동님','아무개'), -- 0 (없으니까)
    instr('안녕하세요. 홍길동님. 홍길동님','홍길동'), --첫번째 홍길동을 찾음
    instr('안녕하세요. 홍길동님. 홍길동님','홍길동',11), --11번째 이후니까 두번째 홍길동 찾음
    instr('안녕하세요. 홍길동님. 홍길동님','홍길동',-1) -- -1을 붙히니까 마지막에서 부터 찾아서 두번째 홍길동 찾음
from dual;




/*

    패딩
        - lpad(), rpad()
        - left padding, right padding (여백)
        - varchar2 lpad(컬럼명, 개수, 문자)
        - varchar2 rpad(컬럼명, 개수, 문자)


*/
select
    lpad('A', 5), --5칸의 너비
    lpad('A', 5, 'B'), --B로 너비를 채운다
    lpad('AA', 5, 'B'),
    lpad('AAA', 5, 'B'),
    lpad('AAAA', 5, 'B'),
    lpad('AAAAA', 5, 'B'),
    lpad('AAAAAA', 5, 'B'), --무조건 5글자로 만들어서 한개의 A를 자름
    lpad('1', 3, '0'), --3자를 맞추는데 앞에 여백에 0을 채워라
    rpad('1', 3, '0') --위에랑 같은데 오른쪽에 0을 채워라 -> 잘안씀
from dual;





/*

    공백 제거
        - trim(), ltrim(), rtrim()
        - varchar2 trim(컬럼명)
        - varchar2 ltrim(컬럼명)
        - varchar2 rtrim(컬럼명)
*/
select 
    '     하나     둘     셋     ',
    trim('     하나     둘     셋     '), --좌우 다 공백제거
    ltrim('     하나     둘     셋     '), --왼쪽만 공백제거
    rtrim('     하나     둘     셋     ') --오른쪽만 공백제거

from dual;





/*

    문자열 치환
        - replace()
        - varchar2 replace(컬럼명, 찾을 문자열, 바꿀 문자열)
        
        - varchar2 regexp_replace(컬럼명, 찾을 문자열, 바꿀 문자열)
*/
select
    replace('홍길동', '홍', '김'), --홍길동에서 홍을 김으로 바꿔라
    replace('홍길동', '이', '김'), -- 없는 글자면 원본을 반환
    replace('홍길홍', '홍', '김') -- '김길김' 찾은건 다바꿔준다
from dual;

select
    regexp_replace(name, '김[가-힣]{2}', '김OO'), -- 김씨를 가진 사람들의 이름을 OO으로 바꿔라
    tel,
    regexp_replace(tel, '(\d{3})-(\d{4})-\d{4}','\1') , -- 통신사 번호가 찍힘 
    regexp_replace(tel, '(\d{3}-\d{4})-\d{4}','\1-XXXX' ) -- 마지막 번호는 XXXX로 바꿈
    
from tblinsa;




-- split() 없음 왜? 배열이 없기 때문.


/*

    문자열 치환
        - decode()
        - replace()랑 유사 즉, replace()를 여러번 실행하는 느낌 ..!
        - varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열)
        - varchar2 decode(컬럼명, 찾을 문자열, 바꿀 문자열, 찾을 문자열, 바꿀 문자열 ... 계속 반복할수있음)
        - **** 치환할 대상을 찾지 못하면 null을 반환함 ****
        
*/
-- 성별 > 남자, 여자
select
    gender,
    case                                                  -- case사용
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(replace(gender, 'm', '남자'),'f','여자') as g2, -- replace() 2번 사용
    decode(gender, 'm', '남자','f','여자')as g3             -- decode()사용
from tblcomedian;



-- tblcomedian 남자가 몇명 ? 여자가 몇명 ?
select
    count(case
        when gender = 'm' then 1
    end),
    count(case
        when gender = 'f' then 1
    end),
    count(decode(gender, 'm', 1)),
    count(decode(gender, 'f', 1))
from tblcomedian;
-- -> 즉, case와 decode는 쌍둥이다
















