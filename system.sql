-- 사용자 생성 시 특정 문자열로 시작하는 user 생성을 안하겠음
-- hr(c##hr)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; 


-- scott에게 뷰 권한 부여
GRANT CREATE VIEW TO scott;