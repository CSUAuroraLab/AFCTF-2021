<html>
    <head>
        <title>Login</title>
    </head>
<body>
    <center>
        <form action="" method="POST">
            <br><br>
            <lable>请输入谷歌身份验证码</lable><br><br>
            <input type="text" name="code" placeholder="code"><br><br>
            <input type="submit" value="submit"><br><br>
        </form>
        </center>
</body>

</html>

<?php
require_once(dirname(__FILE__).'/rfc6238/rfc6238.php');

const secretkey = 'IFBVIRS7MJSXI5DFOJPWC3TEL5RGK5DUMVZCCIJB';

if(isset($_POST['code']))
{
    $code=intval($_POST['code']);
    if (TokenAuth6238::verify(secretkey,$code)) {
        echo "<center>/955437022c63d658b5dda45d33692b9f.php</center>";
    }else{
        echo "<center>error</center>";
    }

}else{

}

?>