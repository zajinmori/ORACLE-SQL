/*

        ex20_join.sql
        ***************중요함*****************
        
        
        관계형 데이터베이스 시스템이 '지양'하는 것들
        
            1. 테이블에 기본키가 없는 상태 > 데이터 조작 불가능 왜? 식별불가능이라
            2. null이 많은 상태의 테이블 > 공간 낭비 + SQL작업 불편
            3. 데이터가 중복되는 상태 > 공간 낭비 + 데이터 조작 문제 발생(일관성x)
            4. 하나의 속성값이 원자값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣는다.
            

*/

-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트) 테이블 만드려고 할 때
create table tblstaff(
    seq number primary key,             --직원번호(PK)
    name varchar2(30) not null,         --직원명
    salary number not null,             --급여
    address varchar2(300) not null,     --거주지
    project varchar2(300)               --담당프로젝트
);
insert into tblstaff (seq, name, salary, address, project)
    values(1, '홍길동', 300,'서울시','홍콩 수출');
insert into tblstaff (seq, name, salary, address, project)
    values(2, '아무개', 250,'인천시','TV 광고');
insert into tblstaff (seq, name, salary, address, project)
    values(3, '이우진', 350,'의정부시','매출 분석');
    
-- '홍길동'에게 담당 프로젝트가 1건 추가 > '고객관리'
-- '홍콩 수출' + '고객관리'

update tblstaff set project = project || ',고객관리' where seq = 1; --절때 하면 안됨 > 여러값을 넣으면 안되기 때문

insert into tblstaff (seq, name, salary, address, project)
    values(4, '홍길동', 300,'서울시','고객관리');
    
select * from tblstaff;
-- 원인 : 테이블 스키마(구조)가 잘못된 상태
-- 해결 : 테이블 재 구 성

delete from tblproject;
delete from tblstaff;

drop table tblstaff;
drop table tblproject;


-- 직원 정보 = 부모테이블
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트) 테이블 만드려고 할 때
create table tblstaff(
    seq number primary key,             --직원번호(PK)
    name varchar2(30) not null,         --직원명
    salary number not null,             --급여
    address varchar2(300) not null      --거주지
);

-- 프로젝트 정보 = 자식테이블
-- 프로젝트(번호(PK), 담당프로젝트)
create table tblproject(
    seq number primary key,             --프로젝트번호
     project varchar2(300),             --담당프로젝트 (분리)
     staff_seq number references tblstaff(seq) not null          --담당직원번호(직원테이블을 참조)(FK) 
);


insert into tblstaff (seq, name, salary, address)
    values(1, '홍길동', 300,'서울시');
insert into tblstaff (seq, name, salary, address)
    values(2, '아무개', 250,'인천시');
insert into tblstaff (seq, name, salary, address)
    values(3, '이우진', 350,'의정부시');

insert into tblproject (seq, project, staff_seq) values (1,'홍콩수출',1);
insert into tblproject (seq, project, staff_seq) values (2,'TV광고',2);
insert into tblproject (seq, project, staff_seq) values (3,'매출분석',3);
insert into tblproject (seq, project, staff_seq) values (4,'노조협상',1);
insert into tblproject (seq, project, staff_seq) values (5,'대리점분양',2);

select * from tblstaff;
select * from tblproject;

--A.신입사원 입사 > 신규 프로젝트 배정
--  1. 신입사원 추가 > 성공!
insert into tblstaff (seq, name, salary, address)
    values(4, '고양이', 250,'성남시');

-- 2. 신규프로젝트 발주 + 담당자 배정 > 성공!
insert into tblproject (seq, project, staff_seq) values (6,'자재매입',4);

--ORA-02291: integrity constraint (HR.SYS_C007098) violated - parent key not found 부모키를 찾을 수 없다(없는 직원에게 배정해서!)
-- 3. 신규프로젝트 발주 + 담당자 배정 > 성공..?
insert into tblproject (seq, project, staff_seq) values (7,'고객유치',5); --없는 직원한테 배정..


