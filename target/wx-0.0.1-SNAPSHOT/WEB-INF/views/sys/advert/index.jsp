
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
	<c:import  url="../../common/import2.jsp"></c:import>
</head>


<body id="situation">
<div class="pages-style" >
	<!-- 
	<div class="bk-con-menu " id="bk-con-menu">
					<div class="menubtn">
						<span class="close_btn samebtn"><i>隐藏</i></span>
						<span class="show_btn samebtn"><i>显示</i></span>
					</div>
					<div class="title-menu">栏目分类</div>
					<div class="breadcrumb" id="breadcrumb">
						<ul class="clearfix menu-section menulist" id="menu-section">
							
						</ul>
					</div>
				</div> -->
		
		

	<!--右侧内容-->
	<div class="bk-con-message message-section " id="iframe_box">
           <!--编辑内容-->
           <div class="operation  mb15">
           	<button class="btn button_btn bg-deep-gray add" type="button" onclick=""><i class="iconfont"></i>&nbsp;添加</button>
           </div>
           <!--列表内容-->
           <div class="page_content clearfix mb15 table-module ">
           	<table class="gallery table table_list table_striped table-bordered " id="">
           		<thead>
		        <tr>
					<th ><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
					<th >轮播图</th>
					<th >操作</th>
		       </tr>
		       </thead>
		       <tbody>
           		
	           		
	           		<c:forEach items="${list.rows}" var="obj">
	           			<tr>
		           			<td><input type="hidden" value="${obj.id}" id="id">
		           			<label><input type="checkbox" class="ace"><span class="lbl"></span></label></td>
		           			<td><img src="${pageContext.request.contextPath}${obj.img}" style="max-width: 50px"></td>
			           		<td>
			           			<a class="iconfont" onclick="javascript:removeObj(${obj.id})"> </a>
			           			<a class="iconfont" onclick="javascript:update('${obj.id}')"> </a>
			           		</td>
		           		</tr>
	           		</c:forEach>
	           		
           		
		       </tbody>
           	</table>
           </div>
    </div>
  </div>
  <div>
  		<a class="back">上一页</a> /<a class="next">下一页</a>&nbsp;&nbsp;&nbsp;共${list.total}页
  </div>

<script type="text/javascript">

var total =${list.total};
var currPage =${list.currPage};
if(currPage<=1){
	$(".back").css("color","gray");
}
if(currPage>=total){
	$(".next").css("color","gray");
}
 	$(".back").click(function(){
 		if(currPage<=1){
 			return true;
 		}
 		currPage--;
	  	window.location.href='/wx/employee/sys/index?page='+currPage;
	});
	$(".next").click(function(){
		if(currPage>=total){
 			return true;
 		}
		currPage++;
		window.location.href='/wx/employee/sys/index?page='+currPage;
	});
	
	
				
				
