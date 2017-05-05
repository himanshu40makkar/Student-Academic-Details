create database project
use project

create table course(courseId int primary key,courseName varchar(20))
create table branch(branchId int primary key,branchName varchar(20),courseId int references course)

create table session(sessionId int primary key,sessiony varchar(20))
create table semester(semId int primary key,semName varchar(20))
create table subjects(subId int primary key,subName varchar(20),subDesc varchar(20))
alter table subjects alter column subDesc varchar(100)

create table syllabus(syllabusId int primary key,semId int references semester,sessionId int references session,branchId int references branch,subId int references subjects) 
create table student(rollNo int primary key,sname varchar(20),address varchar(20),Contact int)
create table sessional(sessId int primary key,sessName varchar(20))
create table enrollstudent(rollNo int references student,semId int references semester,branchId int references branch,sessionId int references session,enrollstudentId int primary key)
create table sessionaldetail(sessionalId int references sessional,sessionalDate varchar(20),sessionaldetails varchar(40))
alter table sessionaldetail add sessionaldetailsId int
alter table sessionaldetail add primary key(sessionaldetailsid)
alter table sessionaldetail alter column sessionaldetailsId int not null

create table sessionalMarks(sessdetailId int references sessionaldetail,enrollstudentId int references enrollstudent,subid int references subjects,marks int,primary key(subId,enrollstudentId))
alter table sessionalmarks alter column sessdetailid int not null

alter table sessionalmarks add primary key(sessdetailId,enrollstudentid,subid)

create table month(monthId int primary key,monthName varchar(20))
create table assingment(assingmentId int primary key,assingmentName varchar(20),subId int references subjects,assingmentdate varchar(20),submissiondate varchar(20))
create table assingmentmarks(assingmentId int references assingment,enrollstudentId int references enrollstudent,marks int,primary key(assingmentId,enrollstudentId))

create table attendance(attendanceId int,monthId int references month,subId int references subjects,enrollstudentId int references enrollstudent,totalPercentage int,primary key(monthId ,subId ,enrollstudentId))
create table internal(enrollstudentId int references enrollstudent,subId int references subjects,sessionId int references session,marks int)
create table externals(enrollstudentId int references enrollstudent,subId int references subjects,sessionId int references session,marks int)
create table finals(enrollstudentId int references enrollstudent,subId int references subjects,sessionId int references session,TotalMarks int)
create table usernm(userId varchar(20),pwd varchar(20),typ varchar(20))
create table practical(pid int primary key,practicalName varchar(20),semId int
insert into usernm values('himanshu','himanshu','User')
delete usernm

select * from internal
alter table externals alter column enrollstudentId int  not null

alter table externals add primary key(enrollstudentId,subId)


alter table finals drop column sessionId
alter table finals drop constraint FK__finals__sessionI__6FE99F9F


========================================================================
create proc add_course(@courseName varchar(20))
as
declare
@courseId int
begin
set @courseId =(select isnull(MAX(courseId),0) from course)+1
insert into course values(@courseId,@courseName)
end
=========================================================================
delete course
select * from course
delete branch
select * from branch


========================================================================
create proc add_branch(@branchName varchar(20),@courseId int)
as
declare
@branchId int
begin
set @branchId =(select isnull(MAX(branchId),0) from branch)+1
insert into branch values(@branchId,@branchName,@courseId)
end
===================================================================
create proc del_branch(@branchName varchar(20),@courseId int)
as
declare
@count int
begin
delete from branch where branchName=@branchName and courseId=@courseId
set @count=(select count(*) from branch where courseId=@courseId)
if(@count=0)
begin
delete from course where courseId=@courseId
end
end

=======================================================
alter proc add_session(@year int)
as
declare
@sessionId int,
@sessionName varchar(20)
begin
set @sessionId =(select isnull(MAX(sessionId),0) from session)+1
set @sessionName=convert(varchar(10),(select MONTH(getdate())))+','+convert(varchar(10),(select YEAR(getdate())))+'-'+convert(varchar(10),(select MONTH(dateadd(year,@year,getdate()))))+','+convert(varchar(10),(select YEAR(dateadd(year,@year,getdate()))))
insert into session values(@sessionId,@sessionName)
end
====================================================================
add_session 4
select * from session
delete session

add_course 'btech'
add_branch CSE,c1
add_branch MECH,c1
select * from course
select * from branch
select * from session
select * from enrollstudent
select * from student
select * from subjects
delete subjects
select * from sessionalmarks
select * from assingment
delete from assingment where assingmentid=2




=====================================================================
alter proc add_enrollstudent(@rollNo int,@semId int,@branchid int,@sessionId int)
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select isnull(max(enrollstudentId),1000)from enrollstudent)+1
insert into enrollstudent values(@rollNo,@semId,@branchid,@sessionId,@enrollstudentid)
end
==============================================
create proc add_semester(@semname varchar(10))
as
declare
@semId int
begin
set @semId =(select isnull(MAX(semId),0) from semester)+1
insert into semester values(@semId,@semName)
end
======================================================================
alter proc add_subject(@subName varchar(20),@subDesc varchar(100))
as
declare
@subId int
begin
set @subId =(select isnull(MAX(subId),0) from subjects)+1
insert into subjects values(@subId,@subName,@subDesc)
end
=======================================================================
create proc add_syllabus(@semId int,@sessionId int,@branchId int,@subId int)
as
declare
@syllabusId int
begin
set @syllabusId =(select isnull(MAX(syllabusId),0) from syllabus)+1
insert into syllabus values(@syllabusId,@semId,@sessionId,@branchId,@subId)
end
select * from syllabus
use project

