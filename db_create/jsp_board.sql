-- DBA 계정에서 실행
create user JSPBOARD IDENTIFIED BY jspboard 
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
PROFILE DEFAULT;

GRANT CONNECT, RESOURCE TO JSPBOARD;
ALTER USER JSPBOARD ACCOUNT UNLOCK;

--JSPBOARD 계정에서 실행

--유저
CREATE TABLE USERS(
    USER_ID     VARCHAR(20) PRIMARY KEY,
    USER_PW     VARCHAR(20),
    USER_NAME   VARCHAR(20),
    USER_GENDER VARCHAR(20),
    USER_EMAIL  VARCHAR(50)
);


CREATE TABLE POSTS(
    POST_ID INT PRIMARY  KEY,
    TITLE VARCHAR(50),
    USER_ID VARCHAR(20) REFERENCES USERS(USER_ID),
    WIRTE_DATE DATE,
    CONTENT VARCHAR(2048),
    POST_AVAILABLE INT
);

CREATE SEQUENCE POST_ID_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 2147483647 CYCLE NOCACHE;