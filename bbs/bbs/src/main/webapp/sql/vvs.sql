use bbs;

CREATE TABLE VVS (
	vvsID INT,
	vvsTitle VARCHAR(50),
	userID VARCHAR(20),
	vvsDate DATETIME,
	vvsContent VARCHAR(2048),
	vvsAvailable INT,
	PRIMARY KEY (vvsID)
);

desc VVS;

select * from VVS;