=======================================================================
alter proc add_student(@sname varchar(20),@address varchar(40),@contact varchar(20))
as
declare
@rollNo int
begin
set @rollNo =(select isnull(MAX(rollNo),1712000) from student)+1
insert into student values(@rollNo,@sname,@address,@contact)
end
=========================================================================
select * from student
delete student
======================================
alter proc add_sessional(@sessionalName varchar(20))
as
declare
@sessionalId int
begin
set @sessionalId=(select ISNULL(max(sessId),0) from sessional)+1
insert into sessional values(@sessionalId,@sessionalName)
end

====================================================
alter proc add_sessionaldetail(@sessionalId int,@sessd varchar(20))
as
declare
@sessid int
begin
set @sessid=(select ISNULL(MAX(sessionaldetailsId),0) from sessionaldetail)+1
insert into sessionaldetail values(@sessionalId,@sessd,@sessid) 
end

=======================================================
create proc add_sessionalmarks(@sessdetId int,@enrollId int,@subId int,@marks int)
as
begin
insert into sessionalmarks values(@sessdetId ,@enrollId ,@subId ,@marks )
end

alter proc add_sessionalmarks(@sessname varchar(20),@sessdate varchar(20),@rollno int,@semName varchar(20),@subname varchar(20),@marks int)
as 
declare
@sessdetId int,
@sessid int,
@enrollid int,
@subId int
begin
set @sessid=(select sessId from sessional where sessName=@sessname)
set @sessdetId=(select sessionaldetailsId from sessionaldetail where sessionalId=@sessid and sessionalDate=@sessdate)
set @enrollid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
set @subId=(select subid from subjects where subname=@subname)
insert into sessionalmarks values(@sessdetId,@enrollid,@subId,@marks)
end
=============================================================
alter proc view_sessionalmarks(@sessname varchar(20),@sessdate varchar(20),@rollno int,@semName varchar(20),@subname varchar(20))
as 
declare
@sessid int,
@enrollid int,
@subId int,
@sessdetId int
begin
set @sessid=(select sessId from sessional where sessName=@sessname)
set @sessdetId=(select sessionaldetailsId from sessionaldetail where sessionalId=@sessid and sessionalDate=@sessdate)
set @enrollid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
set @subId=(select subid from subjects where subname=@subname)
select marks from sessionalmarks where sessdetailId=@sessdetid and enrollstudentId=@enrollid and subId=@subId

