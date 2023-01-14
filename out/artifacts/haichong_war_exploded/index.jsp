<%@page import="weights.Get_weight_list"%>
<%@page import="java.io.File"%>
<%@page import="cart.Get_cart_arr"%>
<%@page import="cart.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //Custom Theme files -->
<link href="css/bootstrap.css" type="text/css" rel="stylesheet" media="all">
<link href="css/style.css" type="text/css" rel="stylesheet" media="all">
<link rel="stylesheet" href="css/swipebox.css">

<!-- js -->
<script src="js/jquery-1.11.1.min.js"></script>
<!-- //js -->
<!--web-fonts-->
<link href='http://fonts.useso.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Fugaz+One' rel='stylesheet' type='text/css'>
<!--//web-fonts-->
<!-- start-smooth-scrolling-->

<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>	

<style type="text/css">
	
	.file {
    position: relative;
    display: inline-block;
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 4px 12px;
    overflow: hidden;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
    .float{
        float:left;
        width : 200px;
        height: 200px;
        overflow: hidden;
        border: 1px solid #CCCCCC;
        border-radius: 10px;
        padding: 5px;
        margin: 5px;
    }
    img{
        position: relative;
          width: 200px;
        height: 200px;
        text-align: center;
        box-sizing: border-box;
    }
    .result{
        width: 200px;
        height: 200px;
        text-align: center;
        box-sizing: border-box;
    }
 
 
    #file_input{
        display: none;
    }
 
 form
{

     margin:0px;display: inline

}
    .delete{
        width: 200px;
        height:200px;
        position: absolute;
        text-align: center;
        line-height: 200px;
        z-index: 10;
        font-size: 30px;
        background-color: rgba(255,255,255,0.8);
        color: #777;
        opacity: 0;
        transition-duration: 0.7s;
        -webkit-transition-duration: 0.7s;
    }
 
 
    .delete:hover{
        cursor: pointer;
        opacity: 1;
    }
 
 
 
</style>
 
 
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript">
 
 
window.onload = function(){
    var input = document.getElementById("file_input");
    var result;
    var dataArr = []; // 储存所选图片的结果(文件名和base64数据)
    var fd;  //FormData方式发送请求
    var oSelect = document.getElementById("select");
    var oAdd = document.getElementById("add");
    var oSubmit = document.getElementById("submit");
    var oInput = document.getElementById("file_input");
 
    if(typeof FileReader==='undefined'){
        alert("抱歉，你的浏览器不支持 FileReader");
        input.setAttribute('disabled','disabled');
    }else{
        input.addEventListener('change',readFile,false);
    }　　　　　//handler
 
 
    function readFile(){
        fd = new FormData();
        var iLen = this.files.length;
        for(var i=0;i<iLen;i++){
            
            var reader = new FileReader();
            fd.append(i,this.files[i]);
            reader.readAsDataURL(this.files[i]);  //转成base64
            reader.fileName = this.files[i].name;
            
            reader.onload = function(e){
                var imgMsg = {
                    name : this.fileName,//获取文件名
                    base64 : this.result   //reader.readAsDataURL方法执行完后，base64数据储存在reader.result里
				}
                dataArr.push(imgMsg);
                result = '<div class="delete">delete</div><div class="result"><img class="subPic" src="'+this.result+'" alt="'+this.fileName+'"/></div>';
                var div = document.createElement('div');
                div.innerHTML = result;
                div['className'] = 'float';
                document.getElementsByTagName('img2')[0].appendChild(div);  　　//插入dom树
                var img = div.getElementsByTagName('img')[0];
                img.onload = function(){
                    var nowHeight = ReSizePic(this); //设置图片大小
                    this.parentNode.style.display = 'block';
                    var oParent = this.parentNode;
                    if(nowHeight){
                        oParent.style.paddingTop = (oParent.offsetHeight - nowHeight)/2 + 'px';
                    }
                }
                
                div.onclick = function(){
                    $(this).remove();                  // 在页面中删除该图片元素
                    
                }
            }
        }
    }
 
 
    
 
 
 
    oSelect.onclick=function(){
        oInput.value = "";   // 先将oInput值清空，否则选择图片与上次相同时change事件不会触发
        //清空已选图片
        $('.float').remove();
        oInput.click();
    }
 
 
    oAdd.onclick=function(){
        oInput.value = "";   // 先将oInput值清空，否则选择图片与上次相同时change事件不会触发
        oInput.click();
    }
 
 
    oSubmit.onclick=function(){
        if(!dataArr.length){
            return alert('请先选择文件');
		}
        send();
    }
}
/*
 用ajax发送fd参数时要告诉jQuery不要去处理发送的数据，
 不要去设置Content-Type请求头才可以发送成功，否则会报“Illegal invocation”的错误，
 也就是非法调用，所以要加上“processData: false,contentType: false,”
 * */
 
 
