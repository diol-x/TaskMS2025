create table if not exists menu
(
    id             int          not null
        primary key,
    menuCode       varchar(8)   null comment '菜单编码',
    menuName       varchar(16)  null comment '菜单名字',
    menuLevel      varchar(2)   null comment '菜单级别',
    menuParentCode varchar(8)   null comment '菜单的父code',
    menuClick      varchar(16)  null comment '点击触发的函数',
    menuRight      varchar(8)   null comment '权限 0系统管理员，1表示主管，2表示员工，可以用逗号组合使用',
    menuComponent  varchar(200) null,
    menuIcon       varchar(100) null
)
    charset = utf8mb3;

create table if not exists task
(
    id            bigint auto_increment comment '主键'
        primary key,
    title         varchar(100)                       not null comment '任务标题',
    description   text                               null comment '任务描述',
    status        int      default 0                 not null comment '状态 0：未开始，1：分析设计，2：基本搭建，3：项目开发，4：测试，5：完成',
    creator_id    bigint                             not null comment '创建人（主管）',
    assignee_name bigint                             not null comment '被分配人（员工）',
    create_time   datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    deadline      datetime                           null comment '截止时间'
)
    comment '任务表';

create index idx_assignee_id
    on task (assignee_name);

create index idx_creator_id
    on task (creator_id);

create table if not exists task_comment
(
    id          bigint auto_increment comment '主键'
        primary key,
    task_id     bigint                             not null comment '任务ID',
    user_id     bigint                             not null comment '评论人',
    content     text                               not null comment '评论内容',
    create_time datetime default CURRENT_TIMESTAMP not null comment '评论时间'
)
    comment '任务评论表';

create index idx_task_id
    on task_comment (task_id);

create index idx_user_id
    on task_comment (user_id);

create table if not exists user
(
    id       int auto_increment comment '主键'
        primary key,
    no       varchar(20)            null comment '账号',
    name     varchar(100)           not null comment '名字',
    password varchar(20)            not null comment '密码',
    age      int                    null,
    sex      int                    null comment '性别',
    phone    varchar(20)            null comment '电话',
    role_id  int                    null comment '角色 0系统管理员，1主管，2员工',
    isValid  varchar(4) default 'Y' null comment '是否有效，Y有效，其他无效'
)
    charset = utf8mb3;

