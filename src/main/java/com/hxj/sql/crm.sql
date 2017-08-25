DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm;
USE crm;

DROP TABLE IF EXISTS t_car;
CREATE TABLE t_car(
  cId INT PRIMARY KEY AUTO_INCREMENT,
  cName VARCHAR(20) NOT NULL, -- 汽车品牌名称
  cInfo TEXT, -- 品牌描述
  pubTime DATE -- 品牌发布时间
);

DROP TABLE IF EXISTS t_customer;
CREATE TABLE t_customer(
  cusId INT PRIMARY KEY AUTO_INCREMENT,
  cusLoginName VARCHAR(20) NOT NULL UNIQUE ,
  cusLoginPass VARCHAR(20),
  cusName VARCHAR(20) NOT NULL,
  cusGender INT DEFAULT 0, -- 性别 0(男) 1(女)
  cusAge INT,
  cusProvince VARCHAR(20), -- 省份
  cusArea VARCHAR(50), -- 城市 区域
  cusPhone CHAR(11)
);

DROP TABLE IF EXISTS t_evaluate;
CREATE TABLE t_evaluate(
  eid INT PRIMARY KEY AUTO_INCREMENT,
  cusId INT, -- 客户id外键
  cId INT, -- 汽车品牌id外键
  attitude INT, -- 服务态度
  exterior INT, -- 外观设计
  trim INT, -- 内饰配置
  space INT -- 空间布局
);

DROP TABLE IF EXISTS t_manager;
CREATE TABLE t_manager(
  mid INT PRIMARY KEY AUTO_INCREMENT,
  mloginName VARCHAR(20) NOT NULL,
  mloginPass VARCHAR(50) NOT NULL
);



INSERT INTO t_customer(cusName, cusPass, cusGender, cusAge, cusProvince, cusArea, cusPhone)
    VALUES ('张三',"",0,23,'陕西省','西安市碑林区','137889023');
SELECT * FROM t_customer;


select
  SUM(CASE WHEN cusAge>=18 AND cusAge<=30 THEN 1 ELSE 0 END) AS '18～30',
  SUM(CASE WHEN cusAge>=31 AND cusAge<=40 THEN 1 ELSE 0 END) AS '31～40',
  SUM(CASE WHEN cusAge>=41 AND cusAge<=50 THEN 1 ELSE 0 END) AS '41～50',
  SUM(CASE WHEN cusAge>=51 AND cusAge<=60 THEN 1 ELSE 0 END) AS '51～60',
  SUM(CASE WHEN cusAge>=61 AND cusAge<=70 THEN 1 ELSE 0 END) AS '61～70'
from t_customer;

SELECT
  count(*),cusGender
FROM t_customer GROUP BY cusGender;

SELECT
  count(*),cusProvince
FROM t_customer GROUP BY cusProvince;

select
  SUM(CASE WHEN cusProvince='陕西' THEN 1 ELSE 0 END) AS '陕西',
  SUM(CASE WHEN cusProvince='河南' THEN 1 ELSE 0 END) AS '河南',
  SUM(CASE WHEN cusProvince='安徽' THEN 1 ELSE 0 END) AS '安徽',
  SUM(CASE WHEN cusProvince='山西' THEN 1 ELSE 0 END) AS '山西',
  SUM(CASE WHEN cusProvince='青海' THEN 1 ELSE 0 END) AS '青海',
  SUM(CASE WHEN cusProvince='内蒙古' THEN 1 ELSE 0 END) AS '内蒙古',
  SUM(CASE WHEN cusProvince='甘肃' THEN 1 ELSE 0 END) AS '甘肃',
  SUM(CASE WHEN cusProvince='四川' THEN 1 ELSE 0 END) AS '四川',
  SUM(CASE WHEN cusProvince='重庆' THEN 1 ELSE 0 END) AS '重庆',
  SUM(CASE WHEN cusProvince='山东' THEN 1 ELSE 0 END) AS '山东',
  SUM(CASE WHEN cusProvince='云南' THEN 1 ELSE 0 END) AS '云南',
  SUM(CASE WHEN cusProvince NOT IN ('陕西','河南','安徽','山西','青海','内蒙古','甘肃','四川','重庆','山东','云南') THEN 1 ELSE 0 END) AS '其他'
from t_customer;

insert into t_manager(mloginName,mloginPass) values('admin123','admin123');