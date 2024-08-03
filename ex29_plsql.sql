/*

    ex29_plsql.sql
    
    PL/SQL
    - Procedural Language for SQL
    - Procedural Language extension to SQL
    - 표준 SQL + 절차 지향 언어의 기능을 추가(변수, 제어 흐름, 객체 정의 등)
    
    
    프로시저, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어들의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 표준 SQL 영역 <->  프로시저 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성
    
    2. 저장(실명) 프로시저
        - 저장
        - 재사용
        - 데이터베이스 객체(create/drop)


    PL/SQL 프로시저 구조
    
    1. 4개의 블럭(파트)으로 구성
        - DECLARE
        - BEGIN
        - EXCEPTION
        - END
    
    2. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능
    
    3. BEGIN({) ~ END(})
        - 구현부
        - 구현된 코드를 가지는 영역(메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드? > PL/SQL(연산, 제어 등) + 표준 SQL(DDL,DML)
        
    4. EXCEPTION
        - 예외 처리부
        - 3번 > 자바의 try절 역할
        - 자바의 catch절 역할
        - 평소에 실행(X) > 에러가 발생했을 때 실행(O)
        - 생략 가능
    
    구문
    
    [DECLARE 
        변수 선언;
        객체 선언;]
    BEGIN
        업무 코드(변수 선언);
        업무 코드(제어문);
        업무 코드(SQL);
    [EXCEPTION
        예외처리 코드;]
    END;
    
    
    자바 > SQL > PL/SQL
    
    PL/SQL 자료형
    - 표준 SQL과 동일
    
    PL/SQL 연산자
    - 표준 SQL과 동일
    
    
    변수 선언하기
    - 변수명 자료형(길이) [not null] [default 값];
    
*/

-- 여태 수업했는 이 영역 > 스크립트 파일 > 표준 SQL 영역

-- dbms_output.put_line() 함수는 평상 시에는 결과가 눈에 안보임
set serveroutput on;
set serverout on;
set serveroutput off;

-- 익명 프로시저
begin
    dbms_output.put_line('Hello World~');
end;
/

declare
    num number;
    name varchar2(30);
    today date;
begin   
    num := 10;
    dbms_output.put_line(num);
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    today := to_date('2024-08-02', 'yyyy-mm-dd');
    dbms_output.put_line(today);
    
end;
/


declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40;
    num5 number not null := 50; --선언과 동시에 초기화(not null)
begin
    dbms_output.put_line('@' || num1 || '@'); --null 상태 > null출력
    
    num2 := 10;
    dbms_output.put_line(num2);
    
    dbms_output.put_line(num3);
    
    num4 := 400;
    num4 := null;
    dbms_output.put_line(num4);
    
    --num5 := null;
    dbms_output.put_line(num5);
    
end;
/



/*

    변수 > 어떤 용도로 사용?
    - 일반적인 값을 저장하는 용도 > 비중 낮음
    - select 결과를 담는 용도 > 비중 높음
    
    select 결과 > (대입) > PL/SQL 변수
    > select into절(PL/SQL 문법)
        
*/

declare
    vbuseo varchar2(15);
begin
    --vbuseo := select buseo from tblInsa where name = '홍길동';
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo); -- buseo 컬럼명
    
    insert into tblTodo
        values ((select max(seq) + 1 from tblTodo)
                    , vbuseo || '에 택배보내기', sysdate, null);
    
end;
/

select * from tblTodo;






-- tblInsa
-- 성과급을 받는 직원
create table tblBonus (
    name varchar2(15)
);

-- 1. 개발부 + 부장 > select > name?
-- 2. tblBonus > name > insert
declare
    vname varchar2(15);
begin
    select name into vname from tblInsa
        where buseo = '개발부' and jikwi = '부장'; --1.
    insert into tblBonus (name) values (vname); --2.    
end;
/


insert into tblBonus (name) values ((select name from tblInsa
        where buseo = '개발부' and jikwi = '부장'));


select * from tblBonus;



declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin
    
    -- select into 절
    
--    select 
--        name into vname, 
--        buseo into vbuseo, 
--        jikwi into vjikwi, 
--        basicpay into vbasicpay
--    from tblInsa where num = 1001;
    
    -- into 사용 시
    -- 1. 컬럼의 개수와 변수의 개수 일치
    -- 2. 컬럼의 순서와 변수의 순서 일치
    -- 3. 컬럼과 변수의 자료형 일치
    
    select 
        name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
    from tblInsa where num = 1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
end;
/


