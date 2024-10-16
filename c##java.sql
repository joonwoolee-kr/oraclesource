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