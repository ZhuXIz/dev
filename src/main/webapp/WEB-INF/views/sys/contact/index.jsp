
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>关于我们信息</title>
	
		<!-- 1、Jquery组件引用 -->
	    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	 
	    <!-- 2、bootstrap组件引用 -->
	    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
	    
	   <!--  3、bootstrap table组件以及中文包的引用 -->
	    <script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
	    <link href="${pageContext.request.contextPath}/css/bootstrap-table.css" rel="stylesheet" />
	    <script src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>
	    
	    
	    <!-- 系统 -->
		<link href="${pageContext.request.contextPath}/font/iconfont.css" rel="stylesheet" type="text/css" />
		<!-- /*datetime控件*/ -->
	    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
		<link href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" rel="stylesheet">
		
	 	<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/defaults-zh_CN.min.js"></script>
</head>


<body id="situation">
	<div class="pages-style" >

		<!--右侧内容-->
	<div class="bk-con-message message-section " id="iframe_box">
           <!--编辑内容-->
			<div class="operation  mb15">
				<br/> &nbsp;&nbsp;&nbsp;
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示：只许存在一条数据!</p>
				<!--编辑内容-->
				<!-- 	<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initContact()" type="button">
							<i class="iconfont"></i>&nbsp;添加
						</button>
					</div> -->
			</div>
           <!--列表内容-->
           <div class="page_content clearfix mb15 table-module ">
        	 <table id="table"></table>
           </div>
    </div>
  </div>
  <script type="text/javascript">
  
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
	        url: "/wx/contact/sys/uploadImg",
	        data: data,
	        cache: false,
	        contentType: false,    //不可缺
	        processData: false,    //不可缺
	        dataType:"json",
	        success: function(ret) {
	        	console.log(ret);
	            if(ret.code==0){
	                    $("#img").val(ret.result.url);//将地址存储好
	                    $("#imgShow").attr("src",path_pre+ret.result.url);//显示图片
	                    alert(ret.message);
	            }else{
	                alertError(ret.message);
	                $("#img").val("");
	                $("#imgShow").attr("src","");//显示图片
	                $(obj).val('');
	            }
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("上传失败，请检查网络后重试");
	        }
	    });
	}
		
  </script>
    <!-- 关于我们信息态框 -->
<div class="modal fade" id="IntModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="IntTitle">
					公司介绍
				</h4>
			</div>
			<div class="modal-body"  style="padding: 50px 30% 50px 25%;">
			公司介绍:
			<textarea id ='IntContent' rows="30" cols="50"  style="border: none;"></textarea>
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


  <!-- 关于我们信息态框 -->
<div class="modal fade" id="contactModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="contactTitle">
					关于我们详情
				</h4>
			</div>
			<div class="modal-body" id ='contactContent' style="padding: 50px 40% 50px 40%;align-items: center;">
				<input type="hidden" id="id" class="form-control">
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							公司介绍:
								<textarea id="introduce" rows="10" cols="30">
								
								</textarea>
						</div>
					</div>
				</div>
			<br/>
			
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					公司名字
						<input type="text" id="companyName" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					公司地址
						<input type="text" id="companyAddress" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					公司相关链接（官网）
						<input type="text" id="companyUrl" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					联系电话
						<input type="text" id="phoneNum" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					工作时间
						<input type="text" id="onTime" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			
			<div class="row">
				<div class="col-lg-10">
				<div class="input-group">
					联系人
						<input type="text" id="phoneName" class="form-control">
				</div>
				</div>
			</div>
			<br/>
			
			<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
						客服二维码
						<div style="height: 100px;"><br/>
							<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#upload').click();"><br/><br/>
							<img  src="" id="imgShow" style="max-width: 50px">
							<input type="file" name="logoFile" id="upload" onchange="setImg(this)" style="display: none;">
							<input type="hidden" id="img" class="form-control">
						</div>
					</div>
				</div>
			</div>
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="contactBtn" onclick="javascript:checkContact()">
					确认
				</button>
				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