function ReSizePic(ThisPic) {
    var RePicWidth = 200; //这里修改为您想显示的宽度值
 
    var TrueWidth = ThisPic.width; //图片实际宽度
    var TrueHeight = ThisPic.height; //图片实际高度
 
    if(TrueWidth>TrueHeight){
        //宽大于高
        var reWidth = RePicWidth;
        ThisPic.width = reWidth;
        //垂直居中
        var nowHeight = TrueHeight * (reWidth/TrueWidth);
        return nowHeight;  //将图片修改后的高度返回，供垂直居中用
    }else{
        //宽小于高
        var reHeight = RePicWidth;
        ThisPic.height = reHeight;
    }
}
 
 
 
</script>
<!--//end-smooth-scrolling-->	
</head>
<body>
	<!--top-navigation-->
	<div class="top-nav">
		<nav class="navbar navbar-default">
			<div class="container">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">Menu						
				</button>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="hvr-bounce-to-bottom active"><a href="index.html">AI智农</a></li>
						<li class="hvr-bounce-to-bottom"><a href="#about" class="scroll">智农愿景</a></li>
						<li class="hvr-bounce-to-bottom"><a href="#services" class="scroll">识别权重</a></li>
						<li class="hvr-bounce-to-bottom"><a href="#portfolio" class="scroll">图片检测</a></li>
						<li class="hvr-bounce-to-bottom"><a href="#team" class="scroll">常见病害</a></li>
						<li class="hvr-bounce-to-bottom"><a href="#contact" class="scroll">联系我们</a></li>
					</ul>	
					<div class="clearfix"> </div>
				</div>	
			</div>
		</nav>		
	</div>	
	<!--//top-navigation-->
	<!--banner-->
	<div class="banner">		
		<!--header-->
		<div class="header">
			<div class="container">
				<div class="header-left">	
					<h1><a href="index.html">AI智农</a></h1>
				</div> 
				<div class="header-right">	
					<ul>
						<li><span class="glyphicon glyphicon-earphone" aria-hidden="true"></span>+86 17515277722</li>
						<li><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:example@mail.com">jackhou921@qq.com</a></li>
					</ul>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
		<div class="banner-text">
			<h2>欢迎</h2>
			<!-- banner Slider starts Here -->
			<script src="js/responsiveslides.min.js"></script>
			<script>
				// You can also use "$(window).load(function() {"
					$(function () {
					// Slideshow 3
						$("#slider3").responsiveSlides({
						auto: false,
						pager:true,
						nav:true,
						speed: 500,
						namespace: "callbacks",
						before: function () {
						$('.events').append("<li>before event fired.</li>");
						},
						after: function () {
							$('.events').append("<li>after event fired.</li>");
						}
					});	
				});
			</script>
			<!--//End-slider-script -->
			<div  id="top" class="callbacks_container">
				<ul class="rslides" id="slider3">
					<li>					
