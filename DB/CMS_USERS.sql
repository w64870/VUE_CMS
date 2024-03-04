PROMPT ====================================================
PROMPT CREATE TABLE CMS_USERS
PROMPT ====================================================

PROMPT TABLE CMS_USERS
CREATE TABLE CMS_USERS(
   ID                 VARCHAR2(50) NOT NULL
  ,PASSWORD           VARCHAR2(50) NOT NULL
  ,DESCRIPTION        VARCHAR2(80)
  ,CHECK_PASS         VARCHAR2(3) DEFAULT 'YES'
  ,CAN_MODIFY         VARCHAR2(3) DEFAULT 'NO'
  ,EXPIRE_DATE        DATE
)
/

PROMPT ====================================================
PROMPT CREATE COMMENTS
PROMPT ====================================================

PROMPT ====================================================
PROMPT ALTER TABLE OPERATION_CMS_USERS
PROMPT ====================================================

ALTER TABLE CMS_USERS ADD ID            VARCHAR2(50) NOT NULL
/
ALTER TABLE CMS_USERS ADD PASSWORD      VARCHAR2(50) NOT NULL
/
ALTER TABLE CMS_USERS ADD DESCRIPTION   VARCHAR2(80) NOT NULL
/
ALTER TABLE CMS_USERS ADD CHECK_PASS VARCHAR2(3) DEFAULT 'YES'
/
ALTER TABLE CMS_USERS ADD CAN_MODIFY    VARCHAR2(3) DEFAULT 'NO'
/
ALTER TABLE CMS_USERS ADD EXPIRE_DATE   DATE
/

PROMPT ====================================================
PROMPT INDEXES
PROMPT ====================================================

PROMPT INDEX USER_PK
CREATE UNIQUE INDEX USER_PK
  ON CMS_USERS(
    ID
  )
/ 

PROMPT ====================================================
PROMPT CONSTRINTS 
PROMPT ====================================================

PROMPT CONSTRINT USER_PK
ALTER TABLE CMS_USERS
  ADD CONSTRAINT USER_PK PRIMARY KEY (
    ID
  )
/ 


COMMIT;
