
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限信息</title>
	
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
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示:最多只支持二级权限</p>
				<!--编辑内容-->
					<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initPermiss(null)" type="button">
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
  
  <!-- 权限信息态框 -->
<div class="modal fade" id="permissModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="permissTitle">
					权限详情
				</h4>
			</div>
			
			<script type="text/javascript">
			
				function select_change(obj){
					console.log($(obj).val());
				}
			</script>
			
			<div class="modal-body" id ='permissContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				
				 <input type='hidden' id="id" class="form-control" />
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							权限名
							<!--  <select name="moreselAge" id="nameSelect" onchange="javascript:select_change(this);">
							 
      						</select>    -->
							<input type="text" class="form-control" id="name">
						</div>
					</div>
				</div>
				<br/>
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							权限配置
							<div id="roleMenu">
							
							</div>
							
						</div>
					</div>
				</div>
				<br/>
				
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" id="permissBtn" onclick="javascript:checkPermiss()">
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
	            visible : false //隐藏列
	        },{
	            field : 'name',
	            title : '权限名',
	            align : 'center',
	        },{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	            	//处理格式化数据
	            	return '<a class="iconfont" onclick="javascript:removePermiss(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initPermiss('+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/permiss/sys/getAllRole",      //请求数据的地址URL
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
       },
       //注册加载子表的事件。你可以理解为点击父表中+号时触发的事件
       onExpandRow : function (index, row, $detail) {
               onclick = row.id;
               var parentId = row.id; 
               var prjLogBookProblemTable = $detail.html('<table></table>').find('table');
               //var test = $detail.html('<table></table>').find('.fixed-table-toolbar');
               
               var addPermissHtml='<div class="operation  mb15">'+
				'<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle="modal" onclick="javascript:initPermiss(null)" type="button">'+
				'<i class="iconfont"></i>&nbsp;添加'+
				'</button>'+
				'</div><br/>';
				$('tr[data-index="'+index+'"]').next().find(".fixed-table-toolbar").html(addPermissHtml);
           }
	 })
        
}); 
</script>

<!--拼团的CRUD  -->
<script type="text/javascript">
//删除
function removePermiss(id){
	var message= confirm("确定要删除吗？");
	if(message){
		$.ajax({
			type : 'get',
			async : false,
			url : "/wx/permiss/sys/remove?id="+id,
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
var menu_Html,item_html="";

function change(id){
	if($("#menu"+id).prop("checked")){
		$("#itemShow"+id).html($("#menuShow"+id).val());
	}else{
		$("#itemShow"+id).html("");
	}

}
function change2(id){
	console.log($("#menu"+id).prop("checked"));
}
function initMenu(){
	$("#roleMenu").html("");
	//菜单配置初始化
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/permiss/sys/getAllMenu",
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg){
				
				$.each(msg,function(idx,obj){
					item_html="";
					menu_Html="";
					menu_Html='<label style="width:150px;"><input type="checkbox" onchange="javascript:change('+obj.id+')"  class="menuCheck" id="menu'+obj.id+'" value="'+obj.id+'" />'+obj.name+'</label><br/>'+
					'<input type="hidden" id="menuShow'+obj.id+'" value="'+obj.id+'" /><div id="itemShow'+obj.id+'" ></div>';
					$("#roleMenu").append(menu_Html);
					if(obj.menus.lenght<=0)
						return true;
					$.each(obj.menus,function(index,item){
						item_html='<label style="width:150px;padding-left:20px;"><input type="checkbox" onchange="javascript:change2('+item.id+')" class="menuCheck" id="item'+item.id+'" value="'+item.id+'" />'+item.name+'</label><br/>'+item_html;
					})
					$("#menuShow"+obj.id).val(item_html);
				})
				//$("#roleMenu").append(menu_Html);
			}else{
				console.log(msg);
			}
		},
		error : function(msg) {
			console.log(msg);
		}
	});
}

var curr_pId,curr_id;
function initPermiss(id){
	$('#permissModel').modal('show');
	$(".menuCheck").prop("checked",false);
	initMenu();
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#permissTitle").text("修改权限");
		$("#permissBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/permiss/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					curr_id = msg.id;
					$("#name").val(msg.name);
					var curr_index= 0;
					$.each(msg.menu,function(idx,obj){
						if(obj.pid == 0||obj.pid==null){
							$("#menu"+obj.id).prop("checked",true);
						}else{
							
							if($("#menu"+obj.pid).prop("checked")&&obj.pid!=curr_index){
								$("#itemShow"+obj.pid).html($("#menuShow"+obj.pid).val());
							}
							curr_index=obj.pid;
							$("#item"+obj.id).prop("checked",true);
						}
					})
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
		$("#name").val("");
	}
	
	
}


//输入框验证
function checkPermiss(){
	var name = $("#name").val();
	
	/* if (typeof(icon)=="undefined"||icon.trim().length<=0) {
		alert("请添加图标！");
		return false;
	} */
	if (typeof(name)=="undefined"||name.trim().length<=0) {
		alert("请填写权限名！");
		return false;
	}
	
	var check_ele = $(".menuCheck");
    var arr = new Array();
    
    for(var i = 0; i < check_ele.length; i++){
	  	if(check_ele[i].checked)
	  		arr.push({'id':check_ele[i].value});
  	}
    var data ={
   		'id':curr_id,
   		'name':name,
   		'menu':arr
    };
	console.log(data);
	
	savePermiss(data);
}
function savePermiss(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/permiss/sys/save",
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
	$('#permissModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
