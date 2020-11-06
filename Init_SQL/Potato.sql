DROP TABLE BLike;
DROP TABLE PLike;
DROP TABLE MLike;
DROP TABLE BAdd;
DROP TABLE PAdd;
DROP TABLE Keyword;
DROP TABLE Out;
DROP TABLE Board;
DROP TABLE Favor;
DROP TABLE Report;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE Member;
DROP TABLE Local;

CREATE TABLE Member (
	M_ID	VARCHAR2(100)	NOT NULL,
	L_ID	NUMBER	NOT NULL,
	M_PW	VARCHAR2(100)	NULL,
	M_NAME	VARCHAR2(100)	NULL,
	M_NICK	VARCHAR2(100)	NULL,
	M_BIRTH	DATE	NULL,
	M_GENDER	CHAR(1) CHECK (M_GENDER IN ('M', 'F'))	NULL,
	M_ADDRESS	VARCHAR2(100)	NULL,
	M_LIKE	NUMBER DEFAULT 0 NULL,
	M_JOINDATE	DATE DEFAULT SYSDATE	NULL,
	M_INTRO	VARCHAR2(100)	NULL,
	M_SELLAMOUNT	NUMBER DEFAULT 0	NULL,
	M_VISIT	NUMBER DEFAULT 0	NULL,
	M_IMAGE	VARCHAR2(100)	NULL,
	M_STATUS	CHAR(1) DEFAULT 'L' CHECK (M_STATUS IN ('O','L'))	NULL,
	M_LOGINDATE	DATE	NULL,
	M_REPORTCOUNT	NUMBER DEFAULT 0	NULL,
	M_PHONE	VARCHAR2(100)	NULL,
	M_EMAIL	VARCHAR2(100)	NULL,
	M_EMAILHASH	VARCHAR2(100)	NULL,
	M_AUTHORIZATION	CHAR(1) DEFAULT 'X' CHECK(M_AUTHORIZATION IN ('X', 'U', 'M'))	NULL,
	M_JOINWAY	VARCHAR2(20)	NULL
);

CREATE TABLE Keyword (
	M_ID2	VARCHAR2(100)	NOT NULL,
	K_KEYWORD1	VARCHAR2(100)	NULL,
	K_KEYWORD2	VARCHAR2(100)	NULL,
	K_KEYWORD3	VARCHAR2(100)	NULL
);

CREATE TABLE Local (
	L_ID	NUMBER	NOT NULL,
	L_NAME	VARCHAR2(100)	NULL
);

CREATE TABLE Category (
	C_LID	NUMBER	NOT NULL,
	C_SID	NUMBER	NOT NULL,
	C_NAME	VARCHAR2(100)	NULL
);

CREATE TABLE Out (
	M_ID	VARCHAR2(100)	NOT NULL,
	O_STATUS	CHAR(1)	CHECK (O_STATUS IN ('Y', 'N'))NULL,
	O_OUTDATE	DATE	NULL,
	O_REASON	VARCHAR2(100)	NULL
);

CREATE TABLE Report (
	R_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(100)	NOT NULL,
	M_ID2	VARCHAR2(100)	NOT NULL,
	R_REASON	VARCHAR2(4000)	NULL
);

CREATE TABLE Board (
	B_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(100)	NOT NULL,
	B_TYPE	CHAR(1)	CHECK (B_TYPE IN ('G', 'P', 'Q', 'N')) NULL,
	B_TITLE	VARCHAR2(100)	NULL,
	B_TIMESTAMP	TIMESTAMP	NULL,
	B_VIEW	NUMBER DEFAULT 0	NULL,
	B_LIKE	NUMBER DEFAULT 0	NULL,
	B_COUNT	NUMBER DEFAULT 0	NULL,
	B_CONTENT	VARCHAR2(4000)	NULL,
	B_SECRET	CHAR(1) CHECK(B_SECRET IN ('Y', 'N'))	NULL,
	B_SECRETNUMBER	NUMBER	NULL,
	B_REF	NUMBER	NULL,
	B_RE_STEP	NUMBER	NULL,
	B_RE_LEVEL	NUMBER	NULL
);

