-- 角色表jiang
create table t_role
(
  role_id   int primary key auto_increment,--角色编号，主键序列
  role_name varchar(20) not null, --角色名称
  role_desc varchar(30) not null --角色描述
);

--员工表
create table t_employee
(
  employee_id   int primary key auto_increment, --员工编号，主键序列
  employee_name varchar(20) not null, --用户名称，
  password      varchar(10) not null, --密码，
  real_name     varchar(20) not null, --真实姓名，
  sex           varchar(4)  not null, --性别
  birthday      timestamp, --出生年月
  duty          varchar(30) not null, --职位信息
  enrolldate    timestamp   not null, --入职时间
  education     varchar(30) not null, --学历信息
  major         varchar(30) not null, --专业信息
  experience    varchar(30) not null, --行业经验
  role_id       int, --外键，所属角色，引用角色编号
  parent_id     int, --外键，主管，引用员工编号
  foreign key (role_id) references t_role (role_id)
);

--任务表
create table t_task
(
  task_id         int primary key auto_increment, --任务编号，主键序列
  task_name       varchar(50), --任务名称
  begin_date      timestamp, --开始时间
  end_date        timestamp, --结束时间
  real_begin_date timestamp, --实际开始时间
  real_end_date   timestamp, --实际结束时间
  status          varchar(10), --任务状态
  implementor_id  int, --外键，实施人编号，引用员工编号
  assigner_id     int, --外键，分配人编号，引用员工编号
  task_desc       varchar(100), --任务描述
  foreign key (implementor_id) references t_employee (employee_id),
  foreign key (assigner_id) references t_employee (employee_id)
);

--计划表
create table t_plan
(
  plan_id       int primary key auto_increment, --计划编号，主键序列
  plan_name     varchar(50), --计划名称
  status        varchar(10), --计划状态
  is_feedback   varchar(5), --已反馈未反馈反馈
  begin_date    timestamp, --开始时间
  end_date      timestamp, --结束时间
  task_id       int, --外键，所属任务，引用任务编号
  feedback_info varchar(100), --反馈信息
  plan_desc     varchar(100), --计划描述
  foreign key (task_id) references t_task (task_id)
);


insert into t_role (role_id, role_name, role_desc)
values (2, '系统管理员', '系统管理员');
insert into t_role (role_id, role_name, role_desc)
values (3, '主管', '主管');
insert into t_role (role_id, role_name, role_desc)
values (4, '员工', '员工');


insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (7, 'zhangsan', '123456', '张三', '男', date_format('1998-09-12', '%Y-%m-%d'), '初级工程师',
        date_format('2008-12-01', '%Y-%m-%d'), '大学', '计算机', '2年', 4, 8);
insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (8, 'lisi', '123456', '李四', '女', date_format('1999-05-12', '%Y-%m-%d'), '高级工程师',
        date_format('2006-04-12', '%Y-%m-%d'), '大学', '计算机', '4年', 3, null);
insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (9, 'zhaoliu', '123456', '赵六', '女', date_format('2000-05-12', '%Y-%m-%d'), '初级工程师',
        date_format('2009-05-12', '%Y-%m-%d'), '大学', '计算机', '2年', 2, 8);
insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (10, 'wangwu', '123456', '王五', '男', date_format('1999-08-12', '%Y-%m-%d'), '中级工程师',
        date_format('2008-04-18', '%Y-%m-%d'), '大学', '计算机', '5年', 4, 8);
insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (11, 'tianqi', '123456', '田七', '男', date_format('2000-03-15', '%Y-%m-%d'), '高级工程师',
        date_format('2007-06-17', '%Y-%m-%d'), '大学', '计算机', '4年', 3, null);
insert into t_employee (employee_id, employee_name, password, real_name, sex, birthday, duty, enrolldate, education,
                        major, experience, role_id, parent_id)
values (12, 'xiaohong', '123456', '小红', '女', date_format('2000-07-18', '%Y-%m-%d'), '初级工程师',
        date_format('2007-09-27', '%Y-%m-%d'), '大学', '计算机', '2年', 4, 11);


insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (1, '任务1', date_format('2012-01-23', '%Y-%m-%d'), date_format('2014-12-13', '%Y-%m-%d'),
        date_format('2012-01-27', '%Y-%m-%d'), date_format('2015-01-01', '%Y-%m-%d'), '已完成', 7, 8, null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (2, '任务2', date_format('2012-06-23', '%Y-%m-%d'), date_format('2014-10-23', '%Y-%m-%d'),
        date_format('2012-06-29', '%Y-%m-%d'), null, '实施中', 7, 8, null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (3, '任务3', date_format('2014-06-23', '%Y-%m-%d'), date_format('2015-10-23', '%Y-%m-%d'), null, null, '未实施', 7, 8,
        null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (4, '任务4', date_format('2014-06-24', '%Y-%m-%d'), date_format('2015-09-23', '%Y-%m-%d'), null, null, '未实施', 10,
        8, null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (5, '任务5', date_format('2013-03-14', '%Y-%m-%d'), date_format('2013-09-11', '%Y-%m-%d'),
        date_format('2013-03-15', '%Y-%m-%d'), date_format('2013-08-01', '%Y-%m-%d'), '已完成', 12, 11, null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (6, '任务6', date_format('2013-03-14', '%Y-%m-%d'), date_format('2015-10-13', '%Y-%m-%d'),
        date_format('2013-04-14', '%Y-%m-%d'), null, '实施中', 12, 11, null);
insert into t_task (task_id, task_name, begin_date, end_date, real_begin_date, real_end_date, status, implementor_id,
                    assigner_id, task_desc)
values (7, '任务7', date_format('2014-04-18', '%Y-%m-%d'), date_format('2015-12-12', '%Y-%m-%d'), null, null, '未实施', 12,
        11, null);

insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (1, '计划1_1', '已完成', '已反馈', date_format('2012-01-27', '%Y-%m-%d'), date_format('2012-09-30', '%Y-%m-%d'), 1,
        '计划1_1顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (2, '计划1_2', '已完成', '已反馈', date_format('2012-10-03', '%Y-%m-%d'), date_format('2013-01-01', '%Y-%m-%d'), 1,
        '计划1_2顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (3, '计划1_3', '已完成', '已反馈', date_format('2013-02-01', '%Y-%m-%d'), date_format('2015-01-01', '%Y-%m-%d'), 1,
        '计划1_3顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (4, '计划5_1', '已完成', '已反馈', date_format('2013-03-15', '%Y-%m-%d'), date_format('2013-05-27', '%Y-%m-%d'), 5,
        '计划5_1顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (5, '计划5_2', '已完成', '已反馈', date_format('2013-05-28', '%Y-%m-%d'), date_format('2013-08-01', '%Y-%m-%d'), 5,
        '计划5_2顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (6, '计划2_1', '已完成', '已反馈', date_format('2012-06-30', '%Y-%m-%d'), date_format('2013-04-01', '%Y-%m-%d'), 2,
        '计划2_1顺利完成', null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (7, '计划2_2', '未实施', '未反馈', null, null, 2, null, null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (8, '计划2_3', '未实施', '未反馈', null, null, 2, null, null);
insert into t_plan (plan_id, plan_name, status, is_feedback, begin_date, end_date, task_id, feedback_info, plan_desc)
values (9, '计划6_1', '未实施', '未反馈', null, null, 2, null, null);


