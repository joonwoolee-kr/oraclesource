CREATE TABLE usertbl(
userid varchar2(20) PRIMARY KEY,
name varchar2(20) NOT NULL,
password varchar2(20) NOT NULL,
age number(3) NOT NULL,
email varchar2(20) NOT null
);

INSERT INTO USERTBL VALUES('hong123', '홍길동', 'hong123', 25, 'hong123@gmail.com');
INSERT INTO USERTBL VALUES('sung1234', 'sung1234', 'sung1234', 22, 'sung123@daum.net');

-- email 열 크기 50으로 변경
ALTER TABLE	USERTBL MODIFY email varchar2(50);

-- userid(hong123)와 password(hong123)가 일치하는 회원 조회
SELECT userid, name FROM USERTBL u WHERE USERID = 'hong123' AND PASSWORD ='hong123';

-- 회원 전체 조회
SELECT userid, name, age, email FROM USERTBL;

-- 비밀번호 변경
-- 아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

SELECT * FROM  USERTBL u ;

-- 회원삭제
-- 아이디와 비밀번호 일치 시 삭제
DELETE FROM USERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';


-- booktbl
-- code number(4) pk
-- title 텍스트(50)
-- writer 텍스트(30)
-- price number(10)
CREATE TABLE booktbl(
code number(4) PRIMARY KEY,
title varchar2(50) NOT NULL,
writer varchar2(30) NOT NULL,
price number(10) NOT NULL
);

ALTER TABLE BOOKTBL ADD	description varchar2(1000);

-- 1000 자바의 정석 신용균 25000
-- 1001 자바의 신 강신용 29000
-- 1002 자바 1000제 남궁성 32000
-- 1003 오라클 박응용 33000
-- 1004 점프투파이썬 신기성 35000
INSERT INTO booktbl VALUES(1000, '자바의 정석', '신용균', 25000);
INSERT INTO booktbl VALUES(1001, '자바의 신', '강신용', 29000);
INSERT INTO booktbl VALUES(1002, '자바 1000제', '남궁성', 32000);
INSERT INTO booktbl VALUES(1003, '오라클', '박응용', 33000);
INSERT INTO booktbl VALUES(1004, '점프투파이썬', '신기성', 35000);

-- 전체 조회
SELECT * FROM BOOKTBL;

-- 도서번호 1000인 도서 조회(상세조회)
SELECT * FROM BOOKTBL b WHERE CODE = 1000;

-- 도서번호 1001인 도서 가격 수정
UPDATE BOOKTBL SET PRICE = 45000 WHERE CODE = 1001;

-- 도서번호 1001인 도서 가격 및 상세설명 수정
UPDATE BOOKTBL SET PRICE = 45000, DESCRIPTION = '상세 설명' WHERE CODE = 1001;

-- 도서번호 1004인 도서 삭제
DELETE FROM BOOKTBL b WHERE CODE = 1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM BOOKTBL b WHERE TITLE LIKE '%자바%';

-- 더미 데이터 삽입
CREATE SEQUENCE	book_seq
START WITH 2000;

INSERT INTO BOOKTBL(CODE, TITLE, WRITER, PRICE)
(SELECT book_seq.nextval, TITLE, WRITER, PRICE FROM	BOOKTBL)

SELECT COUNT(*) FROM BOOKTBL; 

-- 검색(조회)
-- title에 자바 키워드가 포함된 도서 조회 후 도서코드로 내림차순 정렬
SELECT * FROM BOOKTBL WHERE TITLE LIKE '%자바%' ORDER BY CODE DESC;

SELECT * FROM BOOKTBL WHERE TITLE LIKE '%%' ORDER BY CODE DESC;


CREATE TABLE membertbl(
userid varchar2(20) PRIMARY KEY,
name varchar2(20) NOT NULL,
password varchar2(20) NOT NULL
);

INSERT INTO membertbl values('hong123', '홍길동', 'hong123');

-- 아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT * FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

-- 중복 아이디 검사
SELECT  * FROM MEMBERTBL WHERE  USERID = 'hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD = 'hong123';


-- board
-- bno(pk), name(varchar2(20)), password(varchar2(20)), title(varchar2(100)), content(varchar2(2000)), attach(varchar2(100)),
-- re_ref, re_lev, re_seq, readcnt, regdate(date(sysdate))
CREATE TABLE board(
bno NUMBER(8) PRIMARY KEY,
name varchar2(20) NOT NULL,
password varchar2(20) NOT NULL,
title varchar2(100) NOT NULL,
content varchar2(2000) NOT NULL,
attach varchar2(100),
re_ref NUMBER(8) NOT NULL,
re_lev NUMBER(8) NOT NULL,
re_seq NUMBER(8) NOT NULL,
readcnt NUMBER(8) DEFAULT 0,
regdate DATE DEFAULT sysdate
);

-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

-- board attach not null
ALTER TABLE board MODIFY attach varchar2(20) NULL;

INSERT INTO board(bno, name, password, title, content, re_ref, re_lev, re_seq)
VALUES(board_seq.nextval, 'hong', '12345', 'board 작성', 'board 작성', board_seq.currval, 0, 0);

-- 상세조회
SELECT * FROM board WHERE bno = 3;

-- 수정
-- bno와 password가 일치 시 title, content 수정
UPDATE board SET TITLE = '변경할 타이틀', CONTENT = '변경할 내용' WHERE BNO = '1' AND PASSWORD = '12345';

-- 삭제
DELETE FROM board WHERE bno = 1 AND password = '12345';

-- 조회수 업데이트
UPDATE BOARD SET READCNT = READCNT + 1 WHERE BNO = 1;


-- 더미 데이터
INSERT INTO board(bno, name, password, title, content, re_ref, re_lev, re_seq)
(SELECT board_seq.nextval, name, password, title, content, board_seq.currval, re_lev, re_seq FROM board);

SELECT COUNT(*) FROM BOARD; 

-- 댓글 처리

-- 가장 최신 글에 댓글 처리
SELECT
	*
FROM
	BOARD
WHERE
	bno = (
	SELECT
		MAX(bno)
	FROM
		BOARD);
		
-- 그룹 개념(re_ref)

-- 댓글 추가(re_ref: 부모 글의 re_ref 넣어주기)
-- re_lev: 부모 글 re_lev + 1
-- re_seq: 부모 글 re_seq + 1
INSERT INTO board(bno, name, password, title, content, re_ref, re_lev, re_seq)
VALUES(board_seq.nextval, 'hong', '12345', 'board 작성', 'board 작성', 652, 0, 0);

UPDATE board SET re_lev = 0, re_seq = 0 WHERE bno = 652;

-- 원본 글과 댓글 함께 조회
SELECT * FROM board WHERE RE_REF = 652;

-- 두번째 댓글 추가(최신순 조회: re_seq)
-- re_seq 낮을수록 최신 글

-- 원본 글
-- ㄴ 댓글2
--   ㄴ 댓글2의 댓글
-- ㄴ 댓글1

-- 댓글2 추가
-- 먼저 들어간 댓글이 있다면 re_seq 값을 +1 해야 함
-- UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 부모글 re_ref AND RE_SEQ > 부모글 re_seq;
UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 652 AND RE_SEQ > 0;

INSERT INTO board(bno, name, password, title, content, re_ref, re_lev, re_seq)
VALUES(board_seq.nextval, 'hong', '12345', '댓글 board 작성', '댓글 board 작성', 652, 1, 1);

SELECT * FROM board WHERE RE_REF = 652 ORDER BY RE_REF DESC, RE_SEQ ASC;