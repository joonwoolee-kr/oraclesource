create table usertbl(
	userid varchar2(20) primary key,
	name varchar2(20) not null,
	password varchar2(20) not null,
	age number(3) not null,
	email varchar2(20) not null
);

INSERT INTO USERTBL VALUES('hong123','홍길동','hong123',25,'hong123@gmail.com');

-- email 열 크기 50으로 변경
ALTER TABLE USERTBL MODIFY email VARCHAR2(50);

-- userid(hong123) 와 password(hong123)가 일치하는 회원 조회
SELECT userid,name FROM USERTBL u WHERE USERID ='hong123' AND PASSWORD ='hong123';

-- 회원 전체 조회
SELECT userid,name,age,email FROM USERTBL;


-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL 
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

SELECT * FROM USERTBL u;

-- 회원삭제
-- 아이디와 비밀번호 일치시 삭제
DELETE FROM USERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';


-- booktbl
-- code number(4) pk
-- title 텍스트(50)
-- writer 텍스트(30)
-- price number(10)

CREATE TABLE booktbl(
	code number(4) PRIMARY KEY,
	title varchar2(50) NOT NULL,
	writer varchar(30) NOT NULL,
	price number(10) NOT null
);


ALTER TABLE booktbl ADD description VARCHAR2(1000);


-- 1000 자바의 정석 신용균 25000
INSERT INTO booktbl(code, title, writer, price)
values(1000, '자바의 정석', '신용균',25000);
-- 1001 자바의 신 강신용 29000
INSERT INTO booktbl(code, title, writer, price)
values(1001, '자바의 신', '강신용',29000);
-- 1002 자바 1000제 남궁성 32000
INSERT INTO booktbl(code, title, writer, price)
values(1002, '자바 1000제', '남궁성',32000);
-- 1003 오라클 박응용 33000
INSERT INTO booktbl(code, title, writer, price)
values(1003, '오라클', '박응용',33000);
-- 1004 점프투파이썬 신기성 35000
INSERT INTO booktbl(code, title, writer, price)
values(1004, '점프투파이썬', '신기성',35000);



-- 전체 조회
SELECT * FROM booktbl;

-- 도서번호 1000 번인 도서 조회(상세조회)
SELECT * FROM booktbl WHERE code = 1000;

-- 도서번호 1001 번인 도서 가격 수정
UPDATE booktbl SET price = 45000 WHERE code = 1001;

-- 도서번호 1001 번인 도서 가격 및 상세설명 수정
UPDATE booktbl 
SET price = 45000, DESCRIPTION='상세 설명'  
WHERE code = 1001;


-- 도서번호 1004 번 도서 삭제
DELETE FROM booktbl WHERE code = 1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM booktbl WHERE title LIKE '%자바%';



create table membertbl(
	userid varchar2(20) primary key,
	name varchar2(20) not null,
	password varchar2(20) not null	
);

INSERT INTO membertbl(userid,name,password)
VALUES('hong123','홍길동','hong123'); 

-- 아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT * FROM membertbl WHERE userid='hong123' AND password='hong12';

-- 중복 아이디 검사
-- 
SELECT * FROM membertbl WHERE userid='hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL  
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

