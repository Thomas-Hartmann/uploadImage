package usingdb;

import java.io.InputStream;

/**
 *
 * @author tha
 */
public class Tester {

    private static ImageMapper im = new ImageMapper();
    public static void main(String[] args) {
        Tester t = new Tester();
        //t.insertImgs();
        byte[] bytes = t.getBytes(1);
        
    }
    public InputStream getImage(int imgno){
        InputStream is = im.getImgAsStream(imgno);
        return is;
    }
    public byte[] getBytes(int imgno){
        byte[] bytes = im.getImgAsBytes(imgno);
        return bytes;
    }
    
    public void insertImgs(){
        im.insertImg("C:/Uploads/evaluation.jpg", "evaluation");
        im.insertImg("C:/Uploads/delayed.jpg", "delayed");
    }
}
