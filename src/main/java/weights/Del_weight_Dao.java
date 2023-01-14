package weights;

import java.sql.Connection;

import java.sql.PreparedStatement;
import mysql_jdbc.JDBC;

public class Del_weight_Dao {

	public static boolean del_weight(String name) {
		
		Connection conn = JDBC.getConn();
		PreparedStatement ps=null;

		String sql = "delete from weights where name=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			int n = ps.executeUpdate();
			if(n>0) {
				conn.close();
				ps.close();
				
				return true;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
