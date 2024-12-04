-- movie, review join
-- movie: mno, title, regDate
-- review: review 수, 평균

SELECT
	m.*, AVG(r.GRADE), COUNT(r.RNO) 
FROM
	MOVIE m
LEFT JOIN REVIEW r ON
	m.MNO = r.MOVIE_MNO GROUP BY m.MNO;

SELECT
	m.MNO,
	m.TITLE,
	cnt,
	avg,
	m.REG_DATE
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		r.MOVIE_MNO,
		COUNT(r.RNO) AS cnt,
		ROUND(AVG(r.GRADE), 1) AS avg
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MNO) r2 ON
	m.MNO = r2.MOVIE_MNO;


-- movie, review subquery
SELECT
	m.*,
	(
	SELECT
		AVG(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS AVG,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS CNT
FROM
	MOVIE m


-- movie, review, movie_image join or subquery
-- movie: mno, title, regDate
-- review: review 수, 평균
-- movie_image: inum, path, uuid, image_name inum 최댓값(movie_mno 기준)
	
SELECT
	m.MNO,
	m.TITLE,
	m.REG_DATE,
	(
	SELECT
		AVG(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS AVG,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS CNT, mi2.IMG_NAME, mi2.INUM, mi2."PATH", mi2.UUID
FROM
	MOVIE m
LEFT JOIN MOVIE_IMAGE mi2 ON
	m.MNO = mi2.MOVIE_MNO
WHERE
	mi2.INUM IN (
	SELECT
		MAX(mi.INUM)
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.MOVIE_MNO);
	

SELECT
	mi.MOVIE_MNO, mi.INUM, mi."PATH", mi.UUID
FROM
	MOVIE_IMAGE mi
JOIN (
	SELECT
		mi2.MOVIE_MNO,
		MAX(mi2.INUM) AS max
	FROM
		MOVIE_IMAGE mi2
	GROUP BY
		mi2.MOVIE_MNO) mi3 ON
	mi.INUM = mi3.max;

		
SELECT
	m.MNO,
	m.TITLE,
	cnt,
	avg,
	m.REG_DATE,
	mi.INUM
FROM
	MOVIE m
LEFT JOIN (
	SELECT
		r.MOVIE_MNO,
		COUNT(r.RNO) AS cnt,
		ROUND(AVG(r.GRADE), 1) AS avg
	FROM
		REVIEW r
	GROUP BY
		r.MOVIE_MNO) r2 ON
	m.MNO = r2.MOVIE_MNO LEFT JOIN (SELECT
	mi.MOVIE_MNO, mi.INUM, mi."PATH", mi.UUID
FROM
	MOVIE_IMAGE mi
JOIN (
	SELECT
		mi.MOVIE_MNO,
		MAX(mi.INUM) AS max
	FROM
		MOVIE_IMAGE mi
	GROUP BY
		mi.MOVIE_MNO) mi2 ON
	mi.INUM = mi2.max) mi ON mi.MOVIE_MNO = m.MNO;
	
	
SELECT
	m.MNO,
	m.TITLE,
	m.REG_DATE,
	(
	SELECT
		AVG(r.GRADE)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS AVG,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REVIEW r
	WHERE
		r.MOVIE_MNO = m.MNO) AS CNT,
	mi2.IMG_NAME,
	mi2.INUM,
	mi2."PATH",
	mi2.UUID
FROM
	MOVIE m
LEFT JOIN MOVIE_IMAGE mi2 ON
	m.MNO = mi2.MOVIE_MNO
WHERE
	m.MNO = 1;
	

-- 회원탈퇴(리뷰삭제, 회원탈퇴)
DELETE
FROM
	REVIEW r
WHERE
	r.member_mid = 50;

DELETE
FROM
	M_MEMBER mm
WHERE
	mm.email = 'user50@gmail.com'
	AND mm.password = '{bcrypt}$2a$10$DElK6aHtdpA1Nk5hjBufOOF9tiEy7J/VWpl.D803j/h14chAwBRcS';
	
	
SELECT * FROM MOVIE_IMAGE mi WHERE mi."PATH" = TO_CHAR(SYSDATE - 1, 'YYYY/MM/DD');
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
