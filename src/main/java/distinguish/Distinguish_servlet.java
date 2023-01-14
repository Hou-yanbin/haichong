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

import System_function.Del_ALL_File;

/**
 * Servlet implementation class Distinguish_servlet
 */
@WebServlet("/Distinguish_servlet")
public class Distinguish_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Distinguish_servlet() {
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
		//������Ӧ���ĵ����ͺͱ��뷽ʽ
		
		String weight_name = request.getParameter("_select_");
		PrintWriter out=response.getWriter();

		ServletContext sc=super.getServletContext();
		String path0=sc.getRealPath(".\\images_soruce");//���ö�ȡ·��
		String path1=sc.getRealPath(".\\images_distinguish");//���ñ���·��

		File file1=new File(path1);
		if(!file1.exists()){  //�����ڴ���·��
			file1.mkdirs();
		}
		
		if(Del_ALL_File.Del_all_file(path1)&&Distinguish_Dao.Distinguish_function("yolov5\\", "Yolov5_Weight\\"+ weight_name+".pt", path0, path1)){//����� ����
			
			out.println("<script>alert('���ɹ�');window.location.href='index.jsp#portfolio';</script>");
		}else {
			out.println("<script>alert('���ʧ�ܣ�����ϵ����Ա��');window.location.href='index.jsp#portfolio';</script>");
		}
	}

}