CREATE TABLE Favor (
	M_ID	VARCHAR2(100)	NOT NULL,
	C_LID	NUMBER	NOT NULL,
	C_SID	NUMBER	NOT NULL
);

CREATE TABLE PAdd (
	P_ID	NUMBER	NOT NULL,
	PA_IMG1	VARCHAR2(4000)	NULL,
	PA_IMG2	VARCHAR2(4000)	NULL,
	PA_IMG3	VARCHAR2(4000)	NULL
);

CREATE TABLE BAdd (
	B_ID	NUMBER	NOT NULL,
	BA_IMG1	VARCHAR2(4000)	NULL,
	BA_IMG2	VARCHAR2(4000)	NULL,
	BA_IMG3	VARCHAR2(4000)	NULL
);

CREATE TABLE Product (
	P_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(100)	NOT NULL,
	C_LID	NUMBER	NOT NULL,
	C_SID	NUMBER	NOT NULL,
	L_ID	NUMBER	NOT NULL,
	P_NAME	VARCHAR2(200)	NULL,
	P_ADDDATE	DATE	NULL,
	P_VALUE	NUMBER	NULL,
	P_STATUS	CHAR(1) CHECK(P_STATUS IN ('A', 'B', 'C'))	NULL,
	P_DESCRIPTION	VARCHAR2(4000)	NULL,
	P_LIKE	NUMBER	NULL,
	P_BRAND	VARCHAR2(100)	NULL,
	P_DEALSTATUS	CHAR(1) CHECK(P_DEALSTATUS IN ('Y', 'N'))	NULL,
	P_DEALDATE	DATE	NULL,
	P_PREMIUM	CHAR(1) DEFAULT 'G' CHECK(P_PREMIUM IN ('G', 'P'))	NULL,
	P_VIEW	NUMBER	NULL,
	P_REF	NUMBER	NULL,
	P_RE_STEP	NUMBER	NULL,
	P_RE_LEVEL	NUMBER	NULL
);

CREATE TABLE BLike (
	B_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(100)	NOT NULL
);

CREATE TABLE PLike (
	P_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(100)	NOT NULL
);

CREATE TABLE MLike (
	M_ID	VARCHAR2(100)	NOT NULL,
	M_ID2	VARCHAR2(100)	NOT NULL
);

ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	M_ID
);

ALTER TABLE Keyword ADD CONSTRAINT PK_KEYWORD PRIMARY KEY (
	M_ID2
);

ALTER TABLE Local ADD CONSTRAINT PK_LOCAL PRIMARY KEY (
	L_ID
);

ALTER TABLE Category ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	C_LID,
	C_SID
);

ALTER TABLE Out ADD CONSTRAINT PK_OUT PRIMARY KEY (
	M_ID
);

ALTER TABLE Report ADD CONSTRAINT PK_REPORT PRIMARY KEY (
	R_ID
);

ALTER TABLE Board ADD CONSTRAINT PK_BOARD PRIMARY KEY (
	B_ID
);

ALTER TABLE PAdd ADD CONSTRAINT PK_PADD PRIMARY KEY (
	P_ID
);

ALTER TABLE BAdd ADD CONSTRAINT PK_BADD PRIMARY KEY (
	B_ID
);

ALTER TABLE Product ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (
	P_ID
);

ALTER TABLE BLike ADD CONSTRAINT PK_BLIKE PRIMARY KEY (
	B_ID,
	M_ID
);

ALTER TABLE PLike ADD CONSTRAINT PK_PLIKE PRIMARY KEY (
	P_ID,
	M_ID
);

ALTER TABLE Keyword ADD CONSTRAINT FK_Member_TO_Keyword_1 FOREIGN KEY (
	M_ID2
)
REFERENCES Member (
	M_ID
);

ALTER TABLE Out ADD CONSTRAINT FK_Member_TO_Out_1 FOREIGN KEY (
	M_ID
)
REFERENCES Member (
	M_ID
);

ALTER TABLE PAdd ADD CONSTRAINT FK_Product_TO_PAdd_1 FOREIGN KEY (
	P_ID
)
REFERENCES Product (
	P_ID
);

