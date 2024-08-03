/*

    ex05_where절.sql
    
        [WITH<sub QUERY>]
        
        SELECT column_list
        FROM table_name
        
        [WHERE search_condition] 
        
        [GROUP BY group_by_expression]
        
        [HAVING serch-condition]
        
        [ORDER BY order_expression [ASC|DESC]];
        
        
        
        
        WHERE절 
            - 레코드(행)을 검색한다.
            - 조건절
            - 조건을 제시한 후 그 조건을 만족하는 레코드(행)를 가져온다.
            - 자바 스트림 : list.stream().filter(조건).forEach();
            - 조건을 만족하는 레코드를 결과셋을 만든다.
            - ***** WHERE절의 각 레코드에 대해서 검사를 진행한다 *****
        
        
        
        
        
        
        
        
        역할
            SELECT 컬럼리스트 : 컬럼 소스(테이블 지정 후 어떤 컬럼을? 즉, 컬럼지정 -> 컬럼을 가져와라)
            FROM 테이블명 : 데이터 소스(어떤 테이블로부터? 즉, 테이블지정 -> 데이터를 가져와라)
            WHERE 검색조건; : 조건을 지정, 원하는 레코드만 걸러낸다.
        
       *** 순서 ***
            3번, SELECT(대부분 마지막)
            1번, FROM (***무조건 첫번째)
            2번, WHERE

*/

-- 컬럼 : 5개, 레코드 : 14개
-- 레코드 1개 == 국가 1개 == 객체(인스턴스)
-- 컬럼들을 모아놓은것 == 테이블 설계 == 테이블 스키마 == 클래스의 역할
SELECT*FROM tblcountry;

--WHERE절은 레코드 필터의 역할을 한다.(가로)
select*from tblcountry where continent = 'AS'; --AS대륙의 국가들만 가져와라 라는 뜻

--SELECT절은 컬럼 필터의 역할을 한다.(세로)
select name, capital from tblcountry where continent = 'AS';



select * from tblcountry;

select * from tblcountry
    where name = '대한민국'; --한국의 정보만
    
select * from tblcountry
    where capital<>'서울'; --수도가 서울이 아닌 정보만
    
select * from tblcountry
    where population > 10000; --인구수가 10000명보다 많은 국가만
    
select * from tblcountry
    where area >= 100 and area < 500; --영토가 100 이상 500미만인 국가만
    
select * from tblcountry
    where continent = 'AS' or continent = 'EU'; --AS와 EU에 속한 국가만
    
    
    
select * from tblmen
    where (age - 1) >= 25; -- WHERE안에서 가공(-1)이 가능하다.

select * from tblcomedian
    where (height + Weight) > 300; --이런식의 가공도 가능



-- WHERE절 예제 1.

-- tblcomedian
-- 1. 몸무게가 60kg이상이고, 키가 170cm 미만인 사람을 가져오시오.
select*from tblcomedian
    where weight >= 60 and height < 170;

-- 2. 몸무게가 70kg 이하인 여자만 가져오시오.
select*from tblcomedian
    where gender = 'f' and weight <= 70;

-- tblinsa
-- 3. 부서가 '개발부'이고, 급여가 150만원 이상 받는 직원을 가져오시오.
select*from tblinsa
    where buseo = '개발부' and basicpay >= 1500000;
    
-- 4. 급여 + 수당을 합친 금액이 200만원 이상 받는 직원을 가져오시오.
select*from tblinsa
    where (basicpay + sudang) >= 2000000;
    
    
    
    
/*

    between
        - WHERE절에서 사용 > 조건으로 사용한다.
        - 컬럼명 between 최솟값 and 최댓값
        - 범위 조건
        - 가독성 향상의 목적 !
        - 최솟값, 최댓값 모두 포함한다.

*/

select*from tblinsa
    where basicpay >= 1000000 and basicpay <= 1200000;
    
select*from tblinsa
    where basicpay <= 1200000 and basicpay >= 1000000;
    
select*from tblinsa
    where 1200000 >= basicpay and basicpay >= 1000000;
    -- 3개가 다 똑같은 값을 의미한다 (사람마다 쓰는 차이가 있음 == 가독성 떨어짐)
    
