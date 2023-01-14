package mysql_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC {

	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
    static final String DB_URL = "jdbc:mysql://localhost:3306/project?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    static final String user="root";
    static final String password="123456";
    
    /*Mysql 8.0以下版本
     *  static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  加载数据库的驱动 jar包
     *static final String DB_URL = "jdbc:mysql://localhost:3306/webdatabase";
     *	static final String user="root";
     *	static final String password="123456";
     ****/
    
	public static Connection getConn(){
		
		Connection conn=null;  //代表java与数据库的连接
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("出现异常：forName");
			e.printStackTrace();
			return conn;
		}
		try {
			conn = DriverManager.getConnection(DB_URL, user, password);//加载数据库的驱动并创建与数据库的连接
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			String s = "你好我是Jack·";
			System.out.println("出现异常：DriverManager.getConnection");
			System.out.println("你好我是Jack·");
			e.printStackTrace();
		}
			
		return conn;
		
	}
}
