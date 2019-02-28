
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>轮播图信息</title>
	
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
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示：前端会展示所有轮播图！</p>
				<!--编辑内容-->
					<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initAdvert()" type="button">
							<i class="iconfont"></i>&nbsp;添加
						</button>
					</div>
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
	        url: "/wx/advert/sys/uploadImg",
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
  <!-- 轮播图信息态框 -->
<div class="modal fade" id="advertModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="advertTitle">
					轮播图详情
				</h4>
			</div>
			<div class="modal-body" id ='advertContent' style="padding: 50px 40% 50px 40%;align-items: center;">
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							轮播图:
						<div style="height: 100px;"><br/>
							<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#upload').click();"><br/><br/>
							<img  src="" id="imgShow" style="max-width: 50px">
							<input type="file" name="logoFile" id="upload" onchange="setImg(this)" style="display: none;">
							<input type="hidden" id="img" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<br/><br/>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="advertBtn" onclick="javascript:checkAdvert()">
					确认
				</button>
				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript">
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
	            field : 'img',
	            title : '轮播图',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==null||value==''){
	            		return "<span style='background-color:#a3e02b;font-style:bold'>数据错误：请删除</span>";
	            	}else{
	            		return "<img src='${pageContext.request.contextPath}"+value+"' style='width:200px;'/>";
	            	}
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
	            	return '<a class="iconfont" onclick="javascript:removeAdvert(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initAdvert('+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/advert/sys/getAll",      //请求数据的地址URL
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
function removeAdvert(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/advert/sys/remove?id="+id,
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
function initAdvert(id){
	$('#advertModel').modal('show');
	
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#advertTitle").text("修改轮播图");
		$("#advertBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/advert/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					curr_id=msg.id;
					$("#img").val(msg.img);
					$("#imgShow").attr("src",path_pre+msg.img);
				}
			},
			error : function(msg) {
				alert("错误：获取失败");
				return false;
			}
		});
	}else{
		//添加
		$("#img").val("");
		$("#imgShow").attr("src","");
	}
}


//输入框验证
function checkAdvert(){
	var img = $("#img").val();
	
	if (typeof(img)=="undefined"||img.trim().length<=0) {
		alert("请添加轮播图！");
		return false;
	}
	 
	 var data ={
		'id':curr_id,
		'img':img,
	};
	saveAdvert(data);
}
function saveAdvert(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/advert/sys/save",
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
	$('#advertModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