select*from tblinsa
    where basicpay between 1000000 and 1200000;
    --그래서 between으로 통일시켜서 누구나 알아 볼 수 있다 == 가독성up

select*from tblinsa
    where basicpay between 1020000 and 1050000; --최솟값 포함 / 최댓값 포함 == 적는 값들을 포함한다
    
    
    
-- 비교 연산(자료형)
-- 1. 숫자형
desc tblinsa; --유형을 알아보는 법

select*from tblinsa where basicpay >= 1000000 and basicpay <= 1200000;
select*from tblinsa where basicpay between 1000000 and 1200000;


--2. 문자형
select*from tblinsa where name >= '이순신'; -- name.compareTo('이순신')

select*from employees where first_name >= 'J' and first_name <= 'L';
select*from employees where first_name between 'J' and 'L'; --between형


--3. 날짜시간형
select*from tblinsa where ibsadate > '2010-01-01'; --날짜시간 리터럴

select*from tblinsa where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';
select*from tblinsa where ibsadate between '2010-01-01' and '2010-12-31'; --between형



/*

    in
        - WHERE절에서 사용 > 조건으로 사용
        - 열거형 조건
        - 컬럼명 in (값,값,값)
        - 가독성 향상의 목적 !


*/

--tblinsa 개발부 + 총무부 + 홍보부

select*from tblinsa
    where buseo = '개발부' or buseo = '총무부' or buseo = '홍보부';
select*from tblinsa
    where buseo in ('개발부','총무부','홍보부'); --in형
    
    
--서울 or 경기 + 과장 or 부장 + 급여(250~300)
select*from tblinsa
    where city in('서울','경기') and jikwi in('과장','부장') and basicpay between 2500000 and 3000000; -- in형과 between형의 혼합
    





/*

    like
        - WHERE절에서 사용 > 조건으로 사용
        - 컬럼명 like '패턴 문자열'
        - 패턴 비교의 목적 !
        - 자바 정규표현식의 초간단버전
        
        
        패턴 문자열의 구성요소
            1. _ : 임의의 문자 1개(.)
            2. % : 임의의 문자 n개 -> 0~무한대 (.*)


*/

-- 김xx   
select name from tblinsa where name like '김__';
-- x길x
select name from tblinsa where name like '_길_';
-- xx수
select name from tblinsa where name like '__수';


select*from employees where first_name like 'S%'; --글자수 상관없이 S로 시작하는 사람 다 찾고 싶을때

  
select name from tblinsa where name like '김__'; --김훈, 김강아지 못찾음
select name from tblinsa where name like '김%'; -- 김, 김훈, 김강아지 암튼 김으로 시작하면 다 찾아냄

select name from tblinsa where name like '%길%'; -- '길'이 어디에 들어가도 찾음
select name from tblinsa where name like '%수'; -- '수'로 끝나는 애를 찾아라
    
select*from tblinsa
    where SSN like '______-2______';-- _사용
select*from tblinsa
    where SSN like '%-2%'; -- %사용
    

select*from 게시판 where subject = '자바';

select*from 게시판 where subject = '%자바%'; -- 제목에 '자바'가 포함된 글




/*

    RDBMS에서의 null
        - 컬럼값(셀)이 비어있는 상태
        - null상수 제공 ex) String txt = null;
        - **** 대부분의 언어는 null은 연산의 대상이 될 수 없다 ****
                ex) 10 + null = ? //연산자(+)의 입장에서보면 null은 없는 값이니 연산을 못한다.
        
        

    null조건
        - WHERE절에서 사용
        - 컬럼명 is null : null인걸 찾을 때
        - 컬럼명 is not null : null이 아닌걸 찾을 때
    
    
    

*/

-- 인구수가 미기재된 나라?

select*from tblcountry;

select*from tblcountry where population = null;
select*from tblcountry where population is null; -- is를 붙히면 된다.

-- 인구수가 기대된 나라?

select*from tblcountry where population <> null;
select*from tblcountry where not population is null; -- where에 not을 붙혀도 되지만,
select*from tblcountry where population is not null; -- is not을 붙히면 된다. (보통 이렇게 씀)

















