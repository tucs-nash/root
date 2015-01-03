/***************************************DROPS*************************************/
drop sequence JN_PROFILE_PRIV_SQ;
drop sequence EN_USER_SQ;
drop sequence EN_PARTICIPANT_SQ;
drop sequence EN_GROUP_SQ;
drop sequence EN_CONTROL_SQ;
drop sequence EN_CONTROL_MONTHLY_SQ;
drop sequence EN_TRANSACTION_SQ;
drop sequence EN_CATEGORY_SQ;
drop sequence RP_CLOSING_MONTHLY_SQ;
drop sequence EN_SAVINGS_SQ;

drop table TY_CURRENCY cascade constraints;
drop table TY_PRIVILEGE cascade constraints;
drop table TY_PROFILE cascade constraints;
drop table JN_PROFILE_PRIV cascade constraints;
drop table EN_USER cascade constraints;
drop table EN_PARTICIPANT cascade constraints;
drop table EN_GROUP cascade constraints;
drop table EN_CONTROL cascade constraints;
drop table EN_CONTROL_MONTHLY cascade constraints;
drop table EN_CATEGORY cascade constraints;
drop table EN_TRANSACTION cascade constraints;
drop table RP_CLOSING_MONTHLY cascade constraints;
drop table EN_SAVINGS cascade constraints;
/***************************************CREATES*************************************/
CREATE TABLE TY_CURRENCY (	
    ID NUMBER(*,0) NOT NULL, 
	CODE VARCHAR2(20) NOT NULL , 
	NAME VARCHAR2(50) NOT NULL , 
	SYMBOL VARCHAR2(10), 
	SYMBOL_BEFORE NUMBER(1,0) NOT NULL ,
	ACTIVE NUMBER(1,0) NOT NULL , 
  PRIMARY KEY (ID)
);  

CREATE TABLE TY_PRIVILEGE (	
  	ID NUMBER(*,0) NOT NULL, 
	NAME VARCHAR2(50) NOT NULL , 
	CODE VARCHAR2(20), 
	DELETED NUMBER(1,0) DEFAULT 0, 
	DESCRIPTION VARCHAR2(255),
  primary key (ID)
);

CREATE TABLE TY_PROFILE (	
  	ID NUMBER(*,0) NOT NULL, 
	NAME VARCHAR2(50) NOT NULL , 
	CODE VARCHAR2(20), 
	DELETED NUMBER(1,0) DEFAULT 0, 
	DESCRIPTION VARCHAR2(255),
  primary key (ID)
);

CREATE TABLE JN_PROFILE_PRIV (	
  	ID NUMBER(*,0) NOT NULL, 
  	PROFILE_ID		NUMBER(*,0) NOT NULL,
  	PRIVILEGE_ID	NUMBER(*,0) NOT NULL,
  	CREATED_DATE	TIMESTAMP(6) NOT NULL,
  primary key (ID)
);

create table EN_USER (
  	ID VARCHAR2(255) NOT NULL, 
	FIRSTNAME VARCHAR2(255 BYTE) NOT NULL , 
  	LASTNAME VARCHAR2(255 BYTE) NOT NULL , 
  	EMAIL VARCHAR2(50 BYTE) NOT NULL , 
  	PASSWORD VARCHAR2(255 BYTE) NOT NULL , 
  	TYPE_USER NUMBER(2,0) NOT NULL,
  	PHONE VARCHAR2(20 BYTE), 
	CREATED_DATE TIMESTAMP (6) NOT NULL , 
	UPDATED_DATE TIMESTAMP (6), 
	DELETED NUMBER(1,0) DEFAULT 0 NOT NULL , 
	FORGOT_PASSWORD NUMBER(1,0) DEFAULT 0 NOT NULL , 
	LANGUAGE VARCHAR(10),
  primary key (ID)
);

