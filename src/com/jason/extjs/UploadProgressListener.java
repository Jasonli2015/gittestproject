package com.jason.extjs;

import java.text.NumberFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;

/**
 * 文件上传进度监听类
 * */
public class UploadProgressListener implements ProgressListener {//要继承ProgressListener
	private double megaBytes = -1;  
    private HttpSession session;  
    public UploadProgressListener(HttpServletRequest request) {  
        session = request.getSession();  
    }  
    public void update(long pBytesRead, long pContentLength, int pItems) {  
        double mBytes = pBytesRead / 1000000;  
        double total = pContentLength / 1000000;  
           if (megaBytes == mBytes) {  
               return;  
           }  
           System.out.println("total====>"+total);  
           System.out.println("mBytes====>"+mBytes);  
           megaBytes = mBytes;  
           System.out.println("megaBytes====>"+megaBytes);  
           System.out.println("We are currently reading item " + pItems);  
           if (pContentLength == -1) {  
               System.out.println("So far, " + pBytesRead + " bytes have been read.");  
           } else {  
               System.out.println("So far, " + pBytesRead + " of " + pContentLength + " bytes have been read.");  
               double read = (mBytes / total);  
               NumberFormat nf = NumberFormat.getPercentInstance();  
               System.out.println("生成读取的百分比 并放入session中===>" + nf.format(read));
               //生成读取的百分比 并放入session中  
               session.setAttribute("readPrcnt", nf.format(read));  
           }  
    }  
}