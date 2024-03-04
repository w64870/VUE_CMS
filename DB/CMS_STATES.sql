PROMPT ====================================================
PROMPT CREATE TABLE CMS_STATES
PROMPT ====================================================

PROMPT TABLE CMS_STATES
CREATE TABLE CMS_STATES(
   ID                VARCHAR2(50) NOT NULL
  ,DESCRIPTION       VARCHAR2(80)
  ,CREATE_DATE       DATE         DEFAULT SYSDATE
)
/

PROMPT ====================================================
PROMPT CREATE COMMENTS
PROMPT ====================================================

PROMPT ====================================================
PROMPT ALTER TABLE CMS_STATES
PROMPT ====================================================

ALTER TABLE CMS_STATES ADD ID VARCHAR2(50) NOT NULL
/
ALTER TABLE CMS_STATES ADD DESCRIPTION VARCHAR2(80)
/
ALTER TABLE CMS_STATES ADD CREATE_DATE DATE DEFAULT SYSDATE

PROMPT ====================================================
PROMPT INDEXES
PROMPT ====================================================

PROMPT INDEX STATE_PK
CREATE UNIQUE INDEX STATE_PK
  ON CMS_STATES(
    ID
  )
/

PROMPT ====================================================
PROMPT CONSTRINTS
PROMPT ====================================================


PROMPT CONSTRINT STATE_PK
ALTER TABLE CMS_STATES
  ADD CONSTRAINT STATE_PK PRIMARY KEY (
    ID
  )
/

PROMPT ====================================================
PROMPT INSERTS
PROMPT ====================================================

INSERT INTO CMS_STATES(ID, DESCRIPTION) VALUES('ACTIVE', 'ACTIVE');
INSERT INTO CMS_STATES(ID, DESCRIPTION) VALUES('DISABLED', 'DISABLED');

COMMIT;
