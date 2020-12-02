DROP TABLE KEYWORD;
DROP TABLE TRADE;
-- 위에 테이블 이름 바뀌거나 사라져서 그런건데
-- INSERT 같은게 잘 안되거나하면 테이블 전체를 하나씩 확인하면서 다 지우고 아래 실행시키면됩니다.
DROP TABLE Chat;
DROP TABLE TradeInfo;
DROP TABLE BLike;
DROP TABLE PLike;
DROP TABLE MLike;
DROP TABLE BAdd;
DROP TABLE PAdd;
DROP TABLE Out;
DROP TABLE Board;
DROP TABLE Favor;
DROP TABLE Report;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE Member;
DROP TABLE Local;

CREATE TABLE Member (
	M_ID	VARCHAR2(500)	NOT NULL,
	L_ID	NUMBER	NOT NULL,
	M_PW	VARCHAR2(500)	NULL,
	M_NAME	VARCHAR2(500)	NULL,
	M_NICK	VARCHAR2(500) UNIQUE	NULL,
	M_BIRTH	DATE	NULL,
	M_GENDER	CHAR(1) CHECK (M_GENDER IN ('M', 'F'))	NULL,
	M_ADDRESS	VARCHAR2(1000)	NULL,
	M_LIKE	NUMBER DEFAULT 0	NULL,
	M_JOINDATE	DATE DEFAULT SYSDATE	NULL,
	M_INTRO	VARCHAR2(1000)	NULL,
	M_SELLAMOUNT	NUMBER DEFAULT 0	NULL,
	M_VISIT	NUMBER DEFAULT 0	NULL,
	M_IMAGE	VARCHAR2(500)	NULL,
	M_STATUS	CHAR(1) DEFAULT 'L' CHECK (M_STATUS IN ('O','L'))	NULL,
	M_LOGINDATE	DATE	NULL,
	M_REPORTCOUNT	NUMBER DEFAULT 0	NULL,
	M_PHONE	VARCHAR2(100)	NULL,
	M_EMAIL	VARCHAR2(1000)	NULL,
	M_EMAILHASH	VARCHAR2(1000)	NULL,
	M_AUTHORIZATION	CHAR(1) DEFAULT 'U' CHECK(M_AUTHORIZATION IN ('U', 'M'))	NULL,
	M_JOINWAY	VARCHAR2(20) DEFAULT 'MY'	NULL
);

CREATE TABLE Local (
	L_ID	NUMBER	NOT NULL,
	L_NAME	VARCHAR2(500)	NULL
);

CREATE TABLE Category (
	C_LID	NUMBER	NOT NULL,
	C_SID	NUMBER	NOT NULL,
	C_NAME	VARCHAR2(500)	NULL
);

CREATE TABLE Out (
	M_ID	VARCHAR2(500)	NOT NULL,
	O_STATUS	CHAR(1)	CHECK (O_STATUS IN ('Y', 'N'))	NULL,
	O_OUTDATE	DATE	NULL,
	O_REASON	VARCHAR2(2000)	NULL
);

CREATE TABLE Report (
	R_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(500)	NOT NULL,
	M_ID2	VARCHAR2(500)	NOT NULL,
	R_REASON	VARCHAR2(4000)	NULL
);

CREATE TABLE Board (
	B_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(500)	NOT NULL,
	B_TYPE	CHAR(1)	CHECK (B_TYPE IN ('G', 'P', 'Q', 'N'))	NULL,
	B_TITLE	VARCHAR2(1000)	NULL,
	B_TIMESTAMP	TIMESTAMP	NULL,
	B_VIEW	NUMBER DEFAULT 0	NULL,
	B_LIKE	NUMBER DEFAULT 0	NULL,
	B_CONTENT	VARCHAR2(4000)	NULL,
	B_SECRET	CHAR(1) CHECK(B_SECRET IN ('Y', 'N'))	NULL,
	B_SECRETNUMBER	NUMBER	NULL,
	B_REF	NUMBER	NULL,
	B_RE_STEP	NUMBER	NULL,
	B_RE_LEVEL	NUMBER	NULL
);

CREATE TABLE Favor (
	M_ID	VARCHAR2(500)	NOT NULL,
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
	M_ID	VARCHAR2(500)	NOT NULL,
	C_LID	NUMBER	NOT NULL,
	C_SID	NUMBER	NOT NULL,
	L_ID	NUMBER	NOT NULL,
	P_NAME	VARCHAR2(4000)	NULL,
	P_ADDDATE	DATE	NULL,
	P_VALUE	NUMBER	NULL,
	P_STATUS	CHAR(1) CHECK(P_STATUS IN ('A', 'B', 'C'))	NULL,
	P_DESCRIPTION	VARCHAR2(4000)	NULL,
	P_LIKE	NUMBER	NULL,
	P_BRAND	VARCHAR2(500)	NULL,
	P_DEALSTATUS	CHAR(1) CHECK(P_DEALSTATUS IN ('Y', 'N'))	NULL,
	P_DEALDATE	DATE	NULL,
	P_PREMIUM	CHAR(1) DEFAULT 'G' CHECK(P_PREMIUM IN ('G', 'P'))	NULL,
	P_VIEW	NUMBER	NULL
);