<%--						<h3>HEALTHY GROWTH OF CROPS</h3>--%>
						<h3>农作物健康成长</h3>
						<p>“一叶落而知天下秋”，“AI智农”希望借助人工智能深度学习与先进的计算机视觉算法进行目标检测，助力乡村振兴和精准农业，保障国家粮食安全与消费者的食品安全。在“城市大脑”方兴未艾之时，构建田野感知、普惠农民的“乡村大脑”。</p>
						<a href="#" class="more btn-1b scroll" data-toggle="modal" data-target="#myModal1"> 了解更多</a>
					</li>
					<li>					
						<h3>AI识别，省时省力</h3>
						<p>农民伯伯只需要给自己的庄稼叶子拍张照片，人工智能就能识别出农作物的病虫害种类，给出精准的防治建议，并构建大范围农作物病虫害数据采集与预防预警系统，精准预防治理农作物病虫害。 </p>
						<a href="#" class="more btn-1b scroll" data-toggle="modal" data-target="#myModal1"> 了解更多</a>
					</li>
					<li>					
						<h3>乡村振兴，智慧农业</h3>
						<p>深化供给侧结构性改革，推动互联网、大数据、人工智能和实体经济深度融合，在多个领域培育新增长点，形成新动能 。实施乡村振兴战略。 </p>
						<a href="#" class="more btn-1b scroll" data-toggle="modal" data-target="#myModal1"> 了解更多</a>
					</li>	
					<li>					
						<h3>精准扶贫，同济智慧</h3>
						<p>助力精准扶贫、乡村振兴、智慧农业的同济智慧：将论文写在祖国大地上，写入田间地头里。 </p>
						<a href="#" class="more btn-1b scroll" data-toggle="modal" data-target="#myModal1"> 了解更多</a>
					</li>						
				</ul>
			</div>
		</div>
	</div>
	<!--//banner-->
	<!--modal-sign-->
	<div class="modal bnr-modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>						
				</div>
				<section>
					<div class="modal-body modal-spa">
						<img class="img-responsive" src="images/img1.jpg" alt="">
						<p>农民伯伯只需要给自己的庄稼叶子拍张照片，人工智能就能识别出农作物的病虫害种类，给出精准的防治建议，并构建大范围农作物病虫害数据采集与预防预警系统，精准预防治理农作物病虫害。 助力精准扶贫、乡村振兴、智慧农业的同济智慧：将论文写在祖国大地上，写入田间地头里。
						</p>
					</div>
				</section>
			</div>
		</div>
	</div>
	<!--//modal-sign-->
	<!--about-->
	<div id="about" class="about">
		<div class="container">
			<h3 class="title">智农愿景</h3>
<%--			<h4 class="title">人工智能助力精准扶贫与乡村振兴</h4>--%>
			<p>智农”愿景：人工智能助力精准扶贫与乡村振兴
				我国每年有1.2亿吨粮食因农作物病虫害减产，相当于三亿人的口粮。

				以番茄为例，白粉病、疮痂病、早疫病、晚疫病、叶霉病、斑点病、斑枯病、红蜘蛛、黄化曲叶病毒病……困扰着千千万万果农的生计，影响着百姓的菜篮子，威胁着国家的粮食安全。

				人工识别效率极低，需要专业的植保、农科专家才能准确分辨。在病害的萌芽早期容易漏检，错过最佳防治期。

				对于农科院和植保机构，仍旧依靠实地采样与人工判断，缺乏定量化、细粒度、大规模、精准定制化的农作物病害数据采集、存储、识别、预警系统。

				党的十九大报告提出：深化供给侧结构性改革，推动互联网、大数据、人工智能和实体经济深度融合，在多个领域培育新增长点，形成新动能 。实施乡村振兴战略。

				“一叶落而知天下秋”，“智农”希望借助人工智能与先进的计算机视觉算法，助力乡村振兴和精准农业，保障国家粮食安全与消费者的食品安全。在“城市大脑”方兴未艾之时，构建田野感知、普惠农民的“乡村大脑”,实现乡村振兴. </p>
		</div>
	</div>
	<!--//about-->
	<!--features-->
	<div class="features">
		<div class="container">
			<h3 class="title">Agricultural Future</h3>
			<div class="col-md-6 features-left">
				<div class="video-img">
<%--					<a href="./images/ai1.mkv"><span class="glyphicon glyphicon-play"></span></a>--%>
					<a href="#" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-play"></span></a>
