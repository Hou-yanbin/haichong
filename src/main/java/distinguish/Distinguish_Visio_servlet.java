package distinguish;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class Distinguish_Visio_servlet
 */

@WebServlet("/Distinguish_Visio_servlet")
public class Distinguish_Visio_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Distinguish_Visio_servlet() {
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
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//设置响应的文档类型和编码方式
		PrintWriter out=response.getWriter();
		//out.println("<script>alert('关闭命令框 关闭视频检测');</script>");
		String weight_name = request.getParameter("_select_");
		

		ServletContext sc=super.getServletContext();
		String path1=sc.getRealPath(".\\images_distinguish");//设置保存路径

		File file1=new File(path1);
		if(!file1.exists()){  //不存在创建路径
			file1.mkdirs();
		}
		
		if(Distinguish_Dao.Distinguish_function("yolov5\\", "Yolov5_Weight\\"+ weight_name+".pt",path1)){//先清空 后检测
			out.println("<script>alert('已关闭');window.location.href='index.jsp#portfolio';</script>");
		}else {
			out.println("<script>alert('检测失败，请联系管理员！');window.location.href='index.jsp#portfolio';</script>");
		}
	}

}