</script>

		<script type="text/javascript">
		
			function closeWindow(){
				$(".notescontent").remove();
				$(".baglayer").remove();
			}
			function save(data){
				$.ajax({
					type : 'post',
					async : false,
					url : "/wx/employee/sys/save",
					data: JSON.stringify(data),//必要
			        dataType:"json",
			        contentType:"application/json",
			        async: false,
			        cache:false,
					success : function(msg) {
						if(msg.code==0){
							if(data.id!=null){
								alert("修改成功！");
							}else{
								alert("添加成功！");
							}
							
							window.location.href='/wx/employee/sys/index?page='+currPage;
						}
					},
					error : function(msg) {
						alert("添加失败");
					}
				});
			}
			
			function check(id){
				var name = $("#name").val();
				var pwd = $("#pwd").val();
				var permiss = $("#permiss").find("option:selected").val();
				if(permiss<=0){
					alert("请配置权限");
					return false;
				}
				if(typeof(pwd)=="undefined"||pwd.trim().length<=0){	
					alert("请填写密码");
					return false;
				}
				if(typeof(name)=="undefined"||name.trim().length<=0){	
					alert("请填写账户名");
					return false;
				}
				
				var data ={
						'id':id,
						'name':name,
						'pwd':pwd,
						'permiss':{
							'id':permiss
						}
				};
				save(data);
			}
				
				$(".add").on('click', function() {
					addSpot();
				});
				
				function addSpot(id) {
					noteshtml(id);
				}
				
				var permissId =0;
				function noteshtml(id) {
					console.log(id);
					var str = "";
					
					//修改
					if(id!=null|typeof(id)!='undefined'){
						$.ajax({
							type : 'post',
							async : false,
							url : "/wx/employee/sys/get?id="+id,
					        dataType:"json",
					        contentType:"application/json",
					        async: false,
					        cache:false,
							success : function(msg) {
								if(msg){
									console.log(msg);
									permissId = msg.permiss.id;
									str = "<div class='notescontent box-module clearfix notesbox' >" +
									"<div class='box-title'>添加轮播图<i class='iconfont' onclick='javascript:closeWindow()'>&#xe70a</i></div><div class='box-content  padding15'>"+
									"<div class='cell-item'>" +
									"<input id='to_id' type='hidden'  value='"+msg.id+"' class='addtext width100b'>" +
									"<label class='cell-left label_name'>账户名:</label>" +
									"<div class='cell-right'><input id='name' type='text'  value='"+msg.name+"' class='addtext width100b'></div>" +
									"</div>" +
									"</div><div class='box Notesbtn commonbtn'>" +
									"<button type='button' class='box-flex btnbox  bg-deep-blue' onclick='javascript:check("+msg.id+")'>修改</button>" +
									"<button type='button' class='box-flex btnbox btn-danger' onclick='javascript:closeWindow()'>取消</button>" +
									"</div></div> <div class='baglayer' id='colselayer'></div>";
								}
							},
							error : function(msg) {
								console.log(msg);
							}
						});
					}else{
						//添加
						str = "<div class='notescontent box-module clearfix notesbox' >" +
						"<div class='box-title'>添加员工账户<i class='iconfont' onclick='javascript:closeWindow()'>&#xe70a</i></div><div class='box-content  padding15'>"+
						"<div class='cell-item'>" +
						"<input id='to_id' type='hidden'  value='' class='addtext width100b'>" +
						"<label class='cell-left label_name'>账户名:</label>" +
						"<div class='cell-right'><input id='name' type='text'  value='' class='addtext width100b'></div>" +
						"</div>" +
						"</div>" +
						"</div><div class='box Notesbtn commonbtn'>" +
						"<button type='button' class='box-flex btnbox  bg-deep-blue' onclick='javascript:check()'>添加</button>" +
						"<button type='button' class='box-flex btnbox btn-danger' onclick='javascript:closeWindow()'>取消</button>" +
						"</div></div> <div class='baglayer' id='colselayer'></div>";
					}
					
					
					$("body").append(str);
					//初始化下拉框
					var selectHtml="<option value='0'>---请选择---</option>";
					$.ajax({
						type : 'get',
						async : false,
						url : "/wx/permiss/sys/getAll",
						// 如果参数为json，加上这句
						contentType : "text/json",
						// 规定反参类型为text
						dataType : "json",
						success : function(msg) {
							
							if(msg){
								$.each(msg,function(index,obj){
									selectHtml+=
						   			"<option value='"+(index+1)+"'>"+obj.name+"</option>";
								})
								
								$('#permiss').html(selectHtml);
							}else{
								selectHtml+="<option value='1'>管理员</option>"+
						   			"<option value='2'>业务员</option>";
								alert("获取权限列表失败!!只能对新用户添加初始的两种权限!");
							}
							$('#permiss').html(selectHtml);
							
						},
						error : function(msg) {
							console.log(msg);
							selectHtml+="<option value='1'>管理员</option>"+
				   			"<option value='2'>业务员</option>";
				   			$('#permiss').html(selectHtml);
							alert("获取权限列表失败!!只能对新用户添加初始的两种权限!");
						}
					});
					$('#permiss').val(permissId);
				}
				

				//删除
				function removeObj(id){
					var message= confirm("确定要删除吗？");
					if(message){
						$.ajax({
							type : 'get',
							async : false,
							url : "/wx/employee/sys/remove?id="+id,
							// 如果参数为json，加上这句
							contentType : "text/json",
							// 规定反参类型为text
							dataType : "json",
							success : function(msg) {
								if(msg.code==0){
									window.location.href='/wx/employee/sys/index?page='+currPage;
								}else{
									console.log("删除失败");
								}
								
							},
							error : function(msg) {
								
								console.log("删除失败");
							}
						});
						
					}
				}
			
				//修改
				function update(id){
					
					//打开弹窗
					addSpot(id);
				}
				
				
				//添加
				function add(){
					window.location.href='/wx/employee/sys/remove?';
				}
		</script>		
 </body>
</html>
