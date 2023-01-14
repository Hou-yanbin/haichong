package cart;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import mysql_jdbc.JDBC;

public class Get_images_max_id {

	public static int Get_max_id() {
		
		Connection conn = JDBC.getConn();
		Statement stmt = null;
		ResultSet rs=null;
		String sql = "select count(*) from images";
		int max_id = 0;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				max_id  = rs.getInt("count(*)");
			}
		} catch (SQLException e1) {
			// TODO 自动生成的 catch 块
			System.out.println("Get_max_id() 1 error");
			e1.printStackTrace();
		}	
		
		try {
			conn.close();
			rs.close();
			stmt.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println("null");
		
		return max_id;
		
	}
}
