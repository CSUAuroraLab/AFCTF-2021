#!/bin/bash

service mysql start && mysql -e "create database ry"
mysql ry < "/home/sql/quartz.sql"
mysql ry < "/home/sql/ry_20190215.sql" 
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');"
