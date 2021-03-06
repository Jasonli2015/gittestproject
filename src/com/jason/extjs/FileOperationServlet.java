package com.jason.extjs;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileOperationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		resp.setContentType("text.html;charset=utf-8");

		String msg = "";

		PrintWriter pw = resp.getWriter();
		pw.println(msg);
		pw.flush();
		pw.close();
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// 文件名中文乱码问题，可调用ServletUpLoader的setHeaderEncoding方法，或者设置request的setCharacterEncoding属性
		response.setCharacterEncoding("UTF-8");		
		
		// 判断上传表单是否为multipart/form-data类型
		boolean isMultipart = ServletFileUpload.isMultipartContent(request); 
		
		if (isMultipart) {
			// 创建磁盘工厂，利用构造器实现内存数据储存量和临时储存路径
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(4096);
			// 设置文件临时存储路径
			factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
			// 产生一新的文件上传处理程式
			ServletFileUpload upload = new ServletFileUpload(factory);
			ProgressListener progressListener = new UploadProgressListener(request);
			request.getSession().setAttribute("progress", progressListener);
			//监听文件上传进度
			upload.setProgressListener(progressListener);	
			// 设置允许用户上传文件大小,单位:字节
			upload.setSizeMax(1024 * 1024 * 10000); 
			FileOutputStream out = null;
			InputStream in = null;
			// 得到所有的表单域，它们目前都被当作FileItem
			try {
				// 解析request对象，并把表单中的每一个输入项包装成一个fileItem对象，并返回一个保存了所有FileItem的list集合。
				// upload对象是使用DiskFileItemFactory对象创建的ServletFileUpload对象，并设置了临时文件路径 传输文件大小等等。
				List<FileItem> list = upload.parseRequest(request);
				Iterator<FileItem> it = list.iterator();
				while (it.hasNext()) {
					// 每一个item就代表一个表单输出项
					FileItem item = (FileItem) it.next();
					String filename = item.getName();
					// 得到上传文件的名称,并截取
					if (item.getName() != null && !item.isFormField()) {						
						String url = getServletContext().getRealPath("/");
						System.out.println("当前路径："+url);
						// 在C盘下面建了一个文件夹	
						String savePath = "C:/file";	
						// 获取文件后缀名
						String extensionName = filename.substring(filename.lastIndexOf(".") + 1);
						out = new FileOutputStream(savePath + "\\" + UUID.randomUUID() + "." + extensionName);
						in = item.getInputStream();
						byte buffer[] = new byte[1024];
						int len = 0;
						while ((len = in.read(buffer)) > 0) {
							out.write(buffer, 0, len);
						}
						in.close();
						out.close();
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().print("{'success':true,'message':'上传成功'}");
					}
					item.delete();
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			} finally {
				try {
					response.getWriter().close();
					in.close();
					out.close();
				} catch (Exception ex) {
					System.out.println(ex);
				}
			}
		}
	}

}