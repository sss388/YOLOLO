-- sys DB부터 만들기
CREATE USER YOLO IDENTIFIED BY YOLO;
GRANT RESOURCE, CONNECT TO YOLO;

-- 회원정보(YOLO_MEMBER)
CREATE TABLE YOLO_MEMBER (
	NO NUMBER PRIMARY KEY,   -- 회원번호 . 기본키
	ID  VARCHAR2(16)  NOT NULL UNIQUE,  -- 아이디
	PASSWORD VARCHAR2(100) NOT NULL,  -- 비밀번호
	NAME VARCHAR2(16) NOT NULL,  -- 이름
	PCODE VARCHAR2(16) NOT NULL,  -- 우편번호
	ADDRESS1 VARCHAR2(100) NOT NULL,  -- 기본주소
	ADDRESS2 VARCHAR2(100) NOT NULL,  -- 나머지주소
 	PHONE VARCHAR2(15) NOT NULL,  -- 휴대전화
	EMAIL VARCHAR2(30) NOT NULL UNIQUE,  -- 이메일
	STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')), -- 상태값
 	CREATE_DATE DATE DEFAULT SYSDATE, -- 회원가입일
	UPDATE_DATE DATE DEFAULT SYSDATE,  -- 최종수정일
	ROLE NUMBER	 NULL  -- 권한(역할)
);

COMMENT ON COLUMN YOLO_MEMBER.NO  IS '회원번호';
COMMENT ON COLUMN YOLO_MEMBER.ID  IS '아이디';
COMMENT ON COLUMN YOLO_MEMBER.PASSWORD  IS '비밀번호';
COMMENT ON COLUMN YOLO_MEMBER.NAME  IS '이름';
COMMENT ON COLUMN YOLO_MEMBER.PCODE  IS '우편번호';
COMMENT ON COLUMN YOLO_MEMBER.ADDRESS1  IS '기본주소';
COMMENT ON COLUMN YOLO_MEMBER.ADDRESS2  IS '나머지주소 ';
COMMENT ON COLUMN YOLO_MEMBER.PHONE  IS '휴대전화';
COMMENT ON COLUMN YOLO_MEMBER.EMAIL  IS '이메일';
COMMENT ON COLUMN YOLO_MEMBER.STATUS  IS '상태값';
COMMENT ON COLUMN YOLO_MEMBER.CREATE_DATE  IS '회원가입일';
COMMENT ON COLUMN YOLO_MEMBER.UPDATE_DATE  IS '최종수정일';
COMMENT ON COLUMN YOLO_MEMBER.ROLE  IS '권한(역할)';


-- 시퀀스 생성(YOLO_MEMBER_SEQ)
CREATE SEQUENCE YOLO_MEMBER_SEQ
    START WITH 1  -- 시작값 1
    INCREMENT BY 1 -- 1씩 증가하도록
    NOMAXVALUE; -- 최대값 제한 없음

-- 회원 추가
-- INSERT INTO YOLO_PROGRAM (NO, USER_NO, TITLE, THUMB, CATEGORY, CONTENT, ADDRESS, LATITUDE, LONGITUDE, INCLUSION, NONINCLUSION, SUPPLIES, STATUS, CREATE_DATE, START_DATE, EXPIRE_DATE, WRITER_NAME) VALUES (YOLO_PROGRAM_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,'Y',SYSDATE,?,?,?);

-- 회원 수정
-- UPDATE YOLO_PROGRAM SET TITLE=?, CONTENT=?, THUMB=?, CATEGORY=?, START_DATE=?, EXPIRE_DATE=?,ADDRESS=?, LATITUDE=?, LONGITUDE=?, INCLUSION=?, NONINCLUSION=?, SUPPLIES=? WHERE NO=?

-- 테이블, 시퀀스 삭제
-- DROP TABLE YOLO_MEMBER;
-- DROP SEQUENCE YOLO_MEMBER_SEQ;     

 
-- 프로그램(YOLO_PROGRAM)
CREATE TABLE YOLO_PROGRAM (
    NO NUMBER PRIMARY KEY,                   -- 프로그램 번호
    USER_NO NUMBER NOT NULL,                 -- 회원 번호 (외래키 YOLO_MEMBER)
    WRITER_NAME VARCHAR2(16) NOT NULL,       -- 작성자                                        
    TITLE VARCHAR2(40) NOT NULL,             -- 모임명
    THUMB VARCHAR2(500),                     -- 썸네일(대표이미지)
    CATEGORY VARCHAR2(30),                   -- 카테고리
    CONTENT CLOB,                            -- 내용
    ADDRESS VARCHAR2(500),                   -- 주소
    LATITUDE NUMBER,                         -- 위도
    LONGITUDE NUMBER ,                       -- 경도
    INCLUSION VARCHAR2(500),                 -- 포함사항  
    NONINCLUSION VARCHAR2(500),	             -- 불포함사항
    SUPPLIES VARCHAR2(500),                  -- 준비물 
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),  -- 상태값 (Y,N)
    CREATE_DATE DATE DEFAULT SYSDATE,                            -- 날짜(작성일)
    START_DATE DATE DEFAULT SYSDATE,                             -- 날짜(시작일)
    EXPIRE_DATE DATE DEFAULT SYSDATE                             -- 날짜(만료일)
);