CREATE TABLE BLike (
	B_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(500)	NOT NULL
);

CREATE TABLE PLike (
	P_ID	NUMBER	NOT NULL,
	M_ID	VARCHAR2(500)	NOT NULL
);

CREATE TABLE MLike (
	M_ID	VARCHAR2(500)	NOT NULL,
	M_ID2	VARCHAR2(500)	NOT NULL
);

CREATE TABLE TradeInfo (
	P_ID	NUMBER	NOT NULL,
	S_ID	VARCHAR2(500)	NOT NULL,
	B_ID	VARCHAR2(500)	NOT NULL
);

CREATE TABLE Chat (
	chatID	NUMBER	NOT NULL,
	fromID	VARCHAR2(500)	NOT NULL,
	toID	VARCHAR2(500)	NOT NULL,
	chatContent	VARCHAR2(4000)	NULL,
	chatTime	TIMESTAMP	NULL,
	chatRead	NUMBER	NULL
);

ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (M_ID);
ALTER TABLE Local ADD CONSTRAINT PK_LOCAL PRIMARY KEY (L_ID);
ALTER TABLE Category ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (C_LID,	C_SID);
ALTER TABLE Out ADD CONSTRAINT PK_OUT PRIMARY KEY (M_ID);
ALTER TABLE Report ADD CONSTRAINT PK_REPORT PRIMARY KEY (R_ID);
ALTER TABLE Board ADD CONSTRAINT PK_BOARD PRIMARY KEY (B_ID);
ALTER TABLE PAdd ADD CONSTRAINT PK_PADD PRIMARY KEY (P_ID);
ALTER TABLE BAdd ADD CONSTRAINT PK_BADD PRIMARY KEY (B_ID);
ALTER TABLE Product ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (P_ID);
ALTER TABLE BLike ADD CONSTRAINT PK_BLIKE PRIMARY KEY (B_ID, M_ID);
ALTER TABLE PLike ADD CONSTRAINT PK_PLIKE PRIMARY KEY (P_ID, M_ID);
ALTER TABLE TradeInfo ADD CONSTRAINT PK_TRADEINFO PRIMARY KEY (P_ID);
ALTER TABLE Chat ADD CONSTRAINT PK_CHAT PRIMARY KEY (chatID);

ALTER TABLE Member ADD CONSTRAINT FK_Local_TO_Member_1 FOREIGN KEY (L_ID) REFERENCES Local (L_ID);
ALTER TABLE Report ADD CONSTRAINT FK_Member_TO_Report_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE Report ADD CONSTRAINT FK_Member_TO_Report_2 FOREIGN KEY (M_ID2) REFERENCES Member (M_ID);
ALTER TABLE Board ADD CONSTRAINT FK_Member_TO_Board_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE Product ADD CONSTRAINT FK_Member_TO_Product_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE Product ADD CONSTRAINT FK_Local_TO_Product_1 FOREIGN KEY (L_ID) REFERENCES Local (L_ID);
ALTER TABLE Product ADD CONSTRAINT FK_Category_TO_Product_1 FOREIGN KEY (C_LID, C_SID) REFERENCES Category (C_LID, C_SID);
ALTER TABLE Chat ADD CONSTRAINT FK_Member_TO_Chat_1 FOREIGN KEY (fromID) REFERENCES Member (M_ID);
ALTER TABLE Chat ADD CONSTRAINT FK_Member_TO_Chat_2 FOREIGN KEY (toID) REFERENCES Member (M_ID);
ALTER TABLE Out ADD CONSTRAINT FK_Member_TO_Out_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE PAdd ADD CONSTRAINT FK_Product_TO_PAdd_1 FOREIGN KEY (P_ID) REFERENCES Product (P_ID) ON DELETE CASCADE;
ALTER TABLE BAdd ADD CONSTRAINT FK_Board_TO_BAdd_1 FOREIGN KEY (B_ID) REFERENCES Board (B_ID);
ALTER TABLE BLike ADD CONSTRAINT FK_Board_TO_BLike_1 FOREIGN KEY (B_ID) REFERENCES Board (B_ID);
ALTER TABLE BLike ADD CONSTRAINT FK_Member_TO_BLike_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE PLike ADD CONSTRAINT FK_Product_TO_PLike_1 FOREIGN KEY (P_ID) REFERENCES Product (P_ID) ON DELETE CASCADE;
ALTER TABLE PLike ADD CONSTRAINT FK_Member_TO_PLike_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE TradeInfo ADD CONSTRAINT FK_Product_TO_TradeInfo_1 FOREIGN KEY (P_ID) REFERENCES Product (P_ID);
ALTER TABLE TradeInfo ADD CONSTRAINT FK_Member_TO_TradeInfo_1 FOREIGN KEY (S_ID) REFERENCES Member (M_ID);
ALTER TABLE TradeInfo ADD CONSTRAINT FK_Member_TO_TradeInfo_2 FOREIGN KEY (B_ID) REFERENCES Member (M_ID);
ALTER TABLE Favor ADD CONSTRAINT FK_Member_TO_Favor_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE Favor ADD CONSTRAINT FK_Category_TO_Favor_1 FOREIGN KEY (C_LID,C_SID) REFERENCES Category (C_LID,C_SID);
ALTER TABLE MLike ADD CONSTRAINT FK_Member_TO_MLike_1 FOREIGN KEY (M_ID) REFERENCES Member (M_ID);
ALTER TABLE MLike ADD CONSTRAINT FK_Member_TO_MLike_2 FOREIGN KEY (M_ID2) REFERENCES Member (M_ID);

