use bbs;

CREATE TABLE BBS (
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsContent VARCHAR(2048),
	bbsAvailable INT,
	PRIMARY KEY (bbsID)
);

desc BBS;

select * from BBS;