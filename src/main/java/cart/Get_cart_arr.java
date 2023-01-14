package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mysql_jdbc.JDBC;

public class Get_cart_arr {

	public static ArrayList<Cart> get_carts(){
		
		ArrayList<Cart> arrayList = new ArrayList<Cart>();
		Connection conn = JDBC.getConn();
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql = "select * from images";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()&&rs!=null) {
				Cart cart = new Cart();
				cart.setImg_name(rs.getString("img_name"));
				cart.setImg_path(rs.getString("img_path"));
				arrayList.add(cart);
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
		/*for (int i = 0; i < arrayList.size(); i++) {
			System.out.println(arrayList.get(i).getImg_path()+'\\'+arrayList.get(i).getImg_name());
		}
		*/
		return arrayList;
	}
}
