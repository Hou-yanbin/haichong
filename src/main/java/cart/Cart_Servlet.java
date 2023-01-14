package cart;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.Collection;

/**
 * Servlet implementation class Cart_Servlet
 */

@MultipartConfig
@WebServlet("/Cart_Servlet")
public class Cart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cart_Servlet() {
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
		
		PrintWriter out=response.getWriter();
		//out.println("<script>alert('�����ϴ��У���ȴ���');</script>");
		//����ʾ�û�
		Collection<Part> parts = request.getParts();//��ǰ̨��ȡͼƬ����	
		int max_id = Get_images_max_id.Get_max_id();//��ȡ��ǰͼƬ��ʼ�ı�� Ĭ����0
		ServletContext sc=super.getServletContext();
		String path=sc.getRealPath(".\\images_soruce");//���ñ���·��
		File file=new File(path);
		if(!file.exists()){  //�����ڴ���·��
			file.mkdirs();
		}
		//System.out.println(path+"\\"+filename);
		int i = 0;boolean ok = true;
		for (Part part:parts) {
			part.write(path+"\\"+Integer.toString((i)+max_id)+".png");//�ֱ𱣴�ͼƬ
			if(!Save_images._save_images(Integer.toString((i++)+max_id)+".png", path)) {
					ok = false;
			}
		}
		if(ok) {
		out.println("<script>alert('�ϴ��ɹ�');window.location.href='index.jsp#portfolio';</script>");
		}else {
			out.println("<script>alert('�ϴ�ʧ�ܣ�����ϵ����Ա��');window.location.href='index.jsp#portfolio';</script>");
		}
		//��ʾ�ϴ����
	}

}