select * from tblstaff;
select * from tblproject;

--B.'홍길동' 퇴사
-- '홍길동' 삭제
--ORA-02292: integrity constraint (HR.SYS_C007098) violated - child record found 인수인계를 안했다는 뜻
delete from tblstaff where seq = 1; --인수인계를 안하고 퇴사함.. 문제임

-- '홍길동' 삭제하기전에 업무 인수인계(위임)
update tblproject set staff_seq = 2 where staff_seq = 1;

-- '홍길동' 삭제




/*

        조인, Join
            - 서로 관계를 맺고 있는 2개(1개) 이상의 테이블을 1개의 결과셋으로 만드는 기술
            
            
            조인의 종류
                1. 단순 조인, Cross Join
                2. 내부 조인, Inner Join
                3. 외부 조인, Outer Join
                4. 셀프 조인, Self Join
                5. 전체 외부 조인, Full Outer Join



                    1. 단순 조인, Cross Join, 카티션 곱, 데카르트 곱
                        - 모든 조인의 기본 동작
                        - A테이블 x B테이블
                        - 쓸모없는 조인이다 !! > 가치있는 행과 가치없는 행이 뒤섞여 있기 때문이다..
                        - 대량의 dummy 만들때 사용(유효성 낮음)
                    



*/


select * from tblcustomer;
select * from tblsales;

--1. 단순 조인, Cross Join
select * from tblcustomer cross join tblsales; --3x9 = 27개의 행 / 표준 SQL > 권장
select * from tblcustomer, tblsales; -- /오라클 전용 cross join






/*
        ******* 2. 내부 조인, Inner Join ******** (아주 중요)
            - 단순 조인에서 유효한 레코드만 추출한 조인
            
            
            select 컬럼리스트 
            from 테이블A cross join 테이블B; > 단순조인
            
            select 컬럼리스트
            from 테이블A inner join(곱하기) 테이블B 
            on (부모)테이블A.컬럼(PK) = (자식)테이블B.컬럼(FK); > 내부조인 --> 조인의 where절 느낌

*/

--2. 내부 조인, Inner Join
select * 
from tblcustomer inner join tblsales
on tblcustomer.seq = tblsales.cseq; --on = where 비슷함

select *
from tblstaff inner join tblproject
on tblstaff.seq = tblproject.staff_seq;




--고객번호 +  고객명 + 상품명 + 상품번호
select tblcustomer.seq as cseq,tblcustomer.name,tblsales.seq as sseq,tblsales.item --컬럼이름이 같으면 테이블명을 앞에 붙힌다
from tblcustomer inner join tblsales
on tblcustomer.seq = tblsales.cseq;


select c.seq as cseq,c.name,s.seq as sseq,s.item --컬럼이름이 같으면 테이블명을 앞에 붙힌다
from tblcustomer c inner join tblsales s
on c.seq = s.cseq; --별칭써서 코드량 줄이기



-- 고객 + 판매
-- 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty) 사갔는지 ?? > join사용
select
    c.name as 고객명,
    s.item as 상품명,
    s.qty as 수량
from tblcustomer c
    inner join tblsales s
        on c.seq = s.cseq;
        

-- 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty) 사갔는지 ?? > sub qurey사용
-- 메인SQL > 자식테이블
-- 서브SQL > 부모테이블
select 
    item as 상품명,
    qty as 수량,
    (select name from tblcustomer where seq = tblsales.cseq) as 고객명
from tblsales;







-- 장르 + 비디오
select
    *
from tblgenre g
    inner join tblvideo v
        on g.seq = v.genre;


-- 장르 + 비디오 + 대여
select
*
from tblgenre g
    inner join tblvideo v
        on g.seq = v.genre
            inner join tblrent r
                on v.seq = r.video;
                
                
-- 장르 + 비디오 + 대여 + 회원
select
    -- * (너무 많은 정보를 가져와서 부담된다. 그래서 *를 잘 안쓴다)
    m.name as 누가,
    v.name as 무엇을,
    r.rentdate as 언제,
    g.price as 얼마에