end
===========================================================
alter proc update_sessionalmarks(@sessname varchar(20),@sessdate varchar(20),@rollno int,@semName varchar(20),@subname varchar(20),@marks int)
as 
declare
@sessdetId int,
@sessid int,
@enrollid int,
@subId int
begin
set @sessid=(select sessId from sessional where sessName=@sessname)
set @sessdetId=(select sessionaldetailsId from sessionaldetail where sessionalId=@sessid and sessionalDate=@sessdate)
set @enrollid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
set @subId=(select subid from subjects where subname=@subname)
update sessionalmarks set marks=@marks where sessdetailId =@sessdetId and enrollstudentId=@enrollid and subid =@subId
end
===========================================================================================================
create proc add_assingment(@assingmentName varchar(20),@subId int,@assingmentdate varchar(20),@submissiondate varchar(20))
as
declare
@assingmentId int
begin 
set @assingmentId=(select isnull(max(assingmentId),0) from assingment)+1
insert into assingment values(@assingmentId,@assingmentName,@subId,@assingmentdate,@submissiondate )
end

=================================================================

create proc add_assingmentmarks(@assingmentId int ,@rollNo int,@semName varchar(20),@marks int)
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
insert into assingmentmarks values(@assingmentId,@enrollstudentid,@marks)
end
================================================================
create proc view_assingmentmarks(@assingmentId int ,@rollNo int,@semName varchar(20))
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
select marks from assingmentmarks where assingmentId=@assingmentId and enrollstudentId=@enrollstudentid
end

=======================================================

create proc update_assingmentmarks(@assingmentId int ,@rollNo int,@semName varchar(20),@marks int)
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
update assingmentmarks set marks=@marks where assingmentId=@assingmentId and enrollstudentId=@enrollstudentid
end

=======================================================
create proc add_month(@monthName varchar(20))
as
declare
@monthId int
begin
set @monthId =(select isnull(max(monthid),0)from month)+1
insert into month values(@monthId,@monthName)
end
=================================================
create proc add_attendance(@monthId int,@subId int,@rollNo int,@semName varchar(20),@totalPercentage int)
as
declare
@enrollstudentid int,
@attendanceId int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
set @attendanceId=(select isnull(max(attendanceId),0) from attendance)+1
insert into attendance values(@attendanceId,@monthId,@subId,@enrollstudentId,@totalpercentage)
end
=============================================
create proc modify_attendance(@monthId int,@subId int,@rollNo int,@semName varchar(20),@totalPercentage int)
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
update attendance set totalpercentage=@totalpercentage where monthId=@monthId and subId= @subId and enrollstudentId=@enrollstudentId
end

===============================================================
create proc view_attendance(@monthId int,@subId int,@rollNo int,@semName varchar(20))
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
select totalpercentage from attendance where monthId=@monthId and subId= @subId and enrollstudentId=@enrollstudentId
end
=====================================================
create proc check_internals(@rollNo int,@semName varchar(20),@subId int)
as
declare
@enrollstudentid int
begin
set @enrollstudentid=(select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) )
select * from internal where enrollstudentId=@enrollstudentid and subid=@subid
end
==========================================================
create proc get_enrollid(@rollNo int,@semName varchar(20))
as
begin
select enrollstudentid from enrollstudent where rollNo=@rollno and semid=(select semid from semester where semName=@semName) 
end
==========================================================

select * from usernm



select max(marks) from externals where subid=1


select * from internal
select marks from externals where enrollstudentid=1001 and subid=1
select marks from internal where enrollstudentid=1001 and subId=1
select * from externals
select max(marks) from externals where subid=1



delete externals
