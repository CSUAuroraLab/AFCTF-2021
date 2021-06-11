<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./static/main.css">
    <title>LOGIN / REGISTER</title>
</head>
<body>
<%
    application.setAttribute("adminsecret", "flag{you_f1nd_adm1n_3ecret!}");
    application.setAttribute("admin", "aqwfh9iohqwfobnqwoefnwqef");
    Random rand = new Random();
    String msg = String.valueOf(rand.nextInt(100000 - 1000) + 1 + 1000);
    MessageDigest md5 = MessageDigest.getInstance("MD5");
    md5.update(msg.getBytes());
    byte[] byteArray = md5.digest();
    BigInteger bigInt = new BigInteger(1, byteArray);
    String result = bigInt.toString(16);
    while(result.length() < 32) {
        result = "0" + result;
    }
    session.setAttribute("code", result.substring(0,6));
%>
<div class="login-box">
    <h2>Login&nbsp;&nbsp;/&nbsp;&nbsp;Register</h2>
    <form action="./login.jsp" method="POST">
        <div class="login-field">
            <input type="text" name="username" required="">
            <label>username</label>
        </div>
        <div class="login-field">
            <input type="password" name="password" required="">
            <label>password</label>
        </div>
        <div class="login-field">
            <input type="text" name="captcha" required="" placeholder="md5(code)[0:6] = <%=session.getAttribute("code")%>">
            <label>captcha</label>
        </div>
        <button type="submit" name="submit" value="login">Login</button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button type="submit" name="submit" value="register">Register</button>
    </form>
</div>
</body>
</html>