package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import mysql_jdbc.JDBC;

public class Del_All_Cart {

	public static boolean del_all_cart() {
		
		Connection conn=null;
		PreparedStatement ps=null;
		conn=JDBC.getConn();
		String sql="delete from images";//加入订单
		
		try {
			ps = conn.prepareStatement(sql);
			int n = ps.executeUpdate();
			if(n>0) {
				ps.close();
				conn.close();
				return true;
			}else {
				ps.close();
				conn.close();
				return false;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();	
		}
		try {
			ps.close();
			conn.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		System.out.println("Del_All_Cart2 error");
		return false;
		
		
		
	}
}