<%--					<video width="320" height="240" controls autoplay>--%>

<%--						<source src="./images/ai1.mkv" type="video/mkv">--%>

<%--					</video>--%>
				</div>
				<!--modal-video-->
				<div class="modal video-modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>						
							</div>
						</div>
					</div>
				</div>
				<!--//modal-video-->
			</div>
			<div class="col-md-6 features-right bar_group">
				<div class='bar_group__bar thin' label='Best Price ' value='200'></div>
				<div class='bar_group__bar thin' label='Quality' value='250'></div>
				<div class='bar_group__bar thin' label='Trust & Safety' value='180'></div>
				<div class='bar_group__bar thin' label='Planning Growth' value='220'></div>
			</div>
			<!--bar-js-->
			<script src="js/bars.js"></script>
			<!--bar-js-->
			<div class="clearfix"> </div>
		</div>
	</div>
	<!--//features-->
	<!--services-->
	<div id="services" class="services">
		<div class="container">
			<h3 class="title">识别权重</h3>
			<div class="service-row">
				<%
				ArrayList<String> arr_weights = Get_weight_list.get_list();
				if(arr_weights.size()!=0)
					for(int i=0;i<arr_weights.size();i++){
				%>
				<div class="col-md-3 srvc-grids">
					<div class="srvc-img">
						<span class="glyphicon glyphicon-leaf" aria-hidden="true"></span>
					</div>

					<h5><%=arr_weights.get(i) %></h5>
					<form action="Del_weights_servlet" method="post">
						<input value="<%=arr_weights.get(i) %>" name="del_weight" hidden=""/>
						<button type="submit">删除</button>
					</form>
				</div>
				<%} %>
				<div class="col-md-3 srvc-grids">TF
					<div class="srvc-img">
						<span class="glyphicon glyphicon-grain" aria-hidden="true"></span>
					</div>
					<h5>...</h5>
					<p>以后会更多，敬请期待！</p>
				</div>
				
				<div class="col-md-3 srvc-grids">
				<form action="Add_weights_servlet" method="post" id="myform" enctype="multipart/form-data">
				<a href="#" onclick="alert('正在上传中，请等待！');document.getElementById('myform').submit();return false;" >
					<div class="srvc-img">
						<span class="glyphicon glyphicon-signal" aria-hidden="true"></span>
					</div>
				</a>
					<h5>添加权重</h5>
					<input type="text" name="weight_name" maxlength="20" value="输入名称不能超过20字符" required="required" /><br/>
					<br/>
					<a href="javascript:;" class="file">选择文件
    				<input type="file" id="profile_pic" name="weight_add" accept=".pt" required="required" />
					</a>
				</form>
				</div>
				
				<div class="clearfix"> </div>				
			</div>
		</div>
	</div>
	<!--//services-->
	<!--portfolio-->
	
	<div id="portfolio" class="portfolio">
		<h3 class="title">图片检测</h3>
		<div class="sap_tabs">			
			<div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
				<ul class="resp-tabs-list" style="width: 50%;">
					<li class="resp-tab-item">
					<form action="Distinguish_Visio_servlet" method="post" id="visio">
					<select class="form-control" name="_select_" >
					<%
						if(arr_weights.size()!=0){
							for(int i=0;i<arr_weights.size();i++){
					%>
								<option><%=arr_weights.get(i) %></option>
					<%} }else{%>
							<option>empty!</option>
						<%} %>
					</select> 

					<a href="javascript:;" class="file" onclick="alert('关闭命令框 关闭视频检测');document.getElementById('visio').submit();return false;">
    				视频检测
					</a>
					
					
					
					</form></li>
				
					<li class="resp-tab-item">
					<form action="Cart_Servlet" method="post" enctype="multipart/form-data" id="files">
						<iframe id="iframeForm" name="iframeForm" style="display:none;"></iframe>
						<input type="file" id="file_input" name="images" accept="image/*" required="required" multiple/> <!--用input标签并选择type=file，记得带上multiple，不然就只能单选图片了-->
						<span><a id="select" >重新上传</a>&nbsp;|&nbsp;<a id="add" >继续上传</a>&nbsp;|&nbsp;
					
						<a href="javascript:;" class="file"  onclick="alert('正在上传中，请等待！');document.getElementById('files').submit();return false;">
    				上传
					</a>
						<br/>'
					
					</span></form></li>

					<li class="resp-tab-item"><span>图片</span>&nbsp;&nbsp;|&nbsp;&nbsp;
					<form action="Del_all_Cart_Servlet" method="post" id="clear">
					<a href="javascript:;" class="file" onclick="document.getElementById('clear').submit();return false;">
    				清空
					</a>
					<br/>'
					</form>
					</li>
					
				<li class="resp-tab-item">	
				<form action="Distinguish_servlet" method="post" id="myform2">
					<select class="form-control" name="_select_">
						<%
						if(arr_weights.size()!=0){
							for(int i=0;i<arr_weights.size();i++){
					%>
								<option><%=arr_weights.get(i) %></option>
					<%} }else{%>
							<option>empty!</option>
						<%} %>
					</select> 
					<a href="#" onclick="document.getElementById('myform2').submit();return false;">开始处理</a>&nbsp;&nbsp;处理结果
				</form>
				</li>	
				</ul>	
				
				<div class="clearfix"> </div>	
				<div class="resp-tabs-container">
				
				    <div class="tab-1 resp-tab-content">
						<div class="tab_img">
						<!-- 
						介绍部分
						0
						 -->
							
							<div class="col-md-3 portfolio-grids grid">
								<div class="hover ehover14">
									<a href="images/g3.jpg" class="swipebox" title="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis maximus tortor diam, ac lobortis justo rutrum quis. Praesent non purus fermentum, eleifend velit non">
