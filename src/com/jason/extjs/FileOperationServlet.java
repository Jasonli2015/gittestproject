package com.jason.extjs;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class FileOperationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text.html;charset=utf-8");		
		
		SmartUpload su = new SmartUpload();
		
		//获得上传文件路径
		String url = "";
		String msg = "";
		try {
			//初始化
			su.initialize(this.getServletConfig(),req,resp);
			//设置每个文件最大长度
			su.setMaxFileSize(1024*1024*1024);
			//设置所有上传文件总长度
			su.setTotalMaxFileSize(1024*1024*1024*2);
			//设定允许上传的文件类型
			su.setAllowedFilesList("jpeg,jpg,png,JPEG,JPG,PNG");
			
			su.upload();
			
			StringBuffer filename = new StringBuffer();	
					
			//生成时间戳
			long time = System.currentTimeMillis();
			String second = String.valueOf(time);
			
			//通过file input的name属性获得文件名
			String uploadPath = su.getRequest().getParameter("imgFile");  
			
			filename.append(second).append("&").append(uploadPath);
			
			//获得文件保存的指定目录
			url = getServletContext().getRealPath("/")+"file"+java.io.File.separator + filename;
			//保存文件到指定目录
			su.getFiles().getFile(0).saveAs(url);
			
			msg = "{success:true,path:'" + url + "'}";
			
		} catch (SmartUploadException e) {
			msg = "{success:false,path:''}";
			e.printStackTrace();
		}
		
		PrintWriter pw = resp.getWriter();
		pw.println(msg);
		pw.flush();
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text.html;charset=utf-8");	
		
		String msg = req.getParameter("filename");
		
		msg = "{success:true,path:''}";
		
		PrintWriter pw = resp.getWriter();
		pw.println(msg);
		pw.flush();
		pw.close();
	}
	
}