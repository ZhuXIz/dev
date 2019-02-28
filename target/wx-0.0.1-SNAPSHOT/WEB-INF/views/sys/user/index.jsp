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
				<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn bg-deep-gray add" data-toggle='modal' type="button">
					<i class="iconfont"></i>&nbsp;添加用户
				</button>
			</div>
           <!--列表内容-->
           <div class="page_content clearfix mb15 table-module ">
           	<table class="gallery table table_list table_striped table-bordered " id="">
           		<thead>
		        <tr>
					<th ><label><input type="checkbox" class="ace"><span class="lbl"></span></label></th>
					
					<th >昵称</th>
					<th >联系人</th>
					<th >联系电话</th>
					<th >头像</th>
					<th >收货地址</th>
					<th >积分</th>
					<th >余额</th>
					<th >操作</th>
		       </tr>
		       </thead>
		       <tbody>
	           		<c:forEach items="${list.rows}" var="obj">
	           		
	           			<tr>
		           			<td><label><input type="checkbox" class="ace"><span class="lbl">
		           			<input type="hidden" id="id" value="${obj.id}"></span></label></td>
			           		<td>${obj.name}</td>
			           		<td>${obj.phoneName}</td>
			           		<td>${obj.phoneNum}</td>
			           		<td><img src="${pageContext.request.contextPath}${obj.imageUrl}" style="max-width: 50px"></td>
			           		<td>${obj.address}</td>
			           		<td>${obj.score}</td>
			           		<td>${obj.money}</td>
			           		<td>
			           			<a class="iconfont colseNotes" id="colseNotes" onclick="javascript:removeObj('${obj.id}')"> </a>
			           			<a class="iconfont modifyNotes" onclick="javascript:update('${obj.id}')"> </a>
			           		</td>
		           		</tr>
	           		</c:forEach>
	           		
           		
		       </tbody>
           	</table>
           </div>
    </div>
  </div>
  
  
  <!-- 模态框（Modal）------------------用户详情 -->