/*

    타입 참조
    
    %type
    - 컬럼 참조
    - 사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
        c. not null or 제약사항 > 복사X
    
    %rowtype
    - 행 참조
    - 모든 컬럼을 한번에 참조
    
*/
desc tblInsa;


declare
    --vbuseo varchar2(15);
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;
/


declare
    vname       tblInsa.name%type;
    vbuseo      tblInsa.buseo%type;
    vjikwi      tblInsa.jikwi%type;
    vbasicpay   tblInsa.basicpay%type;
begin
    select
        name, buseo, jikwi, basicpay
        into
        vname, vbuseo, vjikwi, vbasicpay
    from tblInsa
        where num = 1001;
        
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
end;
/


drop table tblBonus;

create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num),  --직원번호(FK)
    bonus number not null
);
create sequence seqBonus;


-- 프로시저 선언하기
-- 1. 서울 + 부장 + 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)
declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
begin
    
    select
        num, basicpay into vnum, vbasicpay
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';
    
    insert into tblBonus values (seqBonus.nextVal, vnum, vbasicpay * 1.5);
    
end;
/

select * from tblBonus; -- 1	1023	3750000

-- 보너스 지급 내역 페이지
select
    *
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;
    

rollback;

select * from tblMen;
select * from tblWomen;

-- 무명씨 > 성전환 수술 > tblMen > tblWomen 옮기기 > 프로시저 1개 선언하기
-- 1. '무명씨' > select.. tblMen
-- 2. 1 > tblWomen > insert
-- 3. tblMen > delete

declare
    vname   tblMen.name%type;
    vage    tblMen.age%type;
    vheight tblMen.height%type;
    vweight tblMen.weight%type;
    vcouple tblMen.couple%type;
begin
    --1.
    select 
        name, age, height, weight, couple 
        into
        vname, vage, vheight, vweight, vcouple 
    from tblMen
        where name = '하하하';
    
    --dbms_output.put_line(vage);
    --dbms_output.put_line(vheight);
    
    --2.
    insert into tblWomen (name, age, height, weight, couple)
        values (vname, vage, vheight, vweight, vcouple);
        
    --3.
    delete from tblMen where name = vname;
    
end;
/


declare
    vrow tblMen%rowtype;
begin
    --1.
    select * into vrow from tblMen
        where name = '홍길동';
    
    --dbms_output.put_line(vrow.name);
    --dbms_output.put_line(vrow.age);
    --dbms_output.put_line(vrow.height);
        
    --2.
    insert into tblWomen (name, age, height, weight, couple)
        values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
        
    --3.
    delete from tblMen where name = vrow.name;
    
end;
/



/*
    제어문
    1. 조건문
    2. 반복문
    3. 분기문
*/


-- if문
declare
    vnum number := 10;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    end if;
    
end;
/


declare
    vnum number := 10;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('양수 아님');
    end if;
    
end;
/



declare
    vnum number := 10;
begin
    
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum < 0 then -- else if, elsif, elseif 등..
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0');
    end if;
    
end;
/

-- tblInsa. 직원 검색(num) > 남자 or 여자 > 다른 업무 진행

declare
    vgender char(1);
begin
    
    select substr(ssn, 8, 1) into vgender from tblInsa where num = 1001;
    
    if vgender = '1' then
        dbms_output.put_line('남자 업무..');
    elsif vgender = '2' then
        dbms_output.put_line('여자 업무..');
    end if;
    
end;
/



-- 직원 1명 선택 > 보너스 지급 > 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 사원/대리 > basicpay * 2

declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
    vjikwi      tblInsa.jikwi%type;
    vbonus      number;
begin
    
    select
        num, basicpay, jikwi into vnum, vbasicpay, vjikwi
    from tblInsa where num = 1005;
    
    if vjikwi in ('과장', '부장') then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('사원', '대리') then
        vbonus := vbasicpay * 2;
    end if;    
    
    insert into tblBonus values (seqBonus.nextVal, vnum, vbonus);
    
end;
/

select
    *
from tblInsa i
    inner join tblBonus b
        on i.num = b.num;


/*

    case문
    - 표준 SQL > case end 와 동일

*/

-- AS > 아시아
select continent from tblCountry where name = '대한민국';


declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin

    select continent into vcontinent from tblCountry where name = '대한민국';
    
    case 
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;
/


/*

    반복문
    
    
    1. loop
        - 기본형
        - 횟수 반복(자바 for)
        - exit when 으로 탈출
        
    2. for loop
        - 1 번 기반
        - 횟수반복 (자바 for)
        
    2. while loop
        - 1번 기반
        - 조건 반복(자바 while)
    
    

*/

