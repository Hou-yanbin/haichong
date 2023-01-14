package distinguish;

import System_function.Run_bat;

public class Distinguish_Dao {
	


public static boolean Distinguish_function(String path ,String weight, String source, String project) {
		
	try {
		Run_bat.run(path, weight, source, project);
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		return false;
	}
	return true;
}
	
public static boolean Distinguish_function(String path ,String weight,String project) {
		
		try {
			Run_bat.run(path ,weight,project);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
