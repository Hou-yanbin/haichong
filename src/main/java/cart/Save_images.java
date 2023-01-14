package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import mysql_jdbc.JDBC;

public class Save_images {

	public static boolean _save_images(String name, String path) {
		
		Connection conn = JDBC.getConn();
		String sql = "insert into images values(?,?)";
		PreparedStatement ps=null;
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, path);
			int n = ps.executeUpdate();
			if(n>0) {
				conn.close();
				ps.close();
				return true;
			}else
				{
				conn.close();
				ps.close();
				return false;
				}
			
		} catch (SQLException e1) {
			// TODO �Զ����ɵ� catch ��
			System.out.println("_save_images 1 error");
			e1.printStackTrace();
		}	
		
		try {
			conn.close();
			ps.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return false;
	}
}
