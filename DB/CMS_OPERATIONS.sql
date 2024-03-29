PROMPT ====================================================
PROMPT CREATE TABLE CMS_OPERATIONS
PROMPT ====================================================

PROMPT TABLE CMS_OPERATIONS
CREATE TABLE CMS_OPERATIONS (
   ID                VARCHAR2(50)   NOT NULL
  ,SEQ               NUMBER(38,0)
  ,ORDINAL           NUMBER(38,0)
  ,NAME              VARCHAR2(60)   UNIQUE
  ,DESCRIPTION       VARCHAR2(80)
  ,VERSION           VARCHAR2(50)
  ,COMMENTS          VARCHAR2(2000)
  ,STATE_ID          VARCHAR2(10)   DEFAULT 'ACTIVE'    NOT NULL
  ,CREATE_DATE       DATE           DEFAULT SYSDATE
  ,CREATED_BY        VARCHAR2(50)
  ,MODIFY_DATE       DATE           DEFAULT SYSDATE
  ,MODIFIED_BY       VARCHAR2(50)
)
/

PROMPT ====================================================
PROMPT CREATE COMMENTS
PROMPT ====================================================

PROMPT ====================================================
PROMPT ALTER TABLE CMS_OPERATIONS
PROMPT ====================================================

ALTER TABLE CMS_OPERATIONS ADD ID VARCHAR2(50) NOT NULL
/
ALTER TABLE CMS_OPERATIONS ADD SEQ NUMBER(38,0)
/
ALTER TABLE CMS_OPERATIONS ADD ORDINAL NUMBER(38,0)
/
ALTER TABLE CMS_OPERATIONS ADD NAME VARCHAR2(60) UNIQUE
/
ALTER TABLE CMS_OPERATIONS ADD DESCRIPTION VARCHAR2(80)
/
ALTER TABLE CMS_OPERATIONS ADD COMMENTS VARCHAR2(2000)
/
ALTER TABLE CMS_OPERATIONS ADD VERSION VARCHAR2(50)
/
ALTER TABLE CMS_OPERATIONS ADD STATE_ID VARCHAR2(10) DEFAULT 'ACTIVE' NOT NULL
/
ALTER TABLE CMS_OPERATIONS ADD CREATE_DATE DATE DEFAULT SYSDATE
/
ALTER TABLE CMS_OPERATIONS ADD CREATED_BY VARCHAR2(50)
/
ALTER TABLE CMS_OPERATIONS ADD MODIFY_DATE DATE DEFAULT SYSDATE
/
ALTER TABLE CMS_OPERATIONS ADD MODIFIED_BY VARCHAR2(50)
/

PROMPT ====================================================
PROMPT INDEXES
PROMPT ====================================================

PROMPT INDEX OP_PK
CREATE UNIQUE INDEX OP_PK
  ON CMS_OPERATIONS(
    ID
  )
/

PROMPT INDEX OP_state_idX
CREATE INDEX OP_state_idX
  ON CMS_OPERATIONS(
    STATE_ID
  )
/

PROMPT ====================================================
PROMPT CONSTRINTS
PROMPT ====================================================


PROMPT CONSTRINT OP_PK
ALTER TABLE CMS_OPERATIONS
  ADD CONSTRAINT OP_PK PRIMARY KEY (
    ID
  )
/

PROMPT CONSTRINT OP_STATE_FK
ALTER TABLE CMS_OPERATIONS
  ADD CONSTRAINT OP_STATE_FK FOREIGN KEY (
    STATE_ID
  ) REFERENCES STATES(
    ID
  )
/


PROMPT ====================================================
PROMPT SEQUENCES
PROMPT ===================================================

PROMPT SEQUENCE OP
CREATE SEQUENCE OP_SEQ
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE
/

COMMIT;
