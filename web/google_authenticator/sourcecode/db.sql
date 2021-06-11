create database actf_is_fun;
use actf_is_fun;
create table if not exists `users`(
   `id` INT UNSIGNED AUTO_INCREMENT,
   `username` VARCHAR(40) NOT NULL,
   `password` VARCHAR(40) NOT NULL,
   `otp_secret_key` VARCHAR(1000) NOT NULL,
   PRIMARY KEY ( `id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
insert into users values(1,"admin","hgMMDHmE6qn#U9","eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZWNyZXQiOiJJRkJWSVJTN01KU1hJNURGT0pQV0MzVEVMNVJHSzVEVU1WWkNDSUpCIiwiaWF0IjoxNTE2MjM5MDIyfQ.AQSSxyPihDP8dhVEMpaWrSv2scrEEc2HOmqfAwXqWLY");