COMMIT;

--상품 Plike 트리거-------------------------------------------------------------------
--CREATE OR REPLACE TRIGGER TRG_PLIKE1
--    AFTER
--    INSERT ON PLIKE
--    FOR EACH ROW
--    BEGIN
--        update product set p_like = p_like + 1 where p_id = :new.p_id;
--     END;
--/
--CREATE OR REPLACE TRIGGER TRG_PLIKE2
--    AFTER
--    DELETE ON PLIKE
--    FOR EACH ROW
--    BEGIN
--        update product set p_like = p_like - 1 where p_id = :old.p_id;
--     END;
--/
--상품 Plike 트리거-------------------------------------------------------------------


-- insert base data
-- local table
insert into local values(1, '강남구');
insert into local values(2, '강동구');
insert into local values(3, '강북구');
insert into local values(4, '강서구');
insert into local values(5, '관악구');
insert into local values(6, '광진구');
insert into local values(7, '구로구');
insert into local values(8, '금천구');
insert into local values(9, '노원구');
insert into local values(10, '도봉구');
insert into local values(11, '동대문구');
insert into local values(12, '동작구');
insert into local values(13, '마포구');
insert into local values(14, '서대문구');
insert into local values(15, '서초구');
insert into local values(16, '성동구');
insert into local values(17, '성북구');
insert into local values(18, '송파구');
insert into local values(19, '양천구');
insert into local values(20, '영등포구');
insert into local values(21, '용산구');
insert into local values(22, '은평구');
insert into local values(23, '종로구');
insert into local values(24, '중구');
insert into local values(25, '중랑구');
insert into local values(26, '강원');
insert into local values(27, '경기');
insert into local values(28, '경남');
insert into local values(29, '경북');
insert into local values(30, '전남');
insert into local values(31, '전북');
insert into local values(32, '충남');
insert into local values(33, '충북');
insert into local values(34, '제주특별자치도');
insert into local values(35, '부산');
insert into local values(36, '대구');
insert into local values(37, '인천');
insert into local values(38, '광주');
insert into local values(39, '대전');
insert into local values(40, '울산');
insert into local values(41, '세종특별자치시');

-- Category table
insert into Category values(1,1,'상의');
insert into Category values(1,2,'하의');
insert into Category values(1,3,'신발');
insert into Category values(1,4,'모자');
insert into Category values(1,5,'가방');
insert into Category values(1,6,'의류 기타');
insert into Category values(2,1,'모바일');
insert into Category values(2,2,'게임');
insert into Category values(2,3,'노트북');
insert into Category values(2,4,'카메라');
insert into Category values(2,5,'모니터');
insert into Category values(2,6,'가전제품 기타');
insert into Category values(3,1,'색조');
insert into Category values(3,2,'스킨케어');
insert into Category values(3,3,'헤어');
insert into Category values(3,4,'네일');
insert into Category values(3,5,'남성화장품');
insert into Category values(3,6,'뷰티 기타');
insert into Category values(4,1,'여아의류');
insert into Category values(4,2,'남아의류');
insert into Category values(4,3,'장난감');
insert into Category values(4,4,'기저귀');
insert into Category values(4,5,'이유식');
insert into Category values(4,6,'아동용품 기타');
insert into Category values(5,1,'기타');

-- Member table
-- Manager
insert into Member values('MasterPotato1', 1, 'Potato123', 'master', 'master', '2020-11-01', 'M', '서울 강남구_세부주소', 0, '2020-11-01', 'master', 0, 0, null, 'O', '2020-11-01', 0, '000-0000-0000', 'nothing1360@gmail.com', 'x', 'M', 'MY');
insert into Out values('MasterPotato1', 'N', null, null);
commit;