COMMENT ON COLUMN YOLO_PROGRAM.NO  IS '프로그램 번호';
COMMENT ON COLUMN YOLO_PROGRAM.USER_NO  IS '회원 번호';
COMMENT ON COLUMN YOLO_PROGRAM.WRITER_NAME  IS '작성자';
COMMENT ON COLUMN YOLO_PROGRAM.TITLE  IS '모임명';
COMMENT ON COLUMN YOLO_PROGRAM.THUMB  IS '썸네일';
COMMENT ON COLUMN YOLO_PROGRAM.CATEGORY  IS '카테고리';
COMMENT ON COLUMN YOLO_PROGRAM.CONTENT  IS '내용';
COMMENT ON COLUMN YOLO_PROGRAM.ADDRESS  IS '주소';
COMMENT ON COLUMN YOLO_PROGRAM.LATITUDE  IS '위도';
COMMENT ON COLUMN YOLO_PROGRAM.LONGITUDE  IS '경도';
COMMENT ON COLUMN YOLO_PROGRAM.INCLUSION  IS '포함사항';
COMMENT ON COLUMN YOLO_PROGRAM.NONINCLUSION  IS '불포함사항';
COMMENT ON COLUMN YOLO_PROGRAM.SUPPLIES  IS '준비물';
COMMENT ON COLUMN YOLO_PROGRAM.STATUS  IS '상태값';
COMMENT ON COLUMN YOLO_PROGRAM.CREATE_DATE  IS '작성일';
COMMENT ON COLUMN YOLO_PROGRAM.START_DATE  IS '시작일';
COMMENT ON COLUMN YOLO_PROGRAM.EXPIRE_DATE  IS '만료일';

-- YOLO_MEMBER에서 회원 번호 외래키로 가져옴
ALTER TABLE YOLO_PROGRAM 
ADD CONSTRAINT FK_YOLO_MEMBER_NO 
FOREIGN KEY (USER_NO) 
REFERENCES YOLO_MEMBER(NO);

-- 시퀀스
CREATE SEQUENCE YOLO_PROGRAM_SEQ
    START WITH 1  -- 시작값 1
    INCREMENT BY 1 -- 1씩 증가하도록
    NOMAXVALUE; -- 최대값 제한 없음

-- 게시글 등록
-- INSERT INTO YOLO_PROGRAM (NO, USER_NO, TITLE, THUMB, CATEGORY, CONTENT, INCLUSION, NONINCLUSION, SUPPLIES, STATUS, CREATE_DATE, START_DATE, EXPIRE_DATE, WRITER_NAME) VALUES (YOLO_PROGRAM_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,'Y',SYSDATE,?,?,?);

-- 게시글 수정
-- UPDATE YOLO_PROGRAM SET TITLE=?, CONTENT=?, THUMB=?, CATEGORY=?, START_DATE=?, EXPIRE_DATE=?, INCLUSION=?, NONINCLUSION=?, SUPPLIES=? WHERE NO=?;
    
-- 테이블, 시퀀스 삭제
-- DROP TABLE YOLO_PROGRAM;
-- DROP SEQUENCE YOLO_PROGRAM_SEQ;       



-- 게시판
CREATE TABLE YOLO_BOARD (
	"NO"	        NUMBER(20)		    PRIMARY KEY,
	"TITLE"	        VARCHAR2(30)		,
	"CONTENT"	    CLOB        	    ,
	"KIND"	        NUMBER(2)		    ,    
	"USER_NO"	    NUMBER		        REFERENCES YOLO_MEMBER(NO),
    "STATUS"         VARCHAR2(1)         DEFAULT 'Y',
    "CREATE_DATE"	DATE		        DEFAULT SYSDATE,
	"UPDATE_DATE"	DATE		        DEFAULT SYSDATE,

);

COMMENT ON COLUMN YOLO_BOARD.NO  IS '글번호';
COMMENT ON COLUMN YOLO_BOARD.TITLE IS '글제목';
COMMENT ON COLUMN YOLO_BOARD.CONTENT IS '글내용';
COMMENT ON COLUMN YOLO_BOARD.CREATE_DATE IS '생성일';
COMMENT ON COLUMN YOLO_BOARD.UPDATE_DATE IS '수정일';
COMMENT ON COLUMN YOLO_BOARD.KIND IS '글종류';
COMMENT ON COLUMN YOLO_BOARD.STATUS IS '상태';
COMMENT ON COLUMN YOLO_BOARD.USER_NO IS '작성자 번호';

