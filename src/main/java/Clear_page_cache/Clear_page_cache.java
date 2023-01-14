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
		System.out.println("缓存Filter------销毁操作");
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("清除缓存................");
		//response对象
		HttpServletResponse res = (HttpServletResponse) response;
		// 设定网页的到期时间，一旦过期则必须到服务器上重新调用
		res.setDateHeader("Expires", -1);
		// Cache-Control 指定请求和响应应遵循的缓存机制 no-cache指示请求或响应消息是不能缓存的
		res.setHeader("Cache-Control", "no-cache");
		// 用于设定禁止浏览器从本地缓存中调用页面内容，设定后一旦离开页面就无法从Cache中再调出
		res.setHeader("Pragma", "no-cache");
		// 放行
		chain.doFilter(request, res);


	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("初始化数据-----缓存清除");
	}

}
