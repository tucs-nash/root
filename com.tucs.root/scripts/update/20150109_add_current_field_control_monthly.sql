ALTER TABLE EN_CONTROL_MONTHLY ADD CURRENT_MONTHLY NUMBER(1,0) NOT NULL;

ALTER TABLE EN_CONTROL_MONTHLY DROP COLUMN UPDATED_USER_ID CASCADE CONSTRAINTS;