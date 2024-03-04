PROMPT ====================================================
PROMPT CREATE TABLE CMS_OPERATION_USERS
PROMPT ====================================================

PROMPT TABLE CMS_OPERATION_USERS
CREATE TABLE CMS_OPERATION_USERS(
   ID                 VARCHAR2(50) NOT NULL
  ,SEQ                NUMBER(38, 0)
  ,OP_ID              VARCHAR2(50)
  ,USER_ID            VARCHAR2(50)
  ,DEBUG_MODE         VARCHAR2(3)    DEFAULT 'NO' NOT NULL
  ,CREATE_DATE        DATE           DEFAULT SYSDATE
)
/

PROMPT ====================================================
PROMPT CREATE COMMENTS
PROMPT ====================================================

PROMPT ====================================================
PROMPT ALTER TABLE CMS_OPERATION_USERS
PROMPT ====================================================

ALTER TABLE CMS_OPERATION_USERS ADD ID VARCHAR2(50) NOT NULL
/
ALTER TABLE CMS_OPERATION_USERS ADD SEQ NUMBER(38, 0)
/
ALTER TABLE CMS_OPERATION_USERS ADD OP_ID VARCHAR2(50)
/
ALTER TABLE CMS_OPERATION_USERS ADD USER_ID VARCHAR2(50)
/
ALTER TABLE CMS_OPERATION_USERS ADD DEBUG_MODE VARCHAR2(3) DEFAULT 'No' NOT NULL
/
ALTER TABLE CMS_OPERATION_USERS ADD CREATE_DATE DATE DEFAULT SYSDATE
/

PROMPT ====================================================
PROMPT INDEXES
PROMPT ====================================================

PROMPT INDEX OPUSER_OP_ID_IDX
CREATE INDEX OPUSER_OP_ID_IDX
  ON CMS_OPERATION_USERS(
    OP_ID
  )
/ 

PROMPT INDEX OPUSER_PK
CREATE UNIQUE INDEX OPUSER_PK
  ON CMS_OPERATION_USERS(
    ID
  )
/ 

PROMPT INDEX OPUSER_USER_ID_IDX
CREATE INDEX OPUSER_USER_ID_IDX
  ON CMS_OPERATION_USERS(
    USER_ID
  )
/

PROMPT ====================================================
PROMPT CONSTRINTS 
PROMPT ====================================================

PROMPT CONSTRINT OPUSER_PK
ALTER TABLE CMS_OPERATION_USERS
  ADD CONSTRAINT OPUSER_PK PRIMARY KEY (
    ID
  )
/ 

PROMPT CONSTRINT OPUSER_OP_FK
ALTER TABLE CMS_OPERATION_USERS
  ADD CONSTRAINT OPUSER_OP_FK FOREIGN KEY (
    OP_ID
  ) REFERENCES CMS_OPERATIONS(
    ID
  )
/ 

PROMPT ====================================================
PROMPT SEQUENCES 
PROMPT ===================================================

PROMPT SEQUENCE OPUSER
CREATE SEQUENCE OPUSER_SEQ
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE
/ 

COMMIT;
