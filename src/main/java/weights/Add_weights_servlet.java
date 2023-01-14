package weights;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


/**
 * Servlet implementation class Add_weights_servlet
 */
@MultipartConfig
@WebServlet("/Add_weights_servlet")
public class Add_weights_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Add_weights_servlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		//设置响应的文档类型和编码方式

		PrintWriter out=response.getWriter();

		out.println("<script>alert('正在上传中，请等待！');</script>");
		//先提示用户
		Part part = request.getPart("weight_add");//从前台获取图片数组
		String name = request.getParameter("weight_name");
		ServletContext sc=super.getServletContext();

		String path=sc.getRealPath(".\\Yolov5_Weight");//设置保存路径
		File file=new File(path);
		if(!file.exists()){  //不存在创建路径
			file.mkdirs();
		}

		part.write(path+"\\"+name+".pt");//分别保存图片

		if(Add_weight.add_weigth_(name)) {
			String succee = URLEncoder.encode("上传成功", "UTF-8");
			out.println("<script>decodeURIComponent('\"+succee+\"');window.location.href='index.jsp#portfolio' </script>");
		}else {
			String lose = URLEncoder.encode("上传失败，请联系管理员！", "UTF-8");
			out.println("<script>decodeURIComponent('\"+lose+\"');window.location.href='index.jsp#portfolio'</script>");
		}
		//提示上传完成
	}

}
