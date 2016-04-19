package usingdb;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author tha
 */
public class ImageMapper {

    private Connection conn = DB.getConnection();

    public void insertImg(String path, String name) {

        ResultSet rs = null;
        PreparedStatement psmnt = null;
        FileInputStream fis;
        try {
            File image = new File(path);

            psmnt = conn.prepareStatement("insert into save_image(name, image) " + "values(?,?)");
            psmnt.setString(1, name);
            fis = new FileInputStream(image);
            psmnt.setBinaryStream(2, (InputStream) fis, (int)(image.length()));
            int s = psmnt.executeUpdate();
            
            if (s > 0) {
                System.out.println("image uploaded successfully !");
            } else {
                System.out.println("error in upload image.");
            }
        } 
        catch (Exception ex) {
            System.out.println("Found some error : ");
            ex.printStackTrace();
        } finally {
            DB.close(psmnt, null, null);
        }
    }
    public File getImgAsFile(int imgno){
        File file = new File("test.jpg");
        BufferedOutputStream bout = null;
        try {
            OutputStream out = new FileOutputStream(file);
            bout = new BufferedOutputStream(out);
            bout.write(getImgAsBytes(imgno));
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        finally{
            if(bout != null) try {
                bout.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return file;
    }
    
    public InputStream getImgAsStream(int imgno) {
        Blob image = null;
        int size;
        InputStream in = null;
        byte[] imgData = null;
        
        try {
            String sql = "SELECT image FROM save_image WHERE id = ?";
            PreparedStatement pstmt = DB.getConnection().prepareStatement(sql);
            pstmt.setInt(1, imgno);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                image = rs.getBlob(1);
                size = (int)image.length(); // number of bytes
                in = image.getBinaryStream(); //inputstream
                
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return in;
    }
    public byte[] getImgAsBytes(int imgno) {
        Blob image = null;
        int size;
        InputStream in = null;
        byte[] imgData = null;
        
        try {
            String sql = "SELECT image FROM save_image WHERE id = ?";
            PreparedStatement pstmt = DB.getConnection().prepareStatement(sql);
            pstmt.setInt(1, imgno);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                image = rs.getBlob(1);
                size = (int)image.length(); // number of bytes
                in = image.getBinaryStream(); //inputstream
                imgData = image.getBytes(1,size);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return imgData;
    }
}
