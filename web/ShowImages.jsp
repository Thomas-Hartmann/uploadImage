<%-- 
    Document   : ShowImages
    Created on : Apr 19, 2016, 3:34:05 PM
    Author     : tha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Show images!</h1>
        <img src="<% out.print(request.getContextPath()); %>/ShowImage?imgno=1">
        <img src="<% out.print(request.getContextPath()); %>/ShowImage?imgno=2">
    </body>
</html>
