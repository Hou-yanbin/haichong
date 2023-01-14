package System_function;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;


public class Run_bat {

static String arg1 = "yolov5/";
static String arg2 = "../Yolov5_Weight/apple_best.pt";
static String arg3 = "0";
static String arg4 = "save_runs/";


	 
public static void run(String arg1,String arg2,String arg3,String arg4) {
	  // TODO Auto-generated method stub
	arg1 = " \""+arg4+"\\"+"..\\"+arg1+"\" ";
	arg2 = " \""+arg4+"\\"+"..\\"+arg2+"\" ";
	arg3 = " \""+arg3+"\" ";
	String ar0 = arg4;
	arg4 = " \""+arg4+"\" ";
	System.out.println(ar0+"\\"+".."+"\\bin\\yolov5.bat"+ arg1+arg2+arg3+arg4);
    String batPath = ar0+"\\"+".."+"\\bin\\yolov5.bat"+ arg1+arg2+arg3+arg4 ; // 把你的bat脚本路径写在这里
    callCmd(batPath);
}

public static void run(String arg1,String arg2,String arg4) {
	  // TODO Auto-generated method stub
	arg1 = " \""+arg4+"\\"+"..\\"+arg1+"\" ";
	arg2 = " \""+arg4+"\\"+"..\\"+arg2+"\" ";
	String ar0 = arg4;
	System.out.println(ar0+"\\"+".."+"\\bin\\yolov5_visio.bat"+ arg1+arg2);
  String batPath = ar0+"\\"+".."+"\\bin\\yolov5_visio.bat"+ arg1+arg2; // 把你的bat脚本路径写在这里
  callCmd(batPath);
}
    
    private static void  callCmd(String locationCmd){
        StringBuilder sb = new StringBuilder();
        try {
            Process child = Runtime.getRuntime().exec(locationCmd);
            InputStream in = child.getInputStream();
            BufferedReader bufferedReader=new BufferedReader(new InputStreamReader(in));
            String line;
            while((line=bufferedReader.readLine())!=null)
            {
                sb.append(line + "\n");
            }
               in.close();
            try {
                child.waitFor();
            } catch (InterruptedException e) {
                System.out.println(e);
            }
            System.out.println("run finished");           
        } catch (IOException e) {
            System.out.println(e);
        }
     }
}