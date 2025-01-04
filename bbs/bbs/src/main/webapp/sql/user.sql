use bbs;

create table user (
	userID VARCHAR(20),	
	userPassword VARCHAR(20),
	userName VARCHAR(20),	
	userGender VARCHAR(20),
	userEmail VARCHAR(50),
	PRIMARY KEY (userID)
);

desc user;

select * from user;