CREATE SEQUENCE YOLO_BOARD_NO;

INSERT INTO YOLO_BOARD (NO, TITLE, CONTENT, KIND, USER_NO, THUMB)
VALUES (YOLO_BOARD_NO.NEXTVAL, 'aaaa', '<p>내용</p>', 5, 24, '썸네일');

DROP TABLE YOLO_BOARD;
DROP SEQUENCE YOLO_BOARD_NO;

 

-- 문의하기 QNA 
-- QNABOARD 테이블 확인 --
CREATE TABLE YOLO_QNABOARD (   
    NO NUMBER,
    WRITER_NO NUMBER,
    TITLE VARCHAR2(50),
    CONTENT CLOB,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
    CREATE_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    REPLY VARCHAR2(1) DEFAULT 'N' CHECK (REPLY IN ('Y', 'N')),
    CONSTRAINT PK_YOLO_QNABOARD_NO PRIMARY KEY(NO),
    CONSTRAINT FK_YOLO_QNABOARD_WRITER FOREIGN KEY(WRITER_NO) REFERENCES YOLO_MEMBER(NO) ON DELETE SET NULL
);

-- QNABOARD 컬럼명
COMMENT ON COLUMN YOLO_QNABOARD.NO IS '게시글번호';
COMMENT ON COLUMN YOLO_QNABOARD.WRITER_NO IS '게시글작성자';
COMMENT ON COLUMN YOLO_QNABOARD.TITLE IS '게시글제목';
COMMENT ON COLUMN YOLO_QNABOARD.CONTENT IS '게시글내용';
COMMENT ON COLUMN YOLO_QNABOARD.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN YOLO_QNABOARD.CREATE_DATE IS '게시글올린날짜';
COMMENT ON COLUMN YOLO_QNABOARD.MODIFY_DATE IS '게시글수정날짜';
COMMENT ON COLUMN YOLO_QNABOARD.REPLY IS '답변여부';

--  시퀀스 생성
CREATE SEQUENCE YOLO_QNABOARD_SEQ;    

-- 테이블, 시퀀스 삭제
DROP TABLE YOLO_QNABOARD;
DROP SEQUENCE YOLO_QNABOARD_SEQ; 

 

-- 문의하기 답변 테이블
CREATE TABLE YOLO_QNA_REPLY (
	NO	            NUMBER PRIMARY KEY,
	CONTENT	       CLOB,
	CREATE_DATE	    DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN YOLO_QNA_REPLY.NO  IS '문의글번호';
COMMENT ON COLUMN YOLO_QNA_REPLY.CONTENT IS '답변내용';
COMMENT ON COLUMN YOLO_QNA_REPLY.CREATE_DATE IS '답변작성일';

 

--공지사항
CREATE TABLE YOLO_COMMON (  
    NO NUMBER,
    WRITER_NO NUMBER,
    TITLE VARCHAR2(50),
    CONTENT VARCHAR2(2000),
    ORIGINAL_FILENAME VARCHAR2(100),
    RENAMED_FILENAME VARCHAR2(100),
    READCOUNT NUMBER DEFAULT 0,
    CREATE_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT PK_YOLO_COMMON_NO PRIMARY KEY(NO),
    CONSTRAINT FK_YOLO_COMMON_WRITER FOREIGN KEY(WRITER_NO) REFERENCES YOLO_MEMBER(NO) ON DELETE SET NULL
);

COMMENT ON COLUMN YOLO_COMMON.NO IS '게시글번호';
COMMENT ON COLUMN YOLO_COMMON.TITLE IS '게시글제목';
COMMENT ON COLUMN YOLO_COMMON.CONTENT IS '게시글내용';
COMMENT ON COLUMN YOLO_COMMON.WRITER_NO IS '게시글작성자';
COMMENT ON COLUMN YOLO_COMMON.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN YOLO_COMMON.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN YOLO_COMMON.READCOUNT IS '조회수';
COMMENT ON COLUMN YOLO_COMMON.CREATE_DATE IS '게시글올린날짜;

CREATE SEQUENCE SEQ_YOLO_COMMON_NO;

INSERT INTO YOLO_COMMON VALUES(SEQ_YOLO_COMMON.NEXTVAL, 1, '공지사항', '공지사항입니다~~~~~', '원본파일명.txt', '변경된파일명.txt', DEFAULT, SYSDATE);

COMMIT;