begin
    loop
        dbms_output.put_line('구현부');
    end loop;
    
end;
/



declare
    vnum number :=1;
begin

    loop
    
    dbms_output.put_line(vnum);
    vnum := vnum +1;
    
    exit when vnum > 10;
    
    end loop;
    
end;
/

create table tblLoop(
    seq number primary key,
    data varchar2(100) not null
);

create sequence seqLoop;

--tblLoop > 데이터추가 > 항목001, 항목002, 항목003 ..

declare
    vnum number := 1;
begin

    loop
    
    
        dbms_output.put_line(lpad(vnum,3,'0'));
        
        insert into tblloop values (seqLoop.nextval, '항목'||lpad(vnum,3,'0'));
        
        vnum := vnum+1;
        exit when vnum >= 1000;
        
    end loop;

end;
/

select * from tblloop order by seq desc;





/*

        2. for loop
            for(int i=0, i<10, 1++){
            }
            +
            for(int n:list){
            }
            
            foreach(){}


*/


begin

    for i in 1..10 loop --1..10 = 1~10까지의 집합 즉, 1~10을 찍어라
        dbms_output.put_line(i);
    
    end loop;
end;
/

-- 복합키 만드는 법 (dan+num)
create table tblGugudan (
    dan number not null ,
    num number not null ,
    result number not null,
    
    constraint tblgugudan_dan_num_pk primary key(dan,num)   --복합키(Composite Key)  
);


--구구단 만들기 -> 2중루프
begin

    for i in 2..9 loop
        for j in 1..9 loop
            insert into tblgugudan (dan,num,result) 
                values(i,j,i*j);
        end loop;
    end loop;

end;
/
select * from tblgugudan;






-- 복합키 > 관계 맺기

create table tblStudent (
    name varchar2(30) not null,
    subject varchar2(30) not null,
    tel varchar2(15) not null,
    constraint tblstudent_name_subject_pk primary key(name, subject)  --복합키
);

create table tblscore (
    score number not null,
    name varchar2(30) not null,               --FK
    subject varchar2(30) not null,            --FK
    constraint tblscore_name_subject_fk foreign key(name,subject) references tblstudent(name,subject)
);

insert into tblstudent (name, subject, tel)
    values('홍길동','자바','010-1234-5678');
insert into tblstudent (name, subject, tel)
    values('홍길동','오라클','010-1234-5678');
insert into tblstudent (name, subject, tel)
    values('고양이','자바','010-1234-5678');
    
insert into tblscore (score,name,subject)
    values(100,'홍길동','자바');
insert into tblscore (score,name,subject)
    values(90,'홍길동','오라클');
insert into tblscore (score,name,subject)
    values(80,'고양이','자바');
    
insert into tblscore (score,name,subject)
    values(100,'고양이','오라클');    --고양이는 오라클 시험을 안봐서 안들어가진다
    
select * from tblstudent;
select * from tblscore;

select * from tblstudent where name = '홍길동';
select * from tblstudent where name = '홍길동' and subject = '자바';


--join
select * from tblstudent t
    inner join tblscore c
        on t.name = c.name and t.subject = c.subject;

-------복합키 끝//



-- for loop

begin

    for i in reverse 1..10 loop --reverse = 역순
        dbms_output.put_line(i);
    end loop;
end;
/



/*


    3. while loop


*/

declare
    vnum number :=1;
begin
    while vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum+1;
    end loop;
    
end;
/




--select into > 결과가 없으면 ???
declare
    vname tblinsa.name%type;
    vbasicpay tblinsa.basicpay%type;
    vnum number := 1100; --없는 사람
    vcnt number;
begin

    select count(*) into vcnt from tblinsa where num = vnum;  --count(*)로 물어봤으니 있으면 1 없으면 0이다

    if vcnt >0 then
         select name, basicpay into vname,vbasicpay from tblinsa 
             where num = vnum;
    
    dbms_output.put_line('이름'||vname);
    dbms_output.put_line('급여'||vbasicpay);
    end if;
    
end;
/