from tblgenre g
    inner join tblvideo v
        on g.seq = v.genre
            inner join tblrent r
                on v.seq = r.video
                    inner join tblmember m
                        on r.member = m.seq;
                        
                        
                        
                        
-- hr / erd없이 짜면 헷갈린다..
select
    *
from employees e
    inner join departments d
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j
                                        on j.job_id = e.job_id;








/*


         3. 외부 조인, Outer Join   
            - 내부 조인 반댓말(X)
            - 내부 조인 결과셋 + a(내부 조인에 포함되지 않은 부모 테이블의 나머지 레코드)
            
            
            select
                컬럼리스트
            from 테이블A
               (left | right) outer join 테이블B
                    on 테이블A.PK = 테이블B.FK;




*/

select * from tblcustomer; --3
select * from tblsales;    --9

insert into tblcustomer values(4, '호호호','010-9999-9999', '서울시');
insert into tblcustomer values(5, '후후후','010-5555-5555', '강릉시');


-- 내부 조인 (양쪽다 존재하는 레코드를 가져오는것)
-- > 물건을 한번이라도 구매한 이력이 있는 고객의 정보 + 구매 내역을 가져오시오
-- > 구매 이력이 없는 4,5번 회원은 제외
-- > 내부조인 > 양쪽 테이블 모두에 존재하는 행만 가져오기
select
    *
from tblcustomer c
    inner join tblsales s
        on c.seq = s.cseq;


-- 외부조인 > 11개 > 9개(물건 수) + 2명(구매이력없는)
-- > 물건을 한번이라도 구매한 이력이 있는 고객의 정보 + 구매내역을 가져오시오
-- > 물건을 한번도 구매 안한 고객의 정보까지도 같이 가져오시오(+a)
select
*
from tblcustomer c left outer join tblsales s --left는 tblcustomer를 가르킴 > inner join에서 join이 안된(구매이력없는사람들)까지 불러온다 (보통 부모를 가르킨다)
    on c.seq = s.cseq;






-- 내부조인 > 프로젝트 최소 1건 이상 담당하고 있는 직원들의 명단 + 담당프로젝트
select
*
from tblstaff s
    inner join tblproject p
        on s.seq = p.staff_seq;
        
-- 외부조인 > 담당 프로젝트 유무와 상관없이 모든 직원 + 프로젝트 정보
select
*
from tblstaff s
    left outer join tblproject p
        on s.seq = p.staff_seq;






-- 비디오 + 대여 > 대여가 한번이라도 발생했던 비디오 + 대여기록
select
*
from tblvideo v
    inner join tblrent r
        on v.seq = r.video;
        
-- 대여가 있었던 비디오 
select
 distinct name
from tblvideo v
    inner join tblrent r
        on v.seq = r.video;


-- 비디오 + 대여 > 대여와 상관없이 모든 비디오 + 대여기록
select
*
from tblvideo v
    left outer join tblrent r
        on v.seq = r.video;
        
        
        
        
        
-- 회원 + 대여 > 대여를 최소 1회 이상했던 회원 + 대여 내역
select
*
from tblmember m
    inner join tblrent r
        on m.seq = r.member;
        
        


-- 회원 + 대여 > 대여와 상관없이 모든 회원 + 대여 내역
select
*
from tblmember m
    left outer join tblrent r
        on m.seq = r.member;
        
        
-- 대여를 한번도 하지 않았던 사람들
select
*
from tblmember m
    left outer join tblrent r
        on m.seq = r.member
            where r.seq is null;
            
            
            
-- 대여 기록이 있는 회원의 이름과 연락처(서브쿼리 사용) + 대여 횟수(group by 사용)
select
m.name,count(*), (select tel from tblmember where name = m.name)
from tblmember m
    inner join tblrent r
        on m.seq = r.member
            group by m.name
                order by count(*) desc;
            
    

