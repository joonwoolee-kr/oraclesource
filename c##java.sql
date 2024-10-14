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