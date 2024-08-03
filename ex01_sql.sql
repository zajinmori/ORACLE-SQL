
-- : 한줄 주석

/*
    : 다중라인 주석
*/


/*
    
    -ex01.sql
    
    설치 프로그램
    1. Oracle Database 11g Express Edition
        - 데이터베이스(DB)
        - 오라클(회사) > 오라클(제품)
        - 11g > 버전
        - Express Edition > 종류(무료버전)
        - 실행화면이 없는 프로그램 > 눈에 안보이는 프로그램 > 서비스(윈도우), 데몬(리눅스)
            > 조작가능한 UI가 없다. > 그래서 SQL Developer가 필요하다.
        
    2. SQL Developer
        - 데이터베이스 클라이언트 도구(DB Client Tools) > GUI
        - 데이터베이스를 조작하는 프로그램
        - 전체 작업용
        
    3. SQL*PLUS
        - 데이터베이스 클라이언트 도구 > CLI(Command LIne Interface) > 콘솔환경
        - 간단한 작업용
    
    
    
    
    
    
    
    Oracle Database 11g Express Edition
        - 오라클 서비스
        - win + R > services.msc (오라클이 작동중인지 확인)
        
        1. OracleServiceXE
            - 오라클 데이터베이스(눈에 안보이는거)
            - 메인 서비스
            - 서비스 제어
                - net start 서비스명 (프로그램시작)
                - net stop 서비스명 (프로그램종료)
                - 시작메뉴>Oracle>시작,종료
        
        
        2. OracleXETNSListener
            - 클라이언트 접속 관리(Listener)
            
            
            
            
            오라클 설치 중..
            - 암호입력(java1234)
            - SYS, SYSTEM 계정 암호 > 기본계정 > 관리자 계정
            - SYS : 회장님 / SYSTEM : 사장님
            
            
        SQL Developer 접속
            - 오라클 데이터베이스에 접속
        1. 사용자 이름 : system
        2. 비밀번호 : java1234
        3. 호스트 이름 :오라클이 설치된 컴퓨터IP or 도메인
                         localhost(127.0.0.1) = 자기 자신
                         -> 컴퓨터 찾기
        4. 포트 : 1521  (Listener Port Number) 
                        (데이터가 오가는 통로, 65535개가 있음, 통로 한개는 하나의 프로그램만 가능하다)
                         -> 컴퓨터 안에 프로그램 찾기
        5. SID : xe / 하나의 컴퓨터에 여러 오라클 설치 > 구분식별자
                xe는 이름을 바꿀수가 없다
                ex)oracle1, oracle2
        
        6. Name : 접속 이력명(위에 내용들을 저장해놓는것)
                ex)system@localhost / localhost.system
    
    
        
        
        DB계정
        1. SYSTEM
            - 로컬 접속 가능
            - 원격 접속 가능
            
        2. SYS
            - 로컬 접속 가능
            - 원격 접속 불가능
        
        -> 잘안씀(데이터베이스 전문가들만 씀)
    
    
        3. 일반계정 (우리가 보통 쓰는 것)
            -생성 후 사용
            3-1. hr, scott
                -학습용계정
                -소량의 데이터 제공 > 학습
            3-2. 직접 생성
                - 수업 중, 프로젝트
    
    
        hr 계정 사용하는법
        1. 잠긴 계정 풀기
            - alter user 유저명 account unlock;
            
        2. 계정 암호 바꾸기
            - alter user 유저명 identified by 암호;
    
    
    

*/

-- shift + home/end > 한줄블럭 
-- 블럭잡고 ctrl + enter > 실행하기

alter user hr account unlock;

alter user hr identified by java1234;


