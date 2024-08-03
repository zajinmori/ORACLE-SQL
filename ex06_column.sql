/*


    ex06_column.sql

    
    컬럼 리스트에서 할 수 있는 행동
        -SELECT 컬럼리스트
        

*/


--컬럼명
select name from tblcountry;


--연산 > 결과셋의 컬럼명이 유효한지 확인 !! > 별칭 사용 !!!!
select area + 100, name || '나라' from tblcountry;


--상수
select 100 from tblcountry;


--함수(메서드) == 데이터
select length(name) from tblcountry;




/*


    distinct
        - Java Stream : list.stream().distinct().forEach()
        - 컬럼 리스트에서 사용
        - 중복값 제거 (레코드 중복값)
        - 컬럼의 중복값 제거x -> 레코드 전체의 중복값 제거o





*/

-- tblcountry에 어떤 대륙들이 있습니까 ?
select distinct continent from tblcountry; --distinct 써서 중복값 제거

-- tblinsa 이 회사는 어떤 부서가 있습니까 ?
select distinct buseo from tblinsa;

-- tblinsa 이 회사는 어떤 직위가 있습니까 ?
select distinct jikwi from tblinsa;


select distinct name from tblinsa; -- =동명이인 없음




-- 어떤 부서 ? + 그 부서에 속한 직원명 ?
select DISTINCT buseo, name from tblinsa;






/*


    case
        - 대부분의 절에서 사용
        - Java : switch case문 역할
        - 조건을 만족 : then을 반환
        - 조건을 불만족 : null을 반환




*/

select
    last || first as name,
    gender,
    CASE
        --when 조건식 then 값
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as kgender -- 이름을 꼭 바꿔줘야 깔끔함
from tblcomedian;


select 
    name, continent,
    case
        when continent = 'AS' THEN '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        --else '기타'
        else continent
        --else 100 -> 숫자형이라 불가능
    end as continentName
from tblcountry;



select
    last || first as name,
    weight,
    case
        when weight>90 then'과체중'
        when weight>50 then'보통체중'
        else'저체중'
    end as state, 
    case
        when weight>=50 and weight<=90 then'보통체중'
        else '주의체중'
    end as state2,
    case
        when weight between 50 and 90 then'보통체중' --between 사용
        else '주의체중'
    end as state3
from tblcomedian;


--사원,대리 > 현장직
--과장,부장 > 관리직

select
    name,jikwi,
    case
        when jikwi = '과장'or jikwi ='부장' then '관리직'
        else '현장직'
    end,
      case
        when jikwi in ('과장','부장') then '관리직' --in 사용
        else '현장직'
    end,
    case
        when jikwi = '과장'or jikwi ='부장' then '관리직'
        else '현장직'
    end,
      case
        when jikwi like '%장' then '관리직' --like 사용
        else '현장직'
    end
from tblinsa;




select
    title,
    case
        when completedate is not null then '완료'
        when completedate is null then '미완료'
    end
from tbltodo;



