<%-- 
    Document   : FormUpload
    Created on : 11-04-2015, 17:55:10
    Author     : tha
    Purpose    : To show how to extract a file from the HTTPrequest object and save it to a folder
                 And to show how to work with methods in jsp file
--%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Playing with HTTP request</title>
        <style>
            .container{
                white-space: pre;
                border : 2px solid black;
                margin : 50px;
                width  : 700px;
                overflow: hidden;
            }
        </style>
    </head>
    <body>
        <%!
            //These are made Global in order to track them on the webpage.
            String file = "";
            String saveFile = "";
            String contentType = "";
            String content = "";
            String boundary = "";
            String path = "C:/Uploads/";
            byte[] dataBytes = null;

            String extractFile(HttpServletRequest request) {
                contentType = request.getContentType();
                if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
                    try {
                        DataInputStream inputStream = new DataInputStream(request.getInputStream());
                        int formDataLength = request.getContentLength(); //the body of the httprequest in number of bytes
                        dataBytes = new byte[formDataLength];
                        int byteRead = 0;
                        int totalBytesRead = 0;
                        while (totalBytesRead < formDataLength) {
                            byteRead = inputStream.read(dataBytes, totalBytesRead, formDataLength); //parameters: (byte[] to store the bytes read, the index of the bytearray from where to start storing, the number of bytes to read).
                            totalBytesRead += byteRead;
                        }
                        file = new String(dataBytes); //byte[] to String see what is in the body of the HTTP request.
                    } catch (Exception e) {

                    }
                }
                return file;
            }

            String getFileName(String fil) {
                // Get the name of the file
                //System.out.println("FIL: "+fil);
                int index = fil.indexOf("filename=\"");
                //System.out.println("index: "+index);
                    saveFile = fil.substring(index); 
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n")); //filename="test.txt"
                    saveFile = saveFile.substring(saveFile.indexOf("\"") + 1, saveFile.lastIndexOf("\"")); // test.txt
                    return saveFile;
            }

            String getContent(String file) {
             boundary = contentType.substring(contentType.lastIndexOf("=") + 1, contentType.length());
                    int pos;
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    //pos = file.indexOf("\n", pos) +1;   
                    pos = file.indexOf("\n", pos) + 1;   //the last newline before the content
                    int boundaryLocation = file.indexOf(boundary, pos);
                    boundaryLocation = file.lastIndexOf("\n", boundaryLocation);
                    int startPos = (file.substring(0, pos)).getBytes().length;
                    int endPos = (file.substring(0, boundaryLocation)).getBytes().length;
                    content = file.substring(startPos, endPos);
                    writeFile(startPos, endPos - startPos);
                    return content;
            }
            void writeFile(int start, int length){
                path += saveFile;
                    File file2Save = new File(path);
                    try {
                        FileOutputStream output = new FileOutputStream(file2Save);
                        output.write(dataBytes, start, length);
                        output.flush();
                        output.close();
                    } catch (Exception e) {
                    }
            }
        %>
        <h1>Playing with HTTP Request and with file upload</h1>
        <form name="Form1" action="FormUpload.jsp" method="POST" enctype="multipart/form-data">
            <%
                /*
                saveFile = new String();
                contentType = request.getContentType();
                if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
                    DataInputStream inputStream = new DataInputStream(request.getInputStream());
                    int formDataLength = request.getContentLength(); //the body of the httprequest in number of bytes
                    byte[] dataBytes = new byte[formDataLength];
                    int byteRead = 0;
                    int totalBytesRead = 0;
                    while (totalBytesRead < formDataLength) {
                        byteRead = inputStream.read(dataBytes, totalBytesRead, formDataLength); //parameters: (byte[] to store the bytes read, the index of the bytearray from where to start storing, the number of bytes to read).
                        totalBytesRead += byteRead;
                    }
                    file = new String(dataBytes); //byte[] to String see what is in the body of the HTTP request.

                    // Get the name of the file
                    saveFile = file.substring(file.indexOf("filename=\""));
                    saveFile = saveFile.substring(0, saveFile.indexOf("\n")); //filename="test.txt"
                    saveFile = saveFile.substring(saveFile.indexOf("\"") + 1, saveFile.lastIndexOf("\"")); // test.txt

                    // Get the content of the file:
                    boundary = contentType.substring(contentType.lastIndexOf("=") + 1, contentType.length());
                    int pos;
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    //pos = file.indexOf("\n", pos) +1;   
                    pos = file.indexOf("\n", pos) + 1;   //the last newline before the content
                    int boundaryLocation = file.indexOf(boundary, pos);
                    boundaryLocation = file.lastIndexOf("\n", boundaryLocation);
                    int startPos = (file.substring(0, pos)).getBytes().length;
                    int endPos = (file.substring(0, boundaryLocation)).getBytes().length;
                    content = file.substring(startPos, endPos);

                    //Write content to new file
                    path += saveFile;
                    File file2Save = new File(path);
                    try {
                        FileOutputStream output = new FileOutputStream(file2Save);
                        output.write(dataBytes, startPos, endPos - startPos);
                        output.flush();
                        output.close();
                    } catch (Exception e) {
                    }

                }*/
            %>
            <input type="text" name="text1" value="Dette er min tekst" />
            <input type="file" name="fileSelect" value="" />
            <input type="submit" value="Submit" name="submit" />

        </form>
            <!--Nedenfor udtrækkes oplysningerne fra den nyligt oprettede request.-->
        <div class="container">File: <% file = extractFile(request); out.write(file); %></div>
        <div class="container">saveFile: <% if(file.length() > 0){out.write(getFileName(file)); }%></div>
        <div class="container">boundary: <% out.write(""); %></div>
        <div class="container">content: <% if(file.length() > 0){out.write(getContent(file));} %></div>
        <div class="container">path: <% out.write(path);%></div>
    </body>
</html>
