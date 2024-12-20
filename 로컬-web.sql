-- 회원가입 페이지 구현

-- 회원가입 테이블 생성
DROP TABLE SIGNUP;
CREATE TABLE SIGNUP (
    ID VARCHAR2(12) ,                         -- 아이디 (4~12자의 영문 대소문자와 숫자)
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    NAME VARCHAR2(50) NOT NULL,               -- 이름
    BIRTH VARCHAR2(10),                       -- 생년월일 (20240101)
    PHONE1 VARCHAR2(3) NOT NULL,              -- 전화번호 
    PHONE2 VARCHAR2(4) NOT NULL,
    PHONE3 VARCHAR2(4) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,              -- 이메일 주소
    ZIPCODE VARCHAR2(7) NOT NULL,             -- 우편번호
    ADDRESS1 VARCHAR2(120) NOT NULL,          -- 주소
    ADDRESS2 VARCHAR2(50) NOT NULL            -- 상세주소
);

ALTER TABLE SIGNUP ADD CONSTRAINT SIGNUP_ID_PK PRIMARY KEY(ID);

SELECT BIRTH FROM SIGNUP WHERE ID = 'aaa123';

-- 주소정보테이블
CREATE TABLE ZIPCODE (
    SEQ NUMBER(10),
    ZIPCODE VARCHAR2(50),
    SIDO VARCHAR2(50),
    GUGUN VARCHAR2(50),
    DONG VARCHAR2(50),
    BUNJI VARCHAR2(100)
);

ALTER TABLE ZIPCODE ADD CONSTRAINT ZIPCODE_SEQ_PK PRIMARY KEY(SEQ);

SELECT * FROM ZIPCODE;

SELECT * FROM ZIPCODE WHERE DONG LIKE '권선%';

SELECT PHONE1, PHONE2, PHONE3 FROM SIGNUP WHERE ID = 'aaa123';

-- 게시판 테이블
DROP TABLE BOARD;
CREATE TABLE BOARD (
    NUM         NUMBER(7,0) NOT NULL, 
    WRITER      VARCHAR2(12) NOT NULL,   
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL, 
    PASS        VARCHAR2(10) NOT NULL, 
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    "REF"       NUMBER(5,0) DEFAULT 0, 
    STEP        NUMBER(3,0) DEFAULT 0, 
    "DEPTH"     NUMBER(3,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL, 
    IP          VARCHAR2(20) NOT NULL
);

ALTER TABLE BOARD ADD CONSTRAINT BOARD_NUM_PK PRIMARY KEY(NUM);

select * from board where num = 1;

update board set readcount=readcount+1 where num = 1;
commit;

SELECT * FROM BOARD;

CREATE SEQUENCE BOARD_SEQ   
 START          WITH 1      -- 시작을 1로 설정
 INCREMENT      BY 1        -- 증가값을 1씩 증가
 NOMAXVALUE                 -- 최대값이 무한대..
 NOCACHE
 NOCYCLE;
 
SELECT * FROM BOARD;

SELECT COUNT(*) AS COUNT FROM BOARD;
 
 
 
-- 공지사항 테이블 
CREATE TABLE NOTICE (
    NUM         NUMBER(7,0) NOT NULL, 
    WRITER      VARCHAR2(12) NOT NULL,   
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL, 
    PASS        VARCHAR2(10) NOT NULL, 
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    "REF"       NUMBER(5,0) DEFAULT 0, 
    STEP        NUMBER(3,0) DEFAULT 0, 
    "DEPTH"     NUMBER(3,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL, 
    IP          VARCHAR2(20) NOT NULL
);

ALTER TABLE NOTICE ADD CONSTRAINT NOTICE_NUM_PK PRIMARY KEY(NUM);

SELECT * FROM NOTICE WHERE NUM = 1;

UPDATE NOTICE SET READCOUNT = READCOUNT + 1 WHERE NUM = 1;
COMMIT;

SELECT * FROM NOTICE;

CREATE SEQUENCE NOTICE_SEQ   
 START          WITH 1       -- 시작을 1로 설정
 INCREMENT      BY 1         -- 증가값을 1씩 증가
 NOMAXVALUE                  -- 최대값이 무한대
 NOCACHE
 NOCYCLE;

SELECT * FROM NOTICE;

SELECT COUNT(*) AS COUNT FROM NOTICE;


-- 자유게시판테이블
CREATE TABLE FREEBOARD (
    NUM         NUMBER(7,0) NOT NULL, 
    WRITER      VARCHAR2(12) NOT NULL,   
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL, 
    PASS        VARCHAR2(10) NOT NULL, 
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    "REF"       NUMBER(5,0) DEFAULT 0, 
    STEP        NUMBER(3,0) DEFAULT 0, 
    "DEPTH"     NUMBER(3,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL, 
    IP          VARCHAR2(20) NOT NULL
);

-- 기본키 제약조건 추가
ALTER TABLE FREEBOARD ADD CONSTRAINT FREEBOARD_NUM_PK PRIMARY KEY(NUM);

-- 자유게시판 시퀀스 생성
CREATE SEQUENCE FREEBOARD_SEQ   
 START          WITH 1       -- 시작을 1로 설정
 INCREMENT      BY 1         -- 증가값을 1씩 증가
 NOMAXVALUE                  -- 최대값이 무한대
 NOCACHE
 NOCYCLE;

-- 데이터 조회 예시
SELECT * FROM FREEBOARD WHERE NUM = 1;

-- 조회수 증가 예시
UPDATE FREEBOARD SET READCOUNT = READCOUNT + 1 WHERE NUM = 1;
COMMIT;

-- 전체 데이터 조회
SELECT * FROM FREEBOARD;

-- 전체 개수 확인
SELECT COUNT(*) AS COUNT FROM FREEBOARD;

CREATE TABLE FREEBOARDCOMMENT (
    COMMENTID   NUMBER(10) PRIMARY KEY,   -- 댓글 ID
    BOARDNUM    NUMBER(10),               -- 게시글 번호 (외래 키)
    WRITER       VARCHAR2(50),             -- 댓글 작성자
    CONTENT      VARCHAR2(1000),           -- 댓글 내용
    REGDATE      TIMESTAMP DEFAULT SYSDATE -- 댓글 작성 시간
);

ALTER TABLE FREEBOARDCOMMENT 
ADD CONSTRAINT FK_BOARD_COMMENT FOREIGN KEY (BOARDNUM) REFERENCES FREEBOARD(NUM);


CREATE SEQUENCE FREEBOARDCOMMENT_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE;

CREATE TABLE Product (
    bookID VARCHAR2(50) PRIMARY KEY, -- 도서 ID
    bookName VARCHAR2(100) NOT NULL, -- 도서명
    unitPrice NUMBER(10) NOT NULL, -- 가격
    description CLOB, -- 상세 설명
    author VARCHAR2(100), -- 저자
    publisher VARCHAR2(100), -- 출판사
    category VARCHAR2(50), -- 카테고리
    filename VARCHAR2(255), -- 파일 이름
    unitsInStock NUMBER(10), -- 재고 수량
    productCondition VARCHAR2(10) CHECK (productCondition IN ('New', 'Old', 'E-Book')) -- 상태 제한
);

INSERT INTO Product (bookID, bookName, unitPrice, description, author, publisher, category, filename, unitsInStock, productCondition) 
VALUES ('P001', 'Sample Book', 10000, 'This is a sample book description.', 'John Doe', 'Sample Publisher', 'Fiction', 'sample.jpg', 100, 'New');
commit;

SELECT * FROM Product;


