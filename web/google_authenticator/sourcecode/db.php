<?php

//including the Mysql connect parameters.

$dbuser ='root';
$dbpass ='PULNSuv2kysH5$';
$dbname ="actf_is_fun";
$host = 'localhost';

@error_reporting(0);
$con = mysqli_connect($host,$dbuser,$dbpass,$dbname);
// Check connection
if(!$con){
    echo mysqli_connect_error();
}
?>