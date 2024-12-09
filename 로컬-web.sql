-- 회원가입 페이지 구현

-- 회원가입 테이블 생성
DROP TABLE SIGNUP;
CREATE TABLE SIGNUP (
    ID VARCHAR2(12) ,                         -- 아이디 (4~12자의 영문 대소문자와 숫자)
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    EMAIL VARCHAR2(100) NOT NULL,             -- 이메일 주소
    NAME VARCHAR2(50) NOT NULL,               -- 이름
    BIRTH NUMBER(10)                          -- 생년월일 (20001010)
);

ALTER TABLE SIGNUP ADD CONSTRAINT SIGNUP_ID_PK PRIMARY KEY(ID);

SELECT * FROM SIGNUP;