ALTER TABLE BAdd ADD CONSTRAINT FK_Board_TO_BAdd_1 FOREIGN KEY (
	B_ID
)
REFERENCES Board (
	B_ID
);

ALTER TABLE BLike ADD CONSTRAINT FK_Board_TO_BLike_1 FOREIGN KEY (
	B_ID
)
REFERENCES Board (
	B_ID
);

ALTER TABLE BLike ADD CONSTRAINT FK_Member_TO_BLike_1 FOREIGN KEY (
	M_ID
)
REFERENCES Member (
	M_ID
);

ALTER TABLE PLike ADD CONSTRAINT FK_Product_TO_PLike_1 FOREIGN KEY (
	P_ID
)
REFERENCES Product (
	P_ID
);

ALTER TABLE PLike ADD CONSTRAINT FK_Member_TO_PLike_1 FOREIGN KEY (
	M_ID
)
REFERENCES Member (
	M_ID
);

-- insert base data
-- local table
insert into local values(1, '������');
insert into local values(2, '������');
insert into local values(3, '���ϱ�');
insert into local values(4, '������');
insert into local values(5, '���Ǳ�');
insert into local values(6, '������');
insert into local values(7, '���α�');
insert into local values(8, '��õ��');
insert into local values(9, '�����');
insert into local values(10, '������');
insert into local values(11, '���빮��');
insert into local values(12, '���۱�');
insert into local values(13, '������');
insert into local values(14, '���빮��');
insert into local values(15, '���ʱ�');
insert into local values(16, '������');
insert into local values(17, '���ϱ�');
insert into local values(18, '���ı�');
insert into local values(19, '��õ��');
insert into local values(20, '��������');
insert into local values(21, '��걸');
insert into local values(22, '����');
insert into local values(23, '���α�');
insert into local values(24, '�߱�');
insert into local values(25, '�߶���');
insert into local values(26, '����');
insert into local values(27, '���');
insert into local values(28, '�泲');
insert into local values(29, '���');
insert into local values(30, '����');
insert into local values(31, '����');
insert into local values(32, '�泲');
insert into local values(33, '���');
insert into local values(34, '����Ư����ġ��');
insert into local values(35, '�λ�');
insert into local values(36, '�뱸');
insert into local values(37, '��õ');
insert into local values(38, '����');
insert into local values(39, '����');
insert into local values(40, '���');
insert into local values(41, '����Ư����ġ��');

-- Category table
insert into Category values(1,1,'����');
insert into Category values(1,2,'����');
insert into Category values(1,3,'�Ź�');
insert into Category values(1,4,'����');
insert into Category values(1,5,'����');
insert into Category values(1,6,'�Ƿ� ��Ÿ');
insert into Category values(2,1,'�����');
insert into Category values(2,2,'����');
insert into Category values(2,3,'��Ʈ��');
insert into Category values(2,4,'ī�޶�');
insert into Category values(2,5,'�����');
insert into Category values(2,6,'������ǰ ��Ÿ');
insert into Category values(3,1,'����');
insert into Category values(3,2,'��Ų�ɾ�');
insert into Category values(3,3,'���');
insert into Category values(3,4,'����');
insert into Category values(3,5,'����ȭ��ǰ');
insert into Category values(3,6,'��Ƽ ��Ÿ');
insert into Category values(4,1,'�����Ƿ�');
insert into Category values(4,2,'�����Ƿ�');
insert into Category values(4,3,'�峭��');
insert into Category values(4,4,'������');
insert into Category values(4,5,'������');
insert into Category values(4,6,'�Ƶ���ǰ ��Ÿ');
insert into Category values(5,1,'��Ÿ');

-- Member table
-- Manager
insert into Member values('MasterPotato1', 1, 'Potato123', 'master', 'master', '2020-11-01', 'M', '����', 0, '2020-11-01', 'master', 0, 0, null, 'O', '2020-11-01', 0, '000-0000-0000', 'nothing1360@gmail.com', 'x', 'M', 'MY');

COMMIT;