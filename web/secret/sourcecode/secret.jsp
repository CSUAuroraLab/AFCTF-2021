<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%
    String name = "", username = "";
    Cookie[] cookies = request.getCookies();
    for (int i = 0 ; i < cookies.length ; i++) {
        if(cookies[i].getName().equals("usr")) {
            username = java.net.URLDecoder.decode(cookies[i].getValue());
            for (int j = 0 ; j <  username.length() ; j++) {
                if (j%2 == 0) {
                    if (Integer.valueOf(username.charAt(j)) % 2 == 0) {
                        name += (char) (Integer.valueOf(username.charAt(j)) - 2);
                    } else {
                        name += (char) (Integer.valueOf(username.charAt(j)) + 2);
                    }
                }
            }
        }
    }
    if (username.equals("")) {
        out.print("Plz login first!");
    } else {
        if (name.equals("admin")) {
            out.print(application.getAttribute("adminsecret"));
        } else {
            out.print("Only admin can read secret!");
        }
    }
%>
</body>
</html>
