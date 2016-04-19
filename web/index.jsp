<%-- 
    Document   : index
    Created on : 08-04-2015, 09:40:11
    Author     : tha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Testing file upload</title>
    </head>
    <body>
        <form name="uploadForm" action="FileUpload" method="POST" enctype="multipart/form-data">
            <input type="text" name="testname" value="" />
            <input type="file" name="fileSelect" value="" width="50" />
            <input type="submit" value="Submit" name="submit" />
        </form>
    </body>
</html>