create table EN_PARTICIPANT (
  	ID VARCHAR2(255) NOT NULL,
  	USER_ID VARCHAR2(255) NOT NULL,
  	GROUP_ID VARCHAR2(255) NOT NULL,
  	PROFILE_ID NUMBER(*,0) NOT NULL,
  	DELETED NUMBER(1,0) DEFAULT 0 NOT NULL,
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
  	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
  	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_GROUP (
	ID VARCHAR2(255) NOT NULL,
	NAME VARCHAR2(50 BYTE) NOT NULL,
	DESCRIPTION VARCHAR2(100),
	AMOUNT_PARTICIPANT INT NOT NULL,
	SHARED NUMBER(1,0) NOT NULL,
	GROUP_PARENT_ID VARCHAR2(255) NOT NULL,
	CONTROL_ID VARCHAR2(255) NOT NULL,
	OWNER_USER_ID VARCHAR2(255) NOT NULL,
	DELETED NUMBER(1,0) DEFAULT 0 NOT NULL,
	CREATED_DATE TIMESTAMP (6) NOT NULL, 
	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_CONTROL (
  	ID VARCHAR2(255) NOT NULL,
  	NAME VARCHAR2(50) NOT NULL,
	DESCRIPTION VARCHAR2(100),
  	START_DAY INT DEFAULT 1 NOT NULL,
  	TYPE_SPLIT NUMBER(1,0) NOT NULL,
  	HAS_CLOSING NUMBER(1,0) DEFAULT 0 NOT NULL,
  	HAS_SAVINGS NUMBER(1,0) DEFAULT 0 NOT NULL,
  	BALANCE_DEFAULT NUMBER(12,4),
  	CURRENCY_ID NUMBER(*,0) NOT NULL,
  	DELETED NUMBER(1,0) DEFAULT 0 NOT NULL,  
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_CONTROL_MONTHLY (
  	ID VARCHAR2(255) NOT NULL,
  	MONTH INT NOT NULL,
  	YEAR INT NOT NULL,
  	BALANCE_REVENUE NUMBER(12,4) NOT NULL,
  	BALANCE_EXPENSE NUMBER(12,4) NOT NULL,
	START_DATE DATE NOT NULL, 
	END_DATE DATE NOT NULL, 
	CONTROL_ID VARCHAR2(255) NOT NULL,
	GROUP_ID VARCHAR2(255) NOT NULL,
	CLOSED NUMBER(1,0) DEFAULT 0 NOT NULL,
	CLOSED_DATE TIMESTAMP (6),
	UPDATED_DATE TIMESTAMP (6), 
	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_TRANSACTION (
  	ID VARCHAR2(255) NOT NULL,
  	DESCRIPTION VARCHAR2(255) NOT NULL,
  	VALUE NUMBER(12,4) NOT NULL,
  	TYPE CHAR NOT NULL,
  	DATE_TRANSACTION TIMESTAMP (6) NOT NULL,
  	SCHEDULED  NUMBER(1,0) NOT NULL,
  	TRANCHE_CURRENT  NUMBER(4,0),
  	TRANCHE_END  NUMBER(4,0),
  	NOTIFICATION NUMBER (1,0) NOT NULL,    
  	CONTROL_MONTHLY_ID VARCHAR2(255) NOT NULL,
  	CONTROL_ID VARCHAR2(255) NOT NULL,
  	CATEGORY_ID VARCHAR2(255) NOT NULL,
  	BASED_TRANSACTION_ID VARCHAR2(255),
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
  	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
  	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_CATEGORY (
  	ID VARCHAR2(255) NOT NULL,
  	NAME VARCHAR2(50) NOT NULL,
	DESCRIPTION VARCHAR2(100),
  	BUDGET NUMBER(12,4) DEFAULT 0 NOT NULL,  
  	CONTROL_ID VARCHAR2(255) NOT NULL,
  	CATEGORY_PARENT_ID VARCHAR2(255),
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
  	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
  	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

CREATE TABLE RP_CLOSING_MONTHLY (
 	ID VARCHAR2(255) NOT NULL,  
  	BALANCE NUMBER(12,4) NOT NULL,
  	BUDGET  NUMBER(12,4) DEFAULT 0 NOT NULL,
  	CONTROL_MONTHLY_ID VARCHAR2(255) NOT NULL,
  	CATEGORY_ID VARCHAR2(255) NOT NULL,
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
  	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
  	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);

create table EN_SAVINGS (
  	ID VARCHAR2(255) NOT NULL,
  	BALANCE NUMBER(12,4) DEFAULT 0 NOT NULL,  
  	CONTROL_ID VARCHAR2(255) NOT NULL,
  	CREATED_DATE TIMESTAMP (6) NOT NULL, 
  	CREATED_USER_ID VARCHAR2(255) NOT NULL,
	UPDATED_DATE TIMESTAMP (6), 
  	UPDATED_USER_ID VARCHAR2(255),
  primary key (ID)
);
/***************************************ALTERS*************************************/
-------------------------------------------PROFILE PRIVILEGE
alter table JN_PROFILE_PRIV 
add constraint FK_JN_PROFILE_PRIV_TY_PROF 
foreign key (PROFILE_ID) 
references TY_PROFILE;

alter table JN_PROFILE_PRIV 
add constraint FK_JN_PROFILE_PRIV_TY_PRIV
foreign key (PRIVILEGE_ID) 
references TY_PRIVILEGE;

-------------------------------------------USER
alter table EN_USER add constraint uk_email unique(EMAIL);

-------------------------------------------PARTICIPANT
alter table EN_PARTICIPANT 
add constraint FK_EN_PART_EN_USER 
foreign key (USER_ID) 
references EN_USER;

alter table EN_PARTICIPANT 
add constraint FK_EN_PART_EN_GROUP 
foreign key (GROUP_ID) 
references EN_GROUP;

alter table EN_PARTICIPANT 
add constraint FK_EN_PART_TY_PROFILE
foreign key (PROFILE_ID) 
references TY_PROFILE;

alter table EN_PARTICIPANT 
add constraint FK_EN_PART_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_PARTICIPANT 
add constraint FK_EN_PART_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;

-------------------------------------------GROUP
alter table EN_GROUP 
add constraint FK_EN_GROUP_EN_GROUP_PARENT 
foreign key (GROUP_PARENT_ID) 
references EN_GROUP;

alter table EN_GROUP 
add constraint FK_EN_GROUP_EN_CONTROL 
foreign key (CONTROL_ID) 
references EN_CONTROL;

alter table EN_GROUP 
add constraint FK_EN_GROUP_EN_USER_OWNER
foreign key (OWNER_USER_ID) 
references EN_USER;

alter table EN_GROUP 
add constraint FK_EN_GROUP_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_GROUP 
add constraint FK_EN_GROUP_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;

-------------------------------------------CONTROL
alter table EN_CONTROL 
add constraint FK_EN_CONTROL_TY_CURRENCY
foreign key (CURRENCY_ID) 
references TY_CURRENCY;

alter table EN_CONTROL 
add constraint FK_EN_CONTROL_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_CONTROL 
add constraint FK_EN_CONTROL_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;
-------------------------------------------CONTROL MONTHLY
alter table EN_CONTROL_MONTHLY 
add constraint FK_EN_MONTHLY_EN_GROUP 
foreign key (GROUP_ID) 
references EN_GROUP;

alter table EN_CONTROL_MONTHLY 
add constraint FK_EN_MONTHLY_EN_CONTROL 
foreign key (CONTROL_ID) 
references EN_CONTROL;

alter table EN_CONTROL_MONTHLY 
add constraint FK_EN_MONTHLY_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;
-------------------------------------------TRANSACTION
alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_TRANS_BASED
foreign key (BASED_TRANSACTION_ID) 
references EN_TRANSACTION;

alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_CATEGORY
foreign key (CATEGORY_ID) 
references EN_CATEGORY;

alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_MONTHLY
foreign key (CONTROL_MONTHLY_ID) 
references EN_CONTROL;

alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_CONTROL 
foreign key (CONTROL_ID) 
references EN_CONTROL;

alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_TRANSACTION 
add constraint FK_EN_TRANS_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;
-------------------------------------------CATEGORY
alter table EN_CATEGORY 
add constraint FK_EN_CATEGORY_EN_CAT_PARENT
foreign key (CATEGORY_PARENT_ID) 
references EN_CATEGORY;

alter table EN_CATEGORY 
add constraint FK_EN_CATEGORY_EN_CONTROL 
foreign key (CONTROL_ID) 
references EN_CONTROL;

alter table EN_CATEGORY 
add constraint FK_EN_CATEGORY_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_CATEGORY 
add constraint FK_EN_CATEGORY_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;

-------------------------------------------CLOSING MONTHLY
alter table RP_CLOSING_MONTHLY 
add constraint FK_RP_CLOSING_EN_CATEGORY
foreign key (CATEGORY_ID) 
references EN_CATEGORY;

alter table RP_CLOSING_MONTHLY 
add constraint FK_RP_CLOSING_EN_MONTHLY
foreign key (CONTROL_MONTHLY_ID) 
references EN_CONTROL_MONTHLY;

alter table RP_CLOSING_MONTHLY 
add constraint FK_RP_CLOSING_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table RP_CLOSING_MONTHLY 
add constraint FK_RP_CLOSING_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;
-------------------------------------------SAVINGS
alter table EN_SAVINGS 
add constraint FK_EN_SAVINGS_EN_CONTROL 
foreign key (CONTROL_ID) 
references EN_CONTROL;

alter table EN_SAVINGS 
add constraint FK_EN_SAVINGS_EN_USER_CREATED
foreign key (CREATED_USER_ID) 
references EN_USER;

alter table EN_SAVINGS 
add constraint FK_EN_SAVINGS_EN_USER_UPDATED
foreign key (UPDATED_USER_ID) 
references EN_USER;