/*


        ex14_sequence.sql
        
        
        시퀀스, Sequence
            - 데이터베이스 객체 중 하나(테이블, 제약사항, 시퀀스)
            - 오라클 전용 객체(다른 DBMS 제품에는 없다)
            - ***** 일련 번호를 생성하는 객체 *****
            - 주로 식별자를 만드는데 사용한다 > 주로 PK값으로 사용한다 !
                                             > 이외에 다양한 용도로 활용한다 !!
            
                시퀀스 객체 생성하는 방법
                    - create sequence 시퀀스명;
                    
                    - create sequence 시퀀스명
                                    increment by n  --증감치
                                    start with n    --시작값
                                    maxvalue n      --최댓값
                                    minvalue n      --최솟값
                                    cycle           --순환 유무
                                    cache n;        --임시 저장
                
                시퀀스 객체 삭제하는 방법
                    - drop sequence 시퀀스명;
                
                시퀀스 객체 사용하는 방법
                    - 시퀀스명.nextval
                    - 시퀀스명.currval

*/

-- DB Object 명명법
-- : 헝가리언 표기법
-- ex) tblMemo
-- ex) seqMemo

create sequence seqNum start with 26;
drop sequence seqNum;

select seqNum.nextval from dual; --프로그램을 종료해도 초기화되지 않고 저장된다

select seqNum.currval from dual; --nextval의 현재 번호를 반환한다


insert into tblMemo(seq,name,memo,regdate)
            values(seqNum.nextVal, '시퀀스', '일련번호입니다', sysdate);

select * from tblmemo;


--쇼핑몰 > 상품번호 > ABC001 > ABC002

select 'ABC' || lpad(seqNum.nextval,3,'0') from dual;




drop sequence seqTest;

create sequence seqTest
                 --increment by -1 --시퀀스숫자를 3씩 증가해라 ~ 라는 의미
                 --start with 10 --시퀀스의 시작숫자를 10부터 시작해라 ~ 라는 의미
                 --maxvalue 10 -- 시퀀스의 숫자를 10까지만 제한한다 -> 그뒤는 에러
                 --minvalue 1; -- 시퀀스의 숫자를 1까지만 제한한다 -> 그뒤는 에러
                 --cycle  -- maxvalue/minvalue가 지정한 숫자까지 갔다가 다시 1부터 순환을 돈다
                 cache 20 --20을 안써도 기본값이 20이다
                 ;
                
select seqTest.nextval from dual;
















