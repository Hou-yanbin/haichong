package weights;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mysql_jdbc.JDBC;

public class Get_weight_list {

	public static ArrayList<String> get_list(){
		ArrayList<String> arrayList = new ArrayList<String>();
		Connection conn = JDBC.getConn();
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql = "select name from weights";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()&&rs!=null) {
				arrayList.add(rs.getString("name"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		try {
			conn.close();
			ps.close();
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		//System.out.println(arrayList.size());
		return arrayList;
	}
	
}
