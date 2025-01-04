use bbs;

create table vvscomment(
vvsboardID int,
vvscommentID int,
vvsID int,
userID varchar(20),
vvscommentDate varchar(50),
vvscommentText varchar(100),
vvscommentAvailable int
);

desc vvscomment;

select * from vvscomment;