<div class="modal fade" id="userModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="title">
					添加用户
				</h4>
			</div>
			<div class="modal-body" id ='addUserContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				<form class="bs-example bs-example-form" role="form" >
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								微信昵称:
								<input type="text" id="name" class="form-control">
							</div>
						</div>
					</div>
					<br>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								联系人:
								<input type="text" id="phoneName" class="form-control">
							</div>
						</div>
					</div>
					<br>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								联系电话:
								<input type="text" id="phoneNum" class="form-control">
							</div>
						</div>
					</div>
					
					<div class="row">
							<div class="col-lg-6">
								<div class="input-group">
									头像:
									<div style="height: 100px;"><br/>
									<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" class="autoImg" onclick="$('#upload').click();"><br/><br/>
									<img  src="" id="imageUrlShow" style="max-width: 50px">
									<input type="file" name="logoFile" id="upload" onchange="setImg(this)" style="display: none;">
									<input type="hidden" id="imageUrl" class="form-control">
								</div>
							</div>
						</div>
					</div>
					<br/><br/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								收货地址:
								<input type="text" id="address" class="form-control">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								积分:
								<input type="text" id="score" class="form-control" value="0">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								余额:
								<input type="text" id="money" class="form-control" value="0">
							</div>
						</div>
					</div>
				</form>
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="javascript:check();" >
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
	  	window.location.href='/wx/user/sys/index?page='+currPage;
	});
	$(".next").click(function(){
		
		if(currPage>=total){
 			return true;
 		}
		currPage++;
		console.log("下一页"+currPage);
		window.location.href='/wx/user/sys/index?page='+currPage;
	});
	
	var path_pre ="<%= pageContext.getServletContext().getContextPath()%>";
		
	function setImg(obj){
		var f=$(obj).val();
		alert(f);
		console.log(obj);
	    if(f == null || f ==undefined || f == ''){
	        return false;
		}
	    if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
	    {
	        alert("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
	        $(obj).val('');
	        return false;
	    }
	    var data = new FormData();
	    console.log(data);
	    $.each($(obj)[0].files,function(i,file){
	        data.append('file', file);
	    });
	    console.log(data);
	    $.ajax({
	        type: "POST",
	        url: "/wx/user/sys/uploadImg",
	        data: data,
	        cache: false,
	        contentType: false,    //不可缺
	        processData: false,    //不可缺
	        dataType:"json",
	        success: function(ret) {
	        	console.log(ret);
	            if(ret.code==0){
	                    $("#imageUrl").val(ret.result.url);//将地址存储好
	                    $("#imageUrlShow").attr("src",path_pre+ret.result.url);//显示图片
	                    alert(ret.message);
	            }else{
	                alertError(ret.message);
	                $("#introduceImage").val("");
	                $(obj).val('');
	            }
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("上传失败，请检查网络后重试");
	        }
	    });
	}
				
</script>

		<script type="text/javascript">
		var currentId;
		
		
			function closeWindow(){
				$(".notescontent").remove();
				$(".baglayer").remove();
			}
			function save(data){
				
				$.ajax({
					type : 'post',
					async : false,
					url : "/wx/user/sys/save",
					data: JSON.stringify(data),//必要
			        dataType:"json",
			        contentType:"application/json",
			        async: false,
			        cache:false,
					success : function(msg) {
						if(msg.code==0){
							alert(msg.message);
							
							window.location.href='/wx/user/sys/index?page='+currPage;
						}else{
							alert("操作失败");
						}
					},
					error : function(msg) {
						console.log(msg);
						alert("操作失败");
					}
				}); 
				
				//隐藏模态框
				//$('#userModel').modal('hide')
			}
			
			function check(){

				
				var name = $("#name").val();
				var phoneNum = $("#phoneNum").val();
				var imageUrl = $("#imageUrl").val();
				var phoneName = $("#phoneName").val();
				var score = $("#score").val();
				var address = $("#address").val();
				var money = $("#money").val();
				
				console.log(parseFloat(money));	
				if(typeof(name)=="undefined"||name.trim().length<=0){	
					alert("请填写账户名");
					return false;
				} 
				/* if(typeof(phoneNum)=="undefined"||phoneNum.trim().length<=0){	
					alert("请填写联系电话");
					return false;
				} 
				 */
				if(typeof(imageUrl)=="undefined"||imageUrl.trim().length<=0){	
					alert("请上传头像");
					return false;
				} 
				/* if(typeof(phoneName)=="undefined"||phoneName.trim().length<=0){	
					alert("请填写连写人");
					return false;
				}  */
				
				
				/* if(typeof(address)=="undefined"||name.trim().length<=0){	
					alert("请填写收货地址！");
					return false;
				}  */
				
				var score_Reg = /^\d+$/;
				if (!score_Reg.test(score)) {
					alert("积分应为数字,且为非负整数！");	
					return false;
				}
				
				if(typeof(score)=="undefined"||score.trim().length<=0){	
					alert("请填写积分！");
					return false;
				}
				
				var money_Reg = /^\d+(\.\d+)?$/;
				
				if (!money_Reg.test(parseFloat(money))) {
					alert("账户金额应为数字,且不为负数！");
					return false;
				}
				if(typeof(money)=="undefined"||money.trim().length<=0){	
					alert("请填写账户金额！");
					return false;
				} 
				
				var data ={
						'id':currentId,
						'name':name,
						'phoneNum':phoneNum,
						'imageUrl':imageUrl,
						'phoneName':phoneName,
						'score':score,
						'money':parseFloat(money),
						'address':address
				};
				
				save(data);
			}
				
				$(".add").on('click', function() {
					addSpot();
				});
				
				function addSpot(id) {
					noteshtml(id);
				}
				
				function noteshtml(id) {
					console.log(id);
					var str = "";
					currentId=id;
					if(id!=null|typeof(id)!='undefined'){
						$('#title').text("修改用户");
						//修改
						$.ajax({
							type : 'post',
							async : false,
							url : "/wx/user/sys/get?id="+id,
					        dataType:"json",
					        contentType:"application/json",
					        async: false,
					        cache:false,
							success : function(msg) {
								if(msg){
											
									//给模态框赋值
									$("#name").val(msg.name);
									$("#phoneNum").val(msg.phoneNum);
									$("#imageUrl").val(msg.imageUrl);
									$("#imageUrlShow").attr("src",path_pre+msg.imageUrl);
									$("#phoneName").val(msg.phoneName);
									$("#score").val(msg.score);
									$("#address").val(msg.address);
									$("#money").val(msg.money);
									$('#userModel').modal('show');
								}
							},
							error : function(msg) {
								console.log(msg);
							}
						});
					}else{
						$('#title').text("添加用户");
						//添加
						//给模态框赋值---添加之初始化
						$("#name").val("");
						$("#phoneNum").val("");
						$("#imageUrl").val("");
						$("#imageUrlShow").attr("src","");
						$("#phoneName").val("");
						$("#score").val(0);
						$("#address").val("");
						$("#money").val(0);
						$('#userModel').modal('show');
					}
				}
				
				//修改
				function update(id){
					
					//打开弹窗
					addSpot(id);
				}
				//删除
				function removeObj(id){
					var message= confirm("确定要删除吗？");
					if(message){
						$.ajax({
							type : 'get',
							async : false,
							url : "/wx/user/sys/remove?id="+id,
							// 如果参数为json，加上这句
							contentType : "text/json",
							// 规定反参类型为text
							dataType : "json",
							success : function(msg) {
								if(msg.code==0){
									window.location.href='/wx/user/sys/index?page='+currPage;
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
			
			
		</script>		
 </body>
</html>








