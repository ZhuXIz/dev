<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
		<c:import  url="../common/import2.jsp"></c:import>
		<title>首页</title>
		
		<!--[if lt IE 9]>
          <script src="js/html5shiv.js" type="text/javascript"></script>
          <script src="js/css3-mediaqueries.js"  type="text/javascript"></script>
        <![endif]-->
	</head>
	<body>
	
		<div class="" id="situation">
			<!--顶部样式-->
			<div class="bk-herder relative header-section">
				<div class="bk-herder-logo">后台管理系统</div>
				<div class="operate-header">
					<div class="" id="dropdown_menu">
						<ul class="clearfix">
							<li></li>
						</ul>
					</div>
					
					<div class="bk-settings-section">
						<div class="headerUser">
							<a class="user-info clickBombbox" href="javascript:void(0)" data-position="bottom" data-type="arrow"> 欢迎您,${sessionScope.employee.name }</a>
						</div>
						<div class="skin-section">
							<a href="javascript:void(0)" class="skin-btn clickBombbox iconfont icon-pifushezhi" id="skin-btn"></a>
							<div class="Bombbox">
								<ul class="skin-list">
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="black" id="default" style="background-color:#222A2D"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="blue" style="background-color:#438EB9;"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="green" style="background-color:#72B63F;"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="gray" style="background-color:#41a2ff;"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="red" style="background-color:#FF6868;"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="purple" style="background-color:#6F036B;"></a>
									</li>
									<li>
										<a class="colorpick-btn" href="javascript:void(0)" data-val="white" style="background-color:#FFFFFF;border: 1px solid #DDDDDD; color: #333333;"></a>
									</li>
								</ul>
							</div>
						</div>
						<a href="javascript:void(0)" class="radius roll-right fullscreen" id="fullscreen"><i class="iconfont icon-msnui-fullscreen"></i></a>
						
					</div>
				</div>
			</div>
			<!--内容显示区-->
			<div class="bk-contents content-section">
				<!--栏目显示区-->
				<div class="bk-con-menu" id="bk-con-menu">
					<div class="menubtn">
						<span class="close_btn samebtn"><i>隐藏</i></span>
						<span class="show_btn samebtn"><i>显示</i></span>
					</div>
					<a id="js-tabNav-prev" class="radius btn-default left_roll" href="javascript:void(0);"><i class="iconfont icon-zuoshuangjiantou"></i></a>
					<div class="breadcrumb" id="breadcrumb">
						<ul class="clearfix menu-section menulist" id="menu-section"></ul>
					</div>
					<a id="js-tabNav-next" class="radius btn-default right_roll" href="javascript:void(0);"><i class="iconfont icon-youshuangjiantou"></i></a>
				</div>
				<!--内容显示区-->
				<div class="bk-con-message message-section" id="iframe_box">
                <!-- home -->
				</div>
			</div>
			<!--底部显示区-->
			
			<div class="bk-footer footer-section footer-top" style="height: 40px; bottom: 0px; width: 100%; top: 50px;">
				<div class="tab-column clearfix" id="tab-column" style="width: 507px; height: 39px; position: relative;">
					<ul class="tab-navigation  mobilemun" id="tab-navigation" tabindex="5002" style="overflow: hidden; outline: none;">
					<!-- 菜单地址快捷操作 -->
					<!-- <li class="home active" style="height: 40px; line-height: 40px;"><span data-id="2" data-title="系统首页" data-href="home.jsp">系统首页</span></li> --></ul>
				</div>
				<div class="inte-operation" id="operation">
					<a href="javascript:void(0)" class="dropdown iconfont icon-iconfonticontrianglecopy"></a>
					<div class="dropdown-menu dropdown-menu-right tab-menu-list">
						<div class="title-name">选项卡操作</div>
						<ul class="tabslist" id="dropdown_menu">
							<li>
								<a class="tabReload" href="javascript:void(0);">刷新当前</a>
							</li>
							<li>
								<a class="tabCloseCurrent" href="javascript:void(0);">关闭当前</a>
							</li>
							<li>
								<a class="tabCloseAll" href="javascript:void(0);">全部关闭(首页)</a>
							</li>
							<li>
								<a class="tabCloseOther" href="javascript:void(0);">除此之外全部关闭</a>
							</li>
						</ul>
				<!-- 	<div class="tab-list-container"><div class="title-name">选项卡栏目</div><ul class="tab-list"></ul></div> --></div>
				</div>
			</div>
			
			
			
			
			
			
			
			
			
		</div>
	</body>
</html>
<script>

var data=[];
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/menu/sys/show",
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			/* $.each(msg,function(index,obj){
				if(index==msg.length-1){
					data+="{"+
					"id: "+obj.id+","+
					"pid:"+obj.pid+","+
					"icon: "+obj.icon+","+
					"url: "+obj.url+","+
					"name: "+obj.name+
					"}";
				}else{
					data+="{"+
					"id: "+obj.id+","+
					"pid:"+obj.pid+","+
					"icon: "+obj.icon+","+
					"url: "+obj.url+","+
					"name: "+obj.name+
					"},";
				}
			}); */
			data=msg;
		},
		error : function(msg) {
			alert("未知错误");
		}
	});
	console.log(data);
	$(function() {
		$("#situation").BKframe({
			data: data, //数据,支持API传输但需要保证数据格式一样
			menuopt: 'click', //点击菜单栏显示模式'click'和'hover'
			boxname: '.Bombbox', //弹框模块
			bkposition: "left",//菜单栏显示的方式，现有左侧列表展示和顶部列表展示方式两种
			slide: '#breadcrumb',//设置菜单栏目样式属性
			cookieDate:7,//设置皮肤显示时间（天单位）
			rightclick: false, //是否启用右键功能(为true是右键失效，为false时右键显示)
			minStatue:false,//设置默认是否显示菜单栏（true为隐藏/false为显示）
			//homepage:"home.jsp", // 设置默认显示页（id值必须为2，否则将出错）
			scrollbar:function(e){
				e.niceScroll({
					    cursorcolor: "#dddddd",
					    cursoropacitymax: 1,
					    touchbehavior: false,
					    cursorwidth: "3px",
					    cursorborder: "0",
					    cursorborderradius: "3px",
				 });						
			},//自定义滚动样式(可以自己写也可以用第三方插件)
			expand:function(thisBox,settings){						
			    settings.scrollbar($(settings.slide));	//设置显示弹框模块是否需要滚动（自定义）
                settings.loading=('<div class="loader-inner ball-spin-fade-loader"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>'); //定义加载动画   	
			}//自定义方法
		});
	});
//退出系统
/* function dropout(){
    layer.confirm('是否确定退出系统？', {
     btn: ['是','否'] ,//按钮
	 icon:1,
    }, 
	function(){
	  location.href="login.jsp";  
   });
} */
</script>