/*

       데이터베이스, Database
            - 데이터의 집합
            
        Database Management System
            - 데이터베이스 관리 시스템
            - 데이터 집합 + 조작/관리
            - 오라클 > DBMS(DataBase Management System)
            
        Relational Database Management System
            - 관계형 데이터베이스 관리 시스템
            - RDB, RDBMS
            - 테이블로 데이터 저장하는 DB
            
            
        RDBMS
            - Oracle > 기업용(점유율 1위) > Java
            - MS-SQL > MS > 기업용 
            - DB2 > IBM
            - MySQL > Oracle > 무료였는데 유료전환..
            - MariaDB > MySQL 유사 > 무료
            - PostreSQL
            - SQLite > 모바일 > 경량DB
            - H2 > 스프링 > 초경량DB
            - MS Access > MS오피스 > 개인용
            
            
        Oracle Database Version
            - 1.0 ~
            - 11g
            - 23ai
            
            
            
        오라클(DB서버) <-> SQL Developer(클라이언트 툴) <-> 개발자(클라이언트)
          
          
        SQL, Structured Query Language
            - 오라클 사용하는 언어 > 모든 관계형 데이터베이스 관리 시스템이 사용하는 언어
            - RDB와 대화하는 언어        
            - 구조화된 질의 언어
            - Query(질의) > 오라클에게 질문
            - SQL == Query
            
            
        DB분야 직군
            - 오라클 시스템 + SQL 언어
            
            1. 데이터베이스 관리자, DBA
                - 오라클의 모든 것 취급
            
            2. 데이터베이스 개발자
                - 오라클의 거의 모든 것 취급(관리자의 하위)
                
            -> DB팀
            
            
            3. 응용 프로그램 개발자(자바개발자)
                - 일부 작업 > SQL언어
                
        
        SQL 특징
            1. 데이터 베이스 제작사와 독립적이다.(언어를 배우면 어떤 회사든 쓸수있음)
                - 모든 데이터베이스에서 공통으로 사용한다.
                - 표준 SQL > 제작사들이 자신의 제품을 적용한다.
                
            2. 표준 SQL == ANSI-SQL
                - 모든 DB에서 사용 가능한 SQL
                
            3. 방언 (제작사별로 개성을 만들기 위해)
                - 제작사별로 자기 제품에서만 동작하는 SQL을 만듬
                - Oracle > PL/SQL 
                - MS-SQL > T-SQL
                
                
        오라클 수업 == 표준SQL(60%) + DB설계(10%) + PL/SQL(30%) 진행
            - 수업시간 : 2주정도
            
            
            
        표준 SQL
            1. DDL
                - Data Definition Language
                - 데이터 정의어
                - 테이블, 뷰, 사용자, 인덱스 등의 DB 오브젝트를 생성/수정/삭제하는 명령어
                - DB구조를 생성/수정/삭제하는 명령어
                a. create : 생성
                b. drop : 삭제
                c. alter : 수정
                - 사용하는 사람
                    -데이터베이스 관리자
                    -데이터베이스 개발자
                    -프로그래머(일부사용,안쓸수도있음)
                
            2. DML ***
                - Data Manipulation Language
                - 데이터 조작어
                - 데이터 추가/수정/삭제/조회하는 명령어
                - 사용 빈도가 가장 높음**
                a.select : 조회(읽기) > [R]ead
                b.insert : 추가(생성) > [C]reate
                c.update : 수정       > [U]pdate
                b.delete : 삭제       > [D]elte
                    ->CRUD
                 - 사용하는 사람
                    -데이터베이스 관리자
                    -데이터베이스 개발자
                    -프로그래머(많이 씀****)
                    
            3. DCL
                - Data Control Language
                - 데이터 제어어
                - 계정 관리, 보안 관리, 트랜잭션 처리 등..
                a.commit
                b.rollback
                c.grant
                d.revoke
                 - 사용하는 사람
                    -데이터베이스 관리자
                    -데이터베이스 개발자
                    -프로그래머(일부사용,안쓸수도있음)
            
            4. DQL
                - Data Query Language
                - DML중에서 select문을 따로 부르는 표현
            5. TCL
                - Transaction Control Language
                - DCL중에서 commit, rollback문을 따로 부르는 표현
                
                
        
        
        오라클 인코딩
            - 1.0 ~ 8 : EUC-KR
            - 9i ~ 현재 : UTF-8
            
        
        SQL > 대소문자를 구분하지 않는다.
        - 파란색 : 키워드 (All 대문자)
        - 검은색 : 식별자 (All 소문자)
        ex)SELECT*FROM tabs;
        블럭잡고 alt + ' = 한꺼번에 바꿀수있음
        
        
*/
SELECT*FROM tabs;

SELECT*FROM tabs;





