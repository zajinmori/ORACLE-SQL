/*


        ex16_update.sql
        
        
        update문
        - DML
        - 원하는 행의 원하는 컬럼값을 수정하는 명령어
        - 무조건 무조건 !!! where 쓸것 !!!!!!!
        
        update 테이블명 set 컬럼명=값, 컬럼명=값, ... [where절 추가 가능]


*/

-- 트랜젝션 처리
commit;
rollback;

-- 대한민국: 서울 > 세종 (수도이전) update 사용법
select*from tblcountry;

update tblcountry set capital = '세종' where name = '대한민국';

update tblcountry set capital = '제주', population = 5000, continent = 'EU' where name = '대한민국';


--EU 속한 나라 > 인구수 증가 > 10%씩
update tblcountry set 
    population = population*1.1
    where continent = 'EU'; -- where 안붙히면 난리남 왜? 모든 데이터가 바뀜 ...



















