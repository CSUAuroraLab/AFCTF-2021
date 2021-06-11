<%@ page import="java.util.Random" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGIN</title>
</head>
<body>
    <%
        String username, password, code;
        username = request.getParameter("username");
        password = request.getParameter("password");
        code = request.getParameter("captcha");
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(code.getBytes());
        byte[] byteArray = md5.digest();
        BigInteger bigInt = new BigInteger(1, byteArray);
        String result = bigInt.toString(16);
        while(result.length() < 32) {
            result = "0" + result;
        }
        if (session.getAttribute("code").equals(result.substring(0,6))) {
            if (request.getParameter("submit").equals("login")) {
                if (application.getAttribute(username) == null) {
                    out.print("<script>alert('用户不存在！');window.location.replace('./index.jsp');</script>");
                } else if (application.getAttribute(username).equals(password)) {
                    String res = "";
                    Random rand = new Random();
                    for (int i = 0 ; i < username.length() ; i++) {
                        if (Integer.valueOf(username.charAt(i)) % 2 == 0) {
                            res += (char) (Integer.valueOf(username.charAt(i)) + 2);
                        } else {
                            res += (char) (Integer.valueOf(username.charAt(i)) - 2);
                        }
                        res += (char) (rand.nextInt(126 - 32) + 1 + 32);
                    }
                    Cookie cookie = new Cookie("usr", java.net.URLEncoder.encode(res));
                    response.addCookie(cookie);
                    out.print("<script>alert('登录成功！');window.location.replace('./profile.jsp');</script>");
                } else {
                    out.print("<script>alert('用户名或密码错误！');window.location.replace('./index.jsp');</script>");
                }
            } else if (request.getParameter("submit").equals("register")) {
                if (application.getAttribute(username) == null) {
                    application.setAttribute(username, password);
                    out.print("<script>alert('注册成功！');window.location.replace('./index.jsp');</script>");
                } else {
                    out.print("<script>alert('用户已存在！');window.location.replace('./index.jsp');</script>");
                }
            }
        } else {
            out.print("<script>alert('验证码错误！');window.location.replace('./index.jsp');</script>");
        }
    %>
</body>
</html>