-- board
-- bno(pk), name(varchar2-20), password(varchar2-20), title(varchar2-100),
-- content(varchar2-2000), attach(varchar2-100),re_ref, re_lev,re_seq,readcnt,regdate(date-sysdate)
CREATE TABLE board(
	bno number(8) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	attach varchar2(100) NOT NULL,
	re_ref number(8) NOT NULL,
	re_lev number(8) NOT NULL,
	re_seq number(8) NOT NULL,
	readcnt number(8) DEFAULT 0,
	regdate DATE DEFAULT sysdate	
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

-- board attach not null ==> null 가능
ALTER TABLE BOARD MODIFY ATTACH VARCHAR2(100) NULL;


INSERT INTO board(bno,name,password,title,content,RE_REF,re_lev,re_seq)
VALUES(board_seq.nextval,'hong','12345','board 작성','board 작성',board_seq.currval,0,0) 

-- 상세조회

SELECT * FROM board WHERE bno=1; 


-- 수정
-- bno와 password가 일치 시 title,content 수정
UPDATE BOARD 
SET title='변경할 타이틀', content='변경할 내용'
WHERE bno=1 AND password=12345;


-- 삭제(bno와 password가 일치 시)
DELETE FROM board WHERE bno=1 AND password='12345';


-- 조회수 업데이트 
UPDATE board
SET READCNT = READCNT + 1
WHERE bno = 3;



-- 더미 데이터
INSERT INTO board(bno,name,password,title,content,RE_REF,re_lev,re_seq)
(SELECT board_seq.nextval,name,password,title,content,board_seq.currval,re_lev,re_seq FROM board);

SELECT count(*) FROM board;

-- 댓글처리

-- 가장 최신글에 댓글 처리
SELECT
	*
FROM
	board
WHERE
	bno = (
	SELECT
		max(bno)
	FROM
		board);
	
-- 그룹 개념(re_ref)
	
-- 댓글 추가(re_ref : 부모글의 re_ref 넣어주기)
-- re_lev : 부모글 re_lev + 1 
-- re_seq : 부모글 re_seq + 1
INSERT INTO board(bno,name,password,title,content,RE_REF,re_lev,re_seq)
VALUES(board_seq.nextval,'hong','12345','board 작성','board 작성',578,1,1); 

-- UPDATE board SET re_lev=1, re_seq=1 WHERE bno = 579;

-- 원본글과 댓글 함께 조회
SELECT * FROM board WHERE RE_REF = 578;

-- 두번째 댓글추가 (최신순 조회 : re_seq)
-- re_seq 낮을수록 최신글

-- 원본글
--  ㄴ 댓글2
--    ㄴ 댓글2의 댓글
--  ㄴ 댓글1

-- 댓글2 추가
-- 먼저 들어간 댓글이 있다면 re_seq 값을 + 1 해야 함
-- UPDATE board SET re_seq = RE_SEQ + 1 WHERE re_ref = 부모글 re_ref AND re_seq > 부모글 re_seq
UPDATE board SET re_seq = RE_SEQ + 1 WHERE re_ref = 578 AND re_seq > 0;

INSERT INTO board(bno,name,password,title,content,RE_REF,re_lev,re_seq)
VALUES(board_seq.nextval,'hong','12345','댓글 board 작성','댓글 board 작성',578,1,1);

SELECT * FROM board WHERE RE_REF = 578 ORDER BY RE_REF DESC, re_seq ASC;

-- 검색
-- 조건 title or content or name 
-- 검색어
select bno,name,title,readcnt,regdate,re_lev from board ORDER BY RE_REF DESC, re_seq ASC;


select bno,name,title,readcnt,regdate,re_lev from board  WHERE title LIKE '%한글%' ORDER BY RE_REF DESC, re_seq ASC;
select bno,name,title,readcnt,regdate,re_lev from board  WHERE content LIKE '%한글%' ORDER BY RE_REF DESC, re_seq ASC;
select bno,name,title,readcnt,regdate,re_lev from board  WHERE name LIKE '%홍길동%' ORDER BY RE_REF DESC, re_seq ASC;

-- 오라클 페이지 나누기
-- 정렬이 완료된 후 번호를 매겨서 일부분 추출

select rownum, bno,name,title,readcnt,regdate,re_lev from board ORDER BY RE_REF DESC, re_seq ASC;
select rownum, bno,name,title,readcnt,regdate,re_lev from board ORDER BY bno DESC;

SELECT rnum, bno,name,title,readcnt,regdate,re_lev
FROM (SELECT rownum rnum, bno,name,title,readcnt,regdate,re_lev
      FROM (select bno,name,title,readcnt,regdate,re_lev from board ORDER BY RE_REF DESC, re_seq ASC)
      WHERE rownum <= 20)
WHERE rnum > 10;

-- 1 page 요청 :  rownum <= 10   rnum > 0
-- 2 page 요청 :  rownum <= 20   rnum > 10
-- 3 page 요청 :  rownum <= 30   rnum > 20

-- rownum : 1page * 10 = 10
-- rnum : (1page - 1) * 10

-- 전체 개수
SELECT count(*) FROM board;

-- 검색어 기준으로 전체 개수
SELECT count(*) FROM board WHERE title LIKE '%한글%';
SELECT count(*) FROM board WHERE content LIKE '%한글%';
SELECT count(*) FROM board WHERE name LIKE '%한글%';