function openIntContent(value){
	$('#IntModel').modal('show');
	$('#IntContent').val(value);
}
$(function() {
	
	 $('#table').bootstrapTable('destroy').bootstrapTable({
		 
		columns: [/* {                         
            checkbox : true,
	        },*/{
	            field : 'id',
	            title : '自增id',
	            align : 'center',
	            visible : false, //隐藏列
	        },{
	            field : 'introduce',
	            title : '公司介绍',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	return '<button class="btn button_btn" onclick="javascript:openIntContent(\''+value+'\')" type="button">查看</button>';
	            }
		     },{
	            field : 'companyName',
	            title : '公司名',
	            align : 'center'
		     },{
	            field : 'companyAddress',
	            title : '公司地址',
	            align : 'center'
		     },{
	            field : 'companyUrl',
	            title : '官网',
	            align : 'center'
		     },{
	            field : 'phoneNum',
	            title : '联系电话',
	            align : 'center'
		     },{
	            field : 'phoneName',
	            title : '联系人',
	            align : 'center'
		     },{
	            field : 'onTime',
	            title : '营业时间',
	            align : 'center'
		     },{
	            field : 'service',
	            title : '客服微信',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	return "<img style='width:100px;' src='${pageContext.request.contextPath}"+value+"'/>";
	            	
	            }
		     },{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	               var sellerId,userId;
 	            	if(row.seller==null)
 	            		sellerId=null;
 	            	else
 	            		sellerId =row.seller.id;
 	            	if(row.user==null)
 	            		userId=null;
 	            	else
 	            		userId =row.user.id;
	            	return '<a class="iconfont" onclick="javascript:initContact('+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/contact/sys/getAll",      //请求数据的地址URL
        method: 'post',  //请求方式(*)
        striped: true,  //是否显示行间隔色
        cache: false,  //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性(*)
        pagination: true,
        sortable: true,  //是否启用排序
        sortOrder: "desc", //排序方式
        sidePagination: "server",  //分页方式：client客户端分页，server服务端分页(*)
        pageNumber: 1, //初始化加载第一页，默认第一页
        pageSize: 8,  //每页的记录行数(*)
        pageList: [20, 50, 100],  //可供选择的每页的行数(*)
        showColumns: false,  //是否显示所有的列
        showRefresh: false,  //是否显示刷新按钮
        minimumCountColumns: 2,  //最少允许的列数
        clickToSelect: true,   //是否启用点击选中行
        height: 700,
        detailView: true,  //是否显示父子表    *关键位置*
        queryParamsType: "limit",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        checkboxHeader: true,
        search: false,
        singleSelect: true,
        striped: true,
        showColumns: true,  // 开启自定义列显示功能
        responseHandler: function responseHandler(sourceData) {
            //这里要做分页，所以对返回的数据进行了处理
            return {
                "total": sourceData.count,  // 总条数
                "rows": sourceData.rows // 返回的数据列表（后台返回一个list集合）
            };
        },queryParams : function (params) {
            var temp = {
                    limit : params.limit, // 每页显示数量
                    offset : params.offset, // SQL语句起始索引
                    page: (params.offset / params.limit) + 1,//当前页码
                };
                return temp;
       }
	 })
        
}); 
</script>

<!--拼团的CRUD  -->
<script type="text/javascript">
//删除
function removeContact(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/contact/sys/remove?id="+id,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if(msg.code==0){
					alert(msg.message);
					$('#table').bootstrapTable('refresh');
				}else{
					console.log(msg.message);
				}
			},
			error : function(msg) {
				
				console.log("删除失败");
			}
		});
		
	}
}

var curr_id;
function initContact(id){
	$('#contactModel').modal('show');
	
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#contactTitle").text("修改关于我们");
		$("#contactBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/contact/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					curr_id=msg.id;
					$("#id").val(msg.id);
					$("#introduce").val(msg.introduce);
					$("#companyName").val(msg.companyName);
					$("#companyAddress").val(msg.companyAddress);
					$("#companyUrl").val(msg.companyUrl);
					$("#phoneNum").val(msg.phoneNum);
					//$("#img").val(msg.service);
					$("#phoneName").val(msg.phoneName);
					$("#onTime").val(msg.onTime);
					
					$("#img").val(msg.service);
					$("#imgShow").attr("src",path_pre+msg.service);
				}
			},
			error : function(msg) {
				alert("错误：获取失败");
				return false;
			}
		});
	}else{
		return false;
	}
}


//输入框验证
function checkContact(){
	var service = $("#img").val();
	var introduce = $("#introduce").val();
	var companyName = $("#companyName").val();
	var companyAddress = $("#companyAddress").val();
	var companyUrl = $("#companyUrl").val();
	var phoneNum = $("#phoneNum").val();
	var phoneName = $("#phoneName").val();
	var onTime = $("#onTime").val();
	
	
	if (typeof(service)=="undefined"||service.trim().length<=0) {
		alert("请添加客服二维码！");
		return false;
	}
	if (typeof(introduce)=="undefined"||introduce.trim().length<=0) {
		alert("请填写公司简介！");
		return false;
	}
	if (typeof(companyName)=="undefined"||companyName.trim().length<=0) {
		alert("请填写公司名！");
		return false;
	}
	if (typeof(companyUrl)=="undefined"||companyUrl.trim().length<=0) {
		alert("请填写公司相关网址！");
		return false;
	}
	if (typeof(phoneNum)=="undefined"||phoneNum.trim().length<=0) {
		alert("请填写联系电话！");
		return false;
	}
	if (typeof(phoneName)=="undefined"||phoneName.trim().length<=0) {
		alert("请填写联系人！");
		return false;
	}
	if (typeof(onTime)=="undefined"||onTime.trim().length<=0) {
		alert("请填写联系时间！");
		return false;
	}
	 
	if(phoneNum && !/^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/.test(phoneNum)){
		 alert("不支持的手机格式"); 
		 return false;
	} 

	 var data ={
		'id':curr_id,
		'service':service,
		'introduce':introduce,
		'companyName':companyName,
		'companyAddress':companyAddress,
		'companyUrl':companyUrl,
		'phoneNum':phoneNum,
		'phoneName':phoneName,
		'onTime':onTime
	};
 console.log(data);
	saveContact(data);
}
function saveContact(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/contact/sys/save",
		data: JSON.stringify(data),//必要
        dataType:"json",
        contentType:"application/json",
        async: false,
        cache:false,
		success : function(msg) {
			console.log(msg);
			if(msg.code==0){
				alert(msg.message);
				
			}else{
				alert(msg.message);
			}
		},
		error : function(msg) {
			console.log(msg);
			alert("添加失败");
		}
	}); 
	$('#contactModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