<%--										<img src="images/g3.jpg" alt="" class="img-responsive" />--%>
										<div class="overlay">
											<h4>Portfolio</h4>
											<button class="info nullbutton" data-toggle="modal" data-target="#modal14">Show More
											</button>
										</div>
									</a>	
								</div>
							</div>
			
						<!-- 
						
						0
						 -->
							<div class="clearfix"> </div>
						</div>
					</div>
				
					<div class="tab-1 resp-tab-content">
						<div class="tab_img">
							
							<!-- 1 -->
							<img2></img2>
							<!-- 1 -->
							
							<div class="clearfix"> </div>
						</div>
					</div>
					<div class="tab-1 resp-tab-content">
						<div class="tab_img">
						
						<!-- 2 -->
						<%
						ArrayList<Cart> arr_carts = Get_cart_arr.get_carts();
						if(arr_carts.size()!=0){
							for(int i=0;i<arr_carts.size();i++){
								Cart cart = arr_carts.get(i);
						%><img src="<%="images_soruce"+'\\'+cart.getImg_name() %>">
						<%}}else{%>
						<h1>Empty!</h1>
							<%}%>
						<!-- 2 -->	
							
							<div class="clearfix"> </div>
						</div>
					</div>
					
					
					
					<div class="tab-1 resp-tab-content">
						<div class="tab_img">
						<!-- three -->
						<%
						ArrayList<Cart> arr_carts2 = Get_cart_arr.get_carts();
						
						if(arr_carts2.size()!=0){
							for(int i=0;i<arr_carts2.size();i++){
								Cart cart = arr_carts2.get(i);
						%>
							<div class="col-md-3 portfolio-grids grid" style="width: 380px;height: 260px;">
								<div class="hover ehover14">
								
									<a href="<%="images_distinguish\\exp\\"+cart.getImg_name() %>" class="swipebox" >
										<img src="<%="images_distinguish\\exp\\"+cart.getImg_name() %>" alt="" class="img-responsive" />
										<div class="overlay">
											<h4>cart.getImg_name()</h4>
											<button class="info nullbutton" data-toggle="modal" data-target="#modal14">详细显示
											</button>
										</div>
									</a>	
								</div>
							</div>
						<%}}else{%>
						<h1>Empty!</h1>
							<%}%>
						<!-- three -->
							
							<div class="clearfix"> </div>
						</div>
					</div>
					<div class="tab-1 resp-tab-content">
						<div class="tab_img">
						<!-- 4 -->
							
						<!-- 4 -->
							
							<div class="clearfix"> </div>
						</div>
					</div>
					<div class="tab-1 resp-tab-content">
						<div class="tab_img">
						<!-- 5 -->
							
						<!-- 5 -->
							
							<div class="clearfix"> </div>
						</div>
					</div>
					
				</div>
			</div>
			<!--ResponsiveTabs-->
			<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
			<script type="text/javascript">
				$(document).ready(function () {
					$('#horizontalTab').easyResponsiveTabs({
						type: 'default', //Types: default, vertical, accordion           
						width: 'auto', //auto or any width like 600px
						fit: true   // 100% fit in a container
					});
				});		
			</script>
			<!--//ResponsiveTabs-->
			<!-- swipe box js -->
			<script src="js/jquery.swipebox.min.js"></script> 
			<script type="text/javascript">
					jQuery(function($) {
						$(".swipebox").swipebox();
					});
			</script>
			<!-- //swipe box js -->
		</div>
	</div>
	<!--//portfolio-->
	<!--team-->
	<div class="team" id="team">
		<div class="container">
			<h3 class="title">常见病害</h3>
			<div class="team-row">
				<div class="col-md-3 team-grids">
					<div class="team-img">
						<img class="img-responsive" src="images/t1.jpg" alt="">
						<div class="captn">
							<p>苹果灰斑病，是由梨叶点霉侵染所引起的。主要危害叶片，枝条、叶柄、嫩梢及果实。受害叶片一般不变黄脱落，但严重受害的叶片可出现焦枯现象.
								苹果灰斑病的防治方法:秋冬季彻底清扫果园内的落叶，集中焚烧。改善树冠内通风透光条件；喷波尔多液保护春梢,生长季节喷50%敌菌丹可湿性粉剂600倍液。
							</p>
