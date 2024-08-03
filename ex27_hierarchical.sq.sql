/*

        ex27_hierarchical.sq
    
    
        계층형 쿼리, Hierarchical Query
            - 오라클 전용 쿼리
            - 레코드의 관계가 서로 상하 수직 관계인 경우 사용
            - 자기 참조를 하는 테이블에서 사용
            - 자바(= 트리구조)
            
        tblself
        홍사장
            -김부장
                -박과장
                    -최대리
                        -김사원
            -이부장
                -최과장
                    - ...
        --> 이럴때 사용 (트리구조)
        

*/
create table tblComputer (
    seq number primary key,                         --식별자(PK)
    name varchar2(50) not null,                     --부품명
    qty number not null,                            --수량
    pseq number null references tblComputer(seq)    --부모부품(FK) (자기참조)
);

insert into tblComputer values (1, '컴퓨터', 1, null);

insert into tblComputer values (2, '본체', 1, 1);
insert into tblComputer values (3, '메인보드', 1, 2);
insert into tblComputer values (4, '그래픽카드', 1, 2);
insert into tblComputer values (5, '랜카드', 1, 2);
insert into tblComputer values (6, 'CPU', 1, 2);
insert into tblComputer values (7, '메모리', 2, 2);

insert into tblComputer values (8, '모니터', 1, 1);
insert into tblComputer values (9, '보호필름', 1, 8);
insert into tblComputer values (10, '모니터암', 1, 8);
insert into tblComputer values (14, '모니터클리너', 1, 8);

insert into tblComputer values (11, '프린터', 1, 1);
insert into tblComputer values (12, 'A4용지', 100, 11);
insert into tblComputer values (13, '잉크카트리지', 3, 11);


select * from tblcomputer;

--(자식)부품 명단 + 부모부품명 
select
    c2.name as 부품명,
    c1.name as 부모부품명
from tblcomputer c1                 --부모부품(누가 부모를 해도 상관없긴함)
    inner join tblcomputer c2       --자식부품
    on c1.seq = c2.pseq;

--> 트리구조로 보기가 힘든..

    



/*

    계층형 쿼리
        1. start with절
        2. connect by절 
        3. 의사 컬럼
            a. prior : 자신과 연관된 부모 레코드를 참조하는 가상 컬럼 = "부모 레코드 입니다~"
            b. level

*/
select
    seq as 번호,
    lpad(' ',((level-1)*5))||name as 부품명, --lpad를 사용해서 시각적으로 부모자식을 표현했다 !! -->꽤 자주 씀 ex)쇼핑몰 카테고리, 계층구조 등등
    prior name as 부모부품명,        -- 부모부품의 이름도 추가해줌
    level,       -- 세대번호(1=컴퓨터=할아버지, 2=본체=아버지 ...)
    connect_by_root name,        --이 테이블의 제일 맨위에 있는(조상)을 추가해줌
    connect_by_isleaf,           --너가 리프냐?(자식이 없는 최하위냐?) 0=false / 1=true
    sys_connect_by_path(name, '→')      --계층구조를 한번에 알려줌.. 구분자(→) 넣어서 시각적으로 보기 좋게 만듬
from tblcomputer
--    start with seq = 1               -- 최상위 레코드=1(루트 레코드) 맨 꼭대기를 정해주는 기준. 기준과 밑에 있는 자식들을 가져온다 (1=컴퓨터, 2=본체 ...)
--    start with pseq is null            -- 최상위 레코드가 꼭 1이라는 보장이 없음. 이렇게 해놓으면 좀 더 유연한 코드가 됨
      start with seq = (select seq from tblcomputer where name ='컴퓨터') -- 그치만 이렇게 서브쿼리를 써서 하는게 best !! 
        connect by prior seq = pseq; -- 부모와 자식을 연결하는 살짝 on 이랑 같은 느낌(join)



---위를 활용해서 tblself에 적용해보기
select
    lpad(' ',(level-1)*2) || name,
    department
from tblself
    start with super is null
        connect by prior seq = super;


















































