<html>
    <head>
        <title>Login</title>
    </head>
<body>
    <center>
        <form action="index.php" method="POST">
            <br><br>
            <input type="text" name="username" placeholder="username"><br><br>
            <input type="password" name="password" placeholder="password"><br><br>
            <input type="submit" value="submit"><br>
        </form>
        </center>
</body>

</html>

<?php
include("db.php");
error_reporting(0);
if(isset($_POST['username']) && isset($_POST['password']))
{
    $username=$_POST['username'];
    $password=$_POST['password'];

    $sql="SELECT * FROM users WHERE `username`='$username' and `password`='$password' LIMIT 0,1";
    $result=mysqli_query($con,$sql);
    $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
	if($row)
	{
        echo "/google_authenticator.php";
  	}
	else 
	{
        echo '<font color= "#00000">';
        print_r(mysqli_error($con));
        echo "</font>";  
	}
}else{

}

?>