-- memo 테이블 생성
-- 메모번호(mno - pk), 메모내용(memo_text - not null)
CREATE TABLE memo(
mno number(15) PRIMARY KEY,
memo_text varchar2(200) NOT null
);

-- 메모번호는 시퀀스(memo_seq) 입력
CREATE SEQUENCE memo_seq;

DROP TABLE MEMO;
DROP SEQUENCE memo_seq;

INSERT INTO MEMO VALUES(memo_seq.nextval, '오늘의 할일');

-- 회원, 팀
-- 회원은 단 하나의 팀에 소속된다.
-- 하나의 팀에는 여러 회원이 소속된다.

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

INSERT INTO team VALUES('team1', '팀1');
INSERT INTO team VALUES('team2', '팀2');

INSERT INTO team_member VALUES('user1', '홍길동', 'team1');

-- 홍길동이 소속된 팀의 이름 조회
-- 내부조인
SELECT tm.USER_NAME , tm.TEAM_ID, t.ID, t.NAME 
FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID = t.ID; 

SELECT tm.USER_NAME, tm.TEAM_ID, t.ID, t.NAME 
FROM TEAM t JOIN TEAM_MEMBER tm ON t.ID = tm.TEAM_ID; 


-- Hibernate 외부조인(@ManyToOne)
    select
        m1_0.id,
        t1_0.id,
        t1_0.name,
        m1_0.user_name 
    from
        team_member m1_0 
    left join
        team t1_0 
            on t1_0.id=m1_0.team_id 
    where
        m1_0.id='user1';
        
       
-- 회원 조회 시 같은 팀에 소속된 회원 조회
-- 팀1
SELECT tm.USER_NAME, tm.ID, t.ID, t.NAME 
FROM TEAM t JOIN TEAM_MEMBER tm ON t.ID = tm.TEAM_ID WHERE t.NAME = '팀1';

UPDATE TEAM_MEMBER
SET TEAM_ID ='team2'
WHERE TEAM_ID = 'team1' AND id = 'user6';

-- PARENT 삭제
-- 무결성 제약조건이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM PARENT p 
WHERE p.id = 3;