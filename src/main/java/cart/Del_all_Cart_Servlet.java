package cart;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import System_function.Del_ALL_File;


/**
 * Servlet implementation class Del_all_Cart_Servlet
 */
@WebServlet("/Del_all_Cart_Servlet")
public class Del_all_Cart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Del_all_Cart_Servlet() {
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
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//设置响应的文档类型和编码方式
		ServletContext sc=super.getServletContext();
		String path=sc.getRealPath(".\\images_soruce");//设置保存路径
		String path2=sc.getRealPath(".\\images_distinguish");//设置保存路径
		File file=new File(path);
		if(!file.exists()){  //不存在创建路径
			file.mkdirs();
		}
		
		PrintWriter out=response.getWriter();
		if(Del_All_Cart.del_all_cart()&&Del_ALL_File.Del_all_file(path)&&Del_ALL_File.Del_all_file(path2)) {//第二个是清空图片
			out.println("<script>alert('删除成功');window.location.href='index.jsp#portfolio';</script>");
		}else {
			out.println("<script>alert('图片为空！');window.location.href='index.jsp#portfolio';</script>");
		}
				
	}

}
