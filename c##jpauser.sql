-- memo 테이블 생성
-- 메모번호(mno - pk), 메모내용(memo_text - not null) 
CREATE TABLE memo(
	mno number(15) PRIMARY KEY,
	memo_text varchar2(200) NOT NULL 
);
-- 메모번호는 시퀀스(memo_seq) 입력
CREATE SEQUENCE memo_seq;

DROP TABLE memo;
DROP SEQUENCE memo_seq;

INSERT INTO MEMO values(memo_seq.nextval,'오늘의 할일');

-- 회원, 팀
-- 회원은 단 하나의 팀에 소속된다.
-- 하나의 팀에는 여러 회원 소속된다.

-- 회원(아이디, 이름, 팀정보)
-- 팀(아이디, 팀명)

CREATE TABLE team(
	team_id varchar2(100) PRIMARY KEY,
	name varchar2(100) NOT NULL 
);

CREATE TABLE team_member(
	member_id varchar2(100) PRIMARY KEY,
	username varchar2(100) NOT NULL,
	team_id varchar2(100) CONSTRAINT fk_member_team REFERENCES team(team_id)
);

INSERT INTO team values('team1', '팀1');
INSERT INTO team values('team2', '팀2');

INSERT INTO team_member values('user1','홍길동','team1');

-- 홍길동이 소속된 팀의 이름 조회

SELECT tm.USERNAME, tm.MEMBER_ID, t.TEAM_ID, t.NAME 
FROM TEAM_MEMBER tm JOIN team t ON tm.TEAM_ID = t.TEAM_ID; 

-- 내부조인
SELECT tm.USER_NAME , tm.TEAM_ID , t.ID , t.NAME 
FROM team t JOIN TEAM_MEMBER tm ON  t.ID = tm.TEAM_ID; 

-- Hibernate 외부조인(@ManyToOne)
SELECT
	m1_0.id,
	t1_0.id,
	t1_0.name,
	m1_0.user_name
FROM
	team_member m1_0
LEFT JOIN
        team t1_0 
            ON
	t1_0.id = m1_0.team_id
WHERE
	m1_0.id = 'user1';


-- 회원 조회시 같은 팀에 소속된 회원 조회
-- 팀1
SELECT * FROM TEAM_MEMBER tm;

SELECT
	tm.USER_NAME ,
	tm.ID ,
	t.ID,
	t.NAME
FROM
	team t
JOIN TEAM_MEMBER tm ON
	t.ID = tm.TEAM_ID
WHERE
	t.NAME = '팀1';


UPDATE TEAM_MEMBER 
SET TEAM_ID = 'team2'
WHERE TEAM_ID = 'team1' AND id = 'user6';

-- BOARD ID 기준으로 내림차순
SELECT * FROM BOARD b ORDER BY b.ID DESC;

SELECT * FROM BOARD b WHERE b.ID > 0  ORDER BY b.ID asc;

-- 실행계획
-- 1) FULL
-- 2) INDEX(RANGE SCAN)


-- JpqlMember 와 JPQL_TEAM 내부조인 : 팀명이 team2 인 멤버 조회
SELECT
	*
FROM
	JPQL_MEMBER jm
JOIN JPQL_TEAM jt ON
	jm.TEAM_ID = jt.ID
	AND 
	jt.NAME = 'team2';

SELECT
	*
FROM
	JPQL_MEMBER jm
JOIN JPQL_TEAM jt ON
	jm.TEAM_ID = jt.ID
WHERE 
	jt.NAME = 'team2';


-- mart_orders, mart_member, mart_order_item 조인
SELECT
	*
FROM
	MART_ORDERS mo
JOIN MART_MEMBER mm ON
	mo.MEMBER_MEMBER_ID = mm.MEMBER_ID
LEFT JOIN MART_ORDER_ITEM moi ON
	mo.ORDER_ID = moi.ORDER_ORDER_ID;

-- 주문번호에 따른 주문상품의 개수 추출
SELECT moi.ORDER_ORDER_ID, COUNT(moi.ORDER_ORDER_ID) AS cnt, SUM(moi.COUNT) AS sum FROM MART_ORDER_ITEM moi GROUP BY moi.ORDER_ORDER_ID;

-- 서브쿼리
-- 1) from에 서브쿼리 사용(인라인뷰)
-- 2) where에 서브쿼리 사용(중첩 서브쿼리)
-- 3) select에 서브쿼리 사용(스칼라)
-- 주문내역 + 주문아이템
SELECT
	mo.ORDER_ID, mo.STATUS, A.cnt, A.sum
FROM
	MART_ORDERS mo
LEFT JOIN (
	SELECT
		moi.ORDER_ORDER_ID AS ooi,
		COUNT(moi.ORDER_ORDER_ID) AS cnt,
		SUM(moi.COUNT) AS sum
	FROM
		MART_ORDER_ITEM moi
	GROUP BY
		moi.ORDER_ORDER_ID) A ON
	mo.ORDER_ID = A.ooi;

SELECT
	mo.ORDER_ID,
	mo.STATUS,
	(
	SELECT
		COUNT(moi.ORDER_ORDER_ID)
	FROM
		MART_ORDER_ITEM moi
	WHERE
		mo.ORDER_ID = moi.ORDER_ORDER_ID
	GROUP BY
		moi.ORDER_ORDER_ID) AS cnt
FROM
	MART_ORDERS mo
JOIN MART_MEMBER mm ON
	mo.MEMBER_MEMBER_ID
	AND mm.MEMBER_ID;


SELECT * FROM BOARD b;

-- 100번 게시물에 달린 댓글 가져오기
-- board 정보, reply 추출
SELECT * FROM BOARD b JOIN REPLY r ON b.BNO = r.BOARD_BNO WHERE b.BNO = 100;

-- 게시물 + 게시물의 댓글 수
SELECT
	b.BNO,
	b.TITLE,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REPLY r
	WHERE
		r.BOARD_BNO = b.BNO) AS RCNT,
	b.WRITER_EMAIL,
	b.REGDATE
FROM
	BOARD b;

-- 게시물 + 게시물의 댓글 수 + 게시물 작성자 이름
SELECT
	b.BNO,
	b.TITLE,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REPLY r
	WHERE
		r.BOARD_BNO = b.BNO) AS RCNT,
	b.WRITER_EMAIL,
	b.REGDATE,
	m.NAME
FROM
	BOARD b JOIN "MEMBER" m ON b.WRITER_EMAIL = m.EMAIL;

SELECT
	r.BOARD_BNO,
	COUNT(r.RNO)
FROM
	REPLY r
GROUP BY
	r.BOARD_BNO;

DELETE FROM BOARD b WHERE b.bno = 100;



















