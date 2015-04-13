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

		// 获得上传文件路径
		String url = "";
		String msg = "";
		try {
			// 初始化
			su.initialize(this.getServletConfig(), req, resp);
			// 设置每个文件最大长度
			su.setMaxFileSize(1024 * 1024 * 1024);
			// 设置所有上传文件总长度
			su.setTotalMaxFileSize(1024 * 1024 * 1024 * 2);
			// 设定允许上传的文件类型
			su.setAllowedFilesList("jpeg,jpg,png,JPEG,JPG,PNG");

			su.upload();

			StringBuffer filename = new StringBuffer();

			// 生成时间戳
			long time = System.currentTimeMillis();
			String second = String.valueOf(time);

			// 通过file input的name属性获得文件名
			String uploadPath = su.getRequest().getParameter("imgFile");

			filename.append(second).append("&").append(uploadPath);

			// 获得文件保存的指定目录
			url = getServletContext().getRealPath("/") + "file"
					+ java.io.File.separator + filename;
			// 保存文件到指定目录
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
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		// 文件名中文乱码问题，可调用ServletUpLoader的setHeaderEncoding方法，或者设置request的setCharacterEncoding属性
		boolean isMultipart = ServletFileUpload.isMultipartContent(request); // 判断上传表单是否为multipart/form-data类型
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
			upload.setProgressListener(progressListener);
			// 文件名中文乱码问题，可调用ServletUpLoader的setHeaderEncoding方法，或者设置request的setCharacterEncoding属性
			upload.setSizeMax(1024 * 1024 * 10000); // 设置允许用户上传文件大小,单位:字节
			FileOutputStream out = null;
			InputStream in = null;
			// 得到所有的表单域，它们目前都被当作FileItem
			try {
				// 解析request对象，并把表单中的每一个输入项包装成一个fileItem
				// 对象，并返回一个保存了所有FileItem的list集合。
				// upload对象是使用DiskFileItemFactory
				// 对象创建的ServletFileUpload对象，并设置了临时文件路径 传输文件大小等等。
				List<FileItem> list = upload.parseRequest(request);
				Iterator it = list.iterator();
				while (it.hasNext()) {
					FileItem item = (FileItem) it.next();// 每一个item就代表一个表单输出项
					String filename = item.getName();
					if (item.getName() != null && !item.isFormField()) {
						// 得到上传文件的名称,并截取
						String utl = getServletContext().getRealPath("/");
						String savePath = "C:/file";// 在WebRoot下面建了一个文件夹
						System.out.println("真实路径："+savePath);
						String extensionName = filename.substring(filename
								.lastIndexOf(".") + 1);// 获取文件后缀名
						out = new FileOutputStream(savePath + "\\"
								+ UUID.randomUUID() + "." + extensionName);
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