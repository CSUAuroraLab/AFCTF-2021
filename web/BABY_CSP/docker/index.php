<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BABY CSP</title>
</head>

<body>
    <a href='#' id="btn">whe3e are y0u fr0m?</a>
</body>
<?php
    include("./config.php");
    header("Content-Security-Policy: default-src 'none';script-src 'nonce-$secret'");
    echo "<script nonce=$secret>
    btn.onclick = () => {
    location = './?school=' + encodeURIComponent(['CSU', 'JXNU', 'HEBNU', 'I don\'t konw :( '][Math.floor(4 * Math.random())]);
    }
    </script>";
    if (isset($_GET['school'])) {
        if (preg_match("/<script nonce=['\"]?29de6fde0db5686d['\"]?>alert\(flag\)[;]?<\/script>/", $_GET['school'])) {
            $flag = file_get_contents("/flag");
            echo "<script nonce=29de6fde0db5686d>alert('".$flag."')</script>";
        } else {
            echo "<p>" . $_GET['school'] . "!</p>";
        }
    }
?>

</html>