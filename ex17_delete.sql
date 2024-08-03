/*

        ex17_delete.sql
        
        
        delete 문
            - DML
            - 원하는 행을 삭제하는 명령어
            - 역시나 이것도 where무조건 무조건 !!!! 달아야함 !!!!!!!!!
            delete [from]테이블명 [where절];

*/
commit;
rollback;

desc tblinsa;

select*from tblinsa;

delete from tblinsa where num = 1001; --PK값으로 꼭 해야한다.

























