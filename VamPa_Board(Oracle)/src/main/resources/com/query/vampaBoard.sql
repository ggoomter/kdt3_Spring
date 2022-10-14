SELECT sysdate FROM dual;

create table vam_board(
    bno number generated always as IDENTITY,
    title varchar2(150) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    constraint pk_board PRIMARY key(bno)
);

insert into vam_board(title, content, writer) values ('테스트 제목', '테스트 내용', '작가');
insert into vam_board(title, content, writer) values ('테스트 제목', '테스트 내용', '작가');
insert into vam_board(title, content, writer) values ('스프링제목', '스프링 내용', '유시민');

--전체조회
select * from vam_board;

SELECT ROWNUM, BNO, TITLE, CONTENT, WRITER, REGDATE, UPDATEDATE
FROM VAM_BOARD ORDER BY BNO;
--지금최고는 32772
--32742부터 보이고 있다.
--15개씩 보이.  1페이지에서 32772에서 15개 보이고 
--			2페이지에서 32757에서 15개 보이고
--			3페이지에서 32742에서 15개 보이고


select * from vam_board WHERE bno = 8;

update vam_board set title='제목 수정', content='내용 수정', updateDate = sysdate where bno = 8;


-- 재귀 복사
insert into vam_board(title,content,writer)(select title,content, writer from vam_board);
COMMIT;

--11부터 20까지 조회
--rownum은 모든 쿼리실행후 최종결과에 붙기 때문에 내부쿼리없이 직접사용하면 순서상 조건으로 걸수가 없음
select rn, bno, title, content, writer, regdate, updatedate from(
        select /*+INDEX_DESC(vam_board pk_board) */ rownum as rn, bno, title, content, writer, regdate, updatedate
        from vam_board)
where rn between 11 and 20;
--500개일때 42, 2     16000개일때 3036, 74

SELECT * FROM VAM_BOARD
WHERE BNO between 31 AND 40
ORDER BY BNO DESC;
--500개일때 3, 2   16000개일때 3,2

select /*+INDEX_DESC(vam_board pk_board) */ rownum as rn, bno, title, content, writer, regdate, updatedate
        from vam_board
where rownum <= 20;


select rn, bno, title, content, writer, regdate, updatedate from(
        select /*+INDEX_DESC(vam_board pk_board) */ rownum  as rn, bno, title, content, writer, regdate, updatedate 
        from vam_board where rownum <= 20) 
where rn > 10;
--rownum < 현재페이지 * 한페이지당갯수
--rn > 한페이지당갯수


select bno, title, content, writer, regdate, updatedate from(
        select /*+INDEX_DESC(vam_board pk_board) */ rownum  as rn, bno, title, content, writer, regdate, updatedate
        from vam_board where rownum <= 10 and title like '%스프링%')
where rn > 0;