<%--							<div class="social-icons">--%>
<%--								<ul>--%>
<%--									<li><a href="#"> </a></li>--%>
<%--									<li><a href="#" class="pin"> </a></li>--%>
<%--									<li><a href="#" class="in"> </a></li>--%>
<%--									<li><a href="#" class="be"> </a></li>--%>
<%--									<li><a href="#" class="vimeo"> </a></li>--%>
<%--								</ul>--%>
<%--							</div>--%>
						</div>
					</div>
					<h4>苹果灰斑病</h4>
					<h6>(Apple Frogeye Spot)</h6>
				</div>
				<div class="col-md-3 team-grids">
					<div class="team-img">
						<img class="img-responsive" src="images/t2.jpg" alt="">
						<div class="captn">
							<p>苹果雪松锈病，是由山田胶锈菌侵染所引起的.主要为害叶片，也能为害嫩枝、幼果和果柄，还可为害转主寄主桧柏。
								苹果锈病的防治方法以农业防治和化学防治为主。首先切断病菌来源，彻底砍伐在苹果及梨园5千米以内的桧柏树，破坏病害的侵染循环,再结合化学药剂防治。 </p>
<%--							<div class="social-icons">--%>
<%--								<ul>--%>
<%--									<li><a href="#"> </a></li>--%>
<%--									<li><a href="#" class="pin"> </a></li>--%>
<%--									<li><a href="#" class="in"> </a></li>--%>
<%--									<li><a href="#" class="be"> </a></li>--%>
<%--									<li><a href="#" class="vimeo"> </a></li>--%>
<%--								</ul>--%>
<%--							</div>--%>
						</div>
					</div>
					<h4>苹果雪松锈病</h4>
					<h6>(Cedar Apple Rust serious)</h6>
				</div>
				<div class="col-md-3 team-grids">
					<div class="team-img">
						<img class="img-responsive" src="images/t3.jpg" alt="">
						<div class="captn">
							<p>玉米灰斑病,主要危害叶片。初在叶面上形成无明显边缘的椭圆形至矩圆形灰色至浅褐色病斑，后期变为褐色。湿度大时，病斑背面生出灰色霉状物，即病菌分生孢子梗和分生孢子。防治选用抗病或耐病的品种。收获后及时清除病残体,进行大面积轮作,加强田间管理，雨后及时排水，防止湿气滞留,药剂防治。</p>
