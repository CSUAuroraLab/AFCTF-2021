<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./static/main.css">
    <title>PROFILE</title>
    <script>
        function getsecret() {
            var xmlhttp;
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            } else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    document.getElementById("secret").innerHTML = xmlhttp.responseText;
                }
            }
            xmlhttp.open("GET","./secret.jsp",true);
            xmlhttp.send();
        }
    </script>
</head>
<body>
<p class="secret-box" onclick="getsecret()" id="secret">Secret</p>
</body>
</html>