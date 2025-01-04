use bbs;

create table comment(
boardID int,
commentID int,
bbsID int,
userID varchar(20),
commentDate varchar(50),
commentText varchar(100),
commentAvailable int
);

desc comment;

select * from comment;