<%--							<div class="social-icons">--%>
<%--								<ul>--%>
<%--									<li><a href="#"> </a></li>--%>
<%--									<li><a href="#" class="pin"> </a></li>--%>
<%--									<li><a href="#" class="in"> </a></li>--%>
<%--									<li><a href="#" class="be"> </a></li>--%>
<%--									<li><a href="#" class="vimeo"> </a></li>--%>
<%--								</ul>--%>
<%--							</div>--%>
						</div>
					</div>
					<h4>玉米灰斑病</h4>
					<h6>(Cercospora zeaemaydis Tehon)</h6>
				</div>
				<div class="col-md-3 team-grids">
					<div class="team-img">
						<img class="img-responsive" src="images/t4.jpg" alt="">
						<div class="captn">
							<p>玉米锈病是由玉米柄锈菌引起,主要发生在玉米叶片上. 发病后，叶片被黄色的夏孢子堆和夏孢子所覆盖，导致叶片干枯死亡，轻者减产，重者绝收。 防治包括农业防治（选择耐病品种、种植中或晚熟品种、茬口轮作、加强田间管理）和化学防治（在发病初期开始喷药，每隔7-10天喷1次）。</p>
<%--							<div class="social-icons">--%>
<%--								<ul>--%>
<%--									<li><a href="#"> </a></li>--%>
<%--									<li><a href="#" class="pin"> </a></li>--%>
<%--									<li><a href="#" class="in"> </a></li>--%>
<%--									<li><a href="#" class="be"> </a></li>--%>
<%--									<li><a href="#" class="vimeo"> </a></li>--%>
<%--								</ul>--%>
<%--							</div>--%>
						</div>
					</div>
					<h4>玉米锈病</h4>
					<h6>(Puccinia polysora)</h6>
				</div>
				<div class="cearfix"> </div>
			</div>
		</div>
	</div>
	<!--//team-->
	<!--contact-->
	<div class="contact" id="contact">
		<div class="container">
			<h3 class="title">联系我们</h3>
			<div class="contact-grids">
				<div class="col-md-4 address">
					<h4>Office Address</h4>
					<p class="cnt-p">您有意见或建议欢迎提交表单进行交流,谢谢您的合作. </p>
					<p>Broome St</p>
					<p>China, NY 10002, CN</p>
					<p>Telephone : +86 111 222 33333</p>
					<p>FAX : +1 888 888 4444</p>
					<p>Email : <a href="mailto:example@mail.com">mail@example.com</a></p>
				</div>
				<div class="col-md-7 contact-form">
					<form action="#" method="post">
						<input type="text" name="Name" placeholder="姓名" required="">
						<input class="email" type="text" name="Email" placeholder="邮箱" required="">
						<textarea placeholder="Message" name="Message" required=""></textarea>
						<input type="submit" value="提交">
					</form>
				</div>
				<div class="clearfix"> </div>	
			</div>
		</div>
	</div>
	<!--//contact-->
	<!--footer-->
	<div class="footer">
		<div class="container">			
			<p>Copyright &copy; 2021.<a target="_blank" href="http://sc.chinaz.com/moban/"></a></p>
		</div>	
	</div>
	<!--//footer-->
	<!--smooth-scrolling-of-move-up-->
	<script type="text/javascript">
		$(document).ready(function() {
			/*
			var defaults = {
				containerID: 'toTop', // fading element id
				containerHoverID: 'toTopHover', // fading element hover id
				scrollSpeed: 1200,
				easingType: 'linear' 
			};
			*/
			
			$().UItoTop({ easingType: 'easeOutQuart' });
			
		});
	</script>
	<!--//smooth-scrolling-of-move-up-->
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap.js"></script>
</body>
</html>