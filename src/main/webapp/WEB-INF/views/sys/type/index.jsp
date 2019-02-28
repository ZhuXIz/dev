
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品分类信息</title>
	
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
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示:谨慎操作商品分类!</p>
				<!--编辑内容-->
					<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initGoodsType(null)" type="button">
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
  
  <!-- 商品分类信息态框 -->
<div class="modal fade" id="goodsTypeModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="goodsTypeTitle">
					商品分类详情
				</h4>
			</div>
		
			<div class="modal-body" id ='goodsTypeContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				
				 <input type='hidden' id="id" class="form-control" />
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							商品类名
							<input type="text" class="form-control" id="genreName">
						</div>
					</div>
				</div>
				<br/>
				
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="goodsTypeBtn" onclick="javascript:checkGoodsType()">
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
	            field : 'genreName',
	            title : '商品类名',
	            align : 'center',
        	},{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	            	//处理格式化数据
	            	return '<a class="iconfont" onclick="javascript:removeGoodsType(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initGoodsType('+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/type/sys/getAll",      //请求数据的地址URL
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
        	//console.log(params.offset);
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
function removeGoodsType(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/type/sys/remove?id="+id,
			// 如果参数为json，加上这句
			contentType : "text/json",
			// 规定反参类型为text
			dataType : "json",
			success : function(msg) {
				if(msg.code==0){
					alert(msg.message);
					$('#table').bootstrapTable('refresh');
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

var curr_id;
function initGoodsType(id){
	$('#goodsTypeModel').modal('show');
	
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#goodsTypeTitle").text("修改商品分类");
		$("#goodsTypeBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/type/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					console.log("goodsType:"+msg.goods);
				
					curr_id = msg.id;
					$("#genreName").val(msg.genreName);
					
				}
			},
			error : function(msg) {
				alert("错误：获取失败");
				return false;
			}
		});
	}else{
		//添加
		curr_id = id;
		$("#genreName").val("");
	}
}


//输入框验证
function checkGoodsType(){
	var genreName = $("#genreName").val();
	
	if (typeof(genreName)=="undefined"||genreName.trim().length<=0) {
		alert("请填写类名");
		return false;
	}
	 var data ={
		'id':curr_id,
		'genreName':genreName,
	};
	console.log(data);
	
	saveGoodsType(data);
}
function saveGoodsType(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/type/sys/save",
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
	$('#goodsTypeModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
