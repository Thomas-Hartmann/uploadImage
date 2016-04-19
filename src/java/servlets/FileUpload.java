/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

//import org.apache.commons.io.*;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author tha
 */
@WebServlet(name = "FileUpload", urlPatterns = {"/FileUpload"})
public class FileUpload extends HttpServlet {

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    @Override
    public void init() throws ServletException {
        ServletContext context = this.getServletConfig().getServletContext();
        File repos = (File) context.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repos);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            List<FileItem> items = null;
            Iterator<FileItem> iterator = null;
            try {
                //This is the magic:
                items = upload.parseRequest(request);
                iterator = items.iterator();
            } catch (FileUploadException ex) {
                System.out.println(ex.getMessage());
            }
            while (iterator.hasNext()) {
                FileItem item = iterator.next();
                String name = item.getName();

                if (item.isFormField()) {
                    //processFormField(item);
                    System.out.println("Form field: " + name + " contains: " + item.getString());
                } else {
                    upload2Disk(item, request);
                }
            }
        } else {
            throw new ServletException("is not multipart content");
        }
    }
    private void upload2DB(FileItem item, HttpServletRequest request){
        
    }
    private void upload2Disk(FileItem item, HttpServletRequest request) {
        String fieldName = item.getFieldName();
        String fileName = item.getName();
        String contentType = item.getContentType();
        boolean isInMemory = item.isInMemory();
        long sizeInBytes = item.getSize();
        System.out.println(fieldName + " file: "+ fileName +" contentType: "+ contentType +" size in bytes: "+sizeInBytes);
        String name = request.getServletContext().getAttribute("FILES_DIR")+File.separator+item.getName();
        //File file = new File(request.getServletContext().getAttribute("FILES_DIR")+File.separator+item.getName());
	//System.out.println("Absolute Path at server="+file.getAbsolutePath());
        System.out.println("Location ON SERVER: "+name);
        
        name = name.substring(0, name.lastIndexOf("null"))+"uploads"+File.separator+item.getName();
        File file = new File(name);
        System.out.println("Full path: "+file.getAbsolutePath());
        try {
            item.write(file);
        } catch (Exception ex) {
            System.out.println("Fejl i item.write: "+ex.getMessage());        }
    }
}