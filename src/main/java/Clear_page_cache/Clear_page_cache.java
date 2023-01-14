package Clear_page_cache;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class Clear_page_cache
 */
@WebFilter("/*")
public class Clear_page_cache implements Filter {

    /**
     * Default constructor. 
     */
    public Clear_page_cache() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("����Filter------���ٲ���");
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("�������................");
		//response����
		HttpServletResponse res = (HttpServletResponse) response;
		// �趨��ҳ�ĵ���ʱ�䣬һ����������뵽�����������µ���
		res.setDateHeader("Expires", -1);
		// Cache-Control ָ���������ӦӦ��ѭ�Ļ������ no-cacheָʾ�������Ӧ��Ϣ�ǲ��ܻ����
		res.setHeader("Cache-Control", "no-cache");
		// �����趨��ֹ������ӱ��ػ����е���ҳ�����ݣ��趨��һ���뿪ҳ����޷���Cache���ٵ���
		res.setHeader("Pragma", "no-cache");
		// ����
		chain.doFilter(request, res);


	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("��ʼ������-----�������");
	}

}
