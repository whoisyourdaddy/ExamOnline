prompt PL/SQL Developer import file
prompt Created on 2017年1月12日 by Administrator
set feedback off
set define off
prompt Creating QUESTION...
create table QUESTION
(
  qid    NUMBER not null,
  qtype  NUMBER not null,
  course VARCHAR2(20) not null,
  keya   VARCHAR2(300),
  keyb   VARCHAR2(300),
  keyc   VARCHAR2(300),
  keyd   VARCHAR2(300),
  ques   VARCHAR2(3000) not null,
  answer VARCHAR2(3000) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table QUESTION
  is '题库';
comment on column QUESTION.qid
  is '考题编号';
comment on column QUESTION.qtype
  is '考题类型 1:单选 2:多选 3:判断 4:简答 5:编程';
comment on column QUESTION.course
  is '课程名称';
comment on column QUESTION.keya
  is '选项A';
comment on column QUESTION.keyb
  is '选项B';
comment on column QUESTION.keyc
  is '选项C';
comment on column QUESTION.keyd
  is '选项D';
comment on column QUESTION.ques
  is '考题题目';
comment on column QUESTION.answer
  is '考题答案';

prompt Creating RECORDTEST...
create table RECORDTEST
(
  userid    VARCHAR2(11) not null,
  course    VARCHAR2(50) not null,
  score     NUMBER not null,
  singlec   NUMBER not null,
  multiplyc NUMBER not null,
  judge     NUMBER not null,
  jd        NUMBER not null,
  program   NUMBER not null,
  test_time VARCHAR2(15)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table RECORDTEST
  is '测试成绩';
comment on column RECORDTEST.userid
  is '用户编号';
comment on column RECORDTEST.course
  is '测试课程';
comment on column RECORDTEST.score
  is '测试分数';
comment on column RECORDTEST.singlec
  is '单选题得分';
comment on column RECORDTEST.multiplyc
  is '多选题得分';
comment on column RECORDTEST.judge
  is '判断题得分';
comment on column RECORDTEST.jd
  is '简答题得分';
comment on column RECORDTEST.program
  is '编程题得分';

prompt Creating TEST...
create table TEST
(
  userid    VARCHAR2(11),
  qid       NUMBER,
  answer    VARCHAR2(3000),
  course    VARCHAR2(20),
  score     NUMBER,
  qtype     NUMBER,
  tnumber   NUMBER,
  test_time VARCHAR2(15)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table TEST
  is '试卷';
comment on column TEST.userid
  is '用户编号（考生）';
comment on column TEST.qid
  is '题目编号';
comment on column TEST.answer
  is '考生答案';
comment on column TEST.course
  is '考试课程';
comment on column TEST.score
  is '该题得分';
comment on column TEST.qtype
  is '题目类型';
comment on column TEST.tnumber
  is '试卷第几题';

prompt Creating TEST_SET...
create table TEST_SET
(
  course    VARCHAR2(20) not null,
  sinc      NUMBER not null,
  persin    NUMBER not null,
  mulc      NUMBER not null,
  permul    NUMBER not null,
  judge     NUMBER not null,
  perju     NUMBER not null,
  jd        NUMBER not null,
  perjd     NUMBER not null,
  program   NUMBER not null,
  perpro    NUMBER not null,
  totaltime NUMBER not null,
  test_time VARCHAR2(15)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table TEST_SET
  is '考试设置表';
comment on column TEST_SET.course
  is '课程';
comment on column TEST_SET.sinc
  is '单选题数';
comment on column TEST_SET.persin
  is '每个单选题分值';
comment on column TEST_SET.mulc
  is '多选题数';
comment on column TEST_SET.permul
  is '每个多选题分值';
comment on column TEST_SET.judge
  is '判断题数';
comment on column TEST_SET.perju
  is '每道判断题分值';
comment on column TEST_SET.jd
  is '简单题数';
comment on column TEST_SET.perjd
  is '每道简答题分值';
comment on column TEST_SET.program
  is '编程题数';
comment on column TEST_SET.perpro
  is '每道编程题分值';
comment on column TEST_SET.totaltime
  is '考试时间';

prompt Creating USERFLAG...
create table USERFLAG
(
  userid    VARCHAR2(11),
  course    VARCHAR2(20),
  flag      VARCHAR2(1),
  test_time VARCHAR2(15)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on table USERFLAG
  is '考生标记表';
comment on column USERFLAG.userid
  is '用户编号';
comment on column USERFLAG.course
  is '考试课程';
comment on column USERFLAG.flag
  is '考试状态 0:试卷未提交 1:试卷已提交';

prompt Creating USERINFO...
create table USERINFO
(
  userid   VARCHAR2(11),
  utype    NUMBER,
  name     VARCHAR2(50),
  password VARCHAR2(40),
  sex      VARCHAR2(2) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column USERINFO.userid
  is '用户编号';
comment on column USERINFO.utype
  is '用户类型 1:学生 2:教师 3:管理员';
comment on column USERINFO.name
  is '用户姓名';
comment on column USERINFO.password
  is '用户密码';
comment on column USERINFO.sex
  is '用户性别';

prompt Disabling triggers for QUESTION...
alter table QUESTION disable all triggers;
prompt Disabling triggers for RECORDTEST...
alter table RECORDTEST disable all triggers;
prompt Disabling triggers for TEST...
alter table TEST disable all triggers;
prompt Disabling triggers for TEST_SET...
alter table TEST_SET disable all triggers;
prompt Disabling triggers for USERFLAG...
alter table USERFLAG disable all triggers;
prompt Disabling triggers for USERINFO...
alter table USERINFO disable all triggers;
prompt Deleting USERINFO...
delete from USERINFO;
commit;
prompt Deleting USERFLAG...
delete from USERFLAG;
commit;
prompt Deleting TEST_SET...
delete from TEST_SET;
commit;
prompt Deleting TEST...
delete from TEST;
commit;
prompt Deleting RECORDTEST...
delete from RECORDTEST;
commit;
prompt Deleting QUESTION...
delete from QUESTION;
commit;
prompt Loading QUESTION...
prompt Table is empty
prompt Loading RECORDTEST...
prompt Table is empty
prompt Loading TEST...
prompt Table is empty
prompt Loading TEST_SET...
prompt Table is empty
prompt Loading USERFLAG...
prompt Table is empty
prompt Loading USERINFO...
insert into USERINFO (userid, utype, name, password, sex)
values ('admin', 3, '超级管理员', '21232f297a57a5a743894a0e4a801fc3', '女');
commit;
prompt 1 records loaded
prompt Enabling triggers for QUESTION...
alter table QUESTION enable all triggers;
prompt Enabling triggers for RECORDTEST...
alter table RECORDTEST enable all triggers;
prompt Enabling triggers for TEST...
alter table TEST enable all triggers;
prompt Enabling triggers for TEST_SET...
alter table TEST_SET enable all triggers;
prompt Enabling triggers for USERFLAG...
alter table USERFLAG enable all triggers;
prompt Enabling triggers for USERINFO...
alter table USERINFO enable all triggers;
set feedback on
set define on
prompt Done.