/*

        select > 결과셋 > PL/SQL 변수 대입
        
        1. select into
            - 결과셋의 레코드가 1개일때만 사용이 가능하다.
            - 결과가 0이면 에러 발생 !!
        
        2. cursor + 루프 *** PL/SQL에서 가장 많이 씀 ***
            - 결과셋의 레코드가 n개일때만 사용이 가능하다.(0 ~ 이상)
            
 declare
    변수 선언;
    커서 선언; --결과셋 참조 객체
 begin
    커서 열기;
        loop
            커서 참조 > 레코드 접근
            exit when 조건
        end loop
    커서 닫기;
 end;
/
            
        
*/

    cursor vcursor 
    is 
    selelct name from tblinsa;
    ----비슷
    create view
    as
    select name from tblinsa;








--tblinsa. 직원들 이름을 가져오시오 (전원 다)
declare
    -- cursor 커서명 is select문;
    cursor vcursor 
    is 
    select name from tblinsa; --커서
    
    vname tblinsa.name%type; --변수
    
begin

    -- cursor 사용
    open vcursor; --커서열기 > 위에있는 select문 실행
    
        -- fetch 커서 into 변수
        -- select 컬럼 into 변수
--        fetch vcursor into vname;
--        dbms_output.put_line(vname);
--        
--         fetch vcursor into vname;
--        dbms_output.put_line(vname);
--        
--         fetch vcursor into vname;
--        dbms_output.put_line(vname);
        loop
             fetch vcursor into vname;
             exit when vcursor%notfound; -- 끝까지 돌아서 마지막 사람을 찾고 이제 없으면. 이라는 뜻
             
            dbms_output.put_line(vname);
            
        end loop;

    
    close vcursor;

end;
/


-- '기획부' 직원들 > 이름, 직위, 급여 > 출력
declare

    cursor vcursor
    is
    select name, jikwi, basicpay from tblinsa where buseo = '기획부';
    
    vname tblinsa.name%type;
    vjikwi tblinsa.jikwi%type;
    vbasicpay tblinsa.basicpay%type;
begin

    open vcursor;
        loop
            fetch vcursor into vname, vjikwi, vbasicpay;
            exit when vcursor%notfound;
            
            --1회전 > 기획부 1명
            dbms_output.put_line(vname ||','|| vjikwi ||',' || vbasicpay);
            
        end loop;
    close vcursor;
    
end;
/


/*

문제. tblbonus
- 모든 직원에게 보너스 지금(60명전원)
- 과장,부장 > basicpay*1.5
- 사원,대리 > basicpay*2

*/

select * from tblinsa;

declare
    
    cursor vcursor
    is
    select num, basicpay, jikwi from tblinsa;
    
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
    vjikwi      tblInsa.jikwi%type;
    vbonus      number;
    
begin
    
    open vcursor;
        loop
            fetch vcursor into vnum,vbasicpay, vjikwi;
            exit when vcursor%notfound;
    
            if vjikwi in ('과장', '부장') then
            vbonus := vbasicpay * 1.5;
            elsif vjikwi in ('사원', '대리') then
            vbonus := vbasicpay * 2;
            end if; 
    
    
    insert into tblBonus values (seqBonus.nextVal, vnum, vbonus);
    
    end loop;
    close vcursor;
    
end;
/


-- 커서 탐색
-- 1. 커서 + loop > 기본형
-- 2. 커서 + for loop > 간단 버전


--          60명 직원 정보 전부 출력
-- 1. 커서 + loop > 기본형

declare
    cursor vcursor is select * from tblinsa;
    vrow tblinsa%rowtype;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    close vcursor;
end;
/

-- 2. 커서 + for loop > 간단 버전
declare
    cursor vcursor is select * from tblinsa;
    --vrow tblinsa%rowtype; 알아서 만들어줌
begin
    --open vcursor; ->for loop가 알아서해줌
   for vrow in vcursor loop
        --fetch vcursor into vrow;
        --exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    --close vcursor; ->for loop가 알아서해줌
end;
/






--예외 처리, Exception

-- ORA-01403: no data found
-- ORA-01476: divisor is equal to zero



declare
    vname tblinsa.name%type;
    vcnt number;
begin
    dbms_output.put_line(111);
    select name into vname from tblinsa where num = 1001; 
    dbms_output.put_line(222);
    dbms_output.put_line(vname);
    dbms_output.put_line(333);
    
    select count(*) into vcnt from tblinsa where buseo = '기재부';
    dbms_output.put_line(10000000/vcnt);
    
exception
 when NO_DATA_FOUND then
    dbms_output.put_line('데이터가 없어요');
    
when ZERO_DIVIDE then
    dbms_output.put_line('0으로 나누려고 했어요');
    
   when others then
       dbms_output.put_line('예외를 처리했습니다');
    
end;
/


