-- 다중그룹 사용하기
select
    m.name, m.tel, count(*)
from tblmember m
    inner join tblrent r
     on m.seq = r.member
        group by m.name, m.tel
            order by count(*) desc;









/*

        
            
            inner join > 테이블 2개
            outer join > 테이블 1개
            inner join + self join > 테이블 1개
            outer join + self join > 테이블 1개
            
            
            
            4. 셀프 조인, Self Join
                - 1개의 테이블을 사용하는 조인
                - 테이블이 자기 스스로와 관계를 맺는 경우에 사용
            
            
            


*/

-- 직원 테이블
create table tblself(
    seq number primary key,                    --직원번호(PK)
    name varchar2(30) not null,                --직원명
    department varchar2(30) not null,          --부서명
    super number null references tblself(seq)  --직속상사번호(FK)
);

insert into tblself values (1,'홍사장','사장실',null);
insert into tblself values (2,'김부장','영업부',1);
insert into tblself values (3,'박과장','영업부',2);
insert into tblself values (4,'최대리','영업부',3);
insert into tblself values (5,'정사원','영업부',4);
insert into tblself values (6,'이부장','개발부',1);
insert into tblself values (7,'하과장','개발부',6);
insert into tblself values (8,'신과장','개발부',6);
insert into tblself values (9,'황대리','개발부',7);
insert into tblself values (10,'허사원','개발부',9);




--직원 명단을 가져오시오. 단, 상사의 이름도

-- 방법
-- 1. join
-- 2. sub query
-- 3. 계층형 쿼리(오라클 전용)


-- 1. join을 사용한 경우

select
    s2.name as 직원명,
    s1.name as 상사명,
    s2.department as 부서명
from tblself s1                -- 역할 : 상사 > 부모테이블
    inner join tblself s2      -- 역할 : 직원 > 자식 테이블
        on s1.seq = s2.super;       --inner join이지만 같은 테이블끼리 join했기 때문에 inner join이자 self join이다
        
        --> 직원명단에 사장님이 안나온다


select
    s2.name as 직원명,
    s1.name as 상사명,
    s2.department as 부서명
from tblself s1                      -- 역할 : 상사 > 부모테이블
    right outer join tblself s2      -- 역할 : 직원 > 자식 테이블
        on s1.seq = s2.super; 

        --> right outer로 바꿔서 사장님까지 나온다 > 자식을 가르킴(right)(특이한 케이스)




-- 2. sub query를 사용한 경우

select
    name as 직원명,
    department as 부서,
    (select name from tblself where seq = a.super) as 상사명 --이건 부모테이블(상사명단) (a.은 바깥에 있는 main쿼리인걸 구분하기 위해서 붙힘)
from tblself a; --sub query에서 main은 자식테이블(직원명단) 









/*


        5. 전체 외부 조인, Full Outer Join
            - 서로 참조하고 있는 관계에서 사용
            


*/

select * from tblmen;
select * from tblwomen;

--커플인 남/녀를 가져오시오
select
    m.name as 남자,
    w.name as 여자
from tblmen m                    --부모테이블
    inner join tblwomen w        --자식테이블  (둘이 서로 참조하고 있어서 어떤걸 부모테이블로 하던 상관없다)
        on m.name = w.couple;


-- left / right outer의 이해방법 !!!!!
--커플과 남자솔로를 가져오시오
select
    m.name as 남자,
    w.name as 여자
from tblmen m                    
    left outer join tblwomen w        
        on m.name = w.couple;

--커플과 여자솔로를 가져오시오
select
    m.name as 남자,
    w.name as 여자
from tblmen m                    
    right outer join tblwomen w        
        on m.name = w.couple;


--커플과 남자솔로 + 여자솔로를 가져오시오 = full outer join (left + right) = 잘 없는 경우임
select
    m.name as 남자,
    w.name as 여자
from tblmen m                    
    full outer join tblwomen w        
        on m.name = w.couple
            order by m.name, w.name;























