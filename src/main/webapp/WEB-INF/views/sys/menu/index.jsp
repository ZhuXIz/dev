
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单信息</title>
	
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
				<p style="text-align: center; background-color: gray; height: 25px;">温馨提示:最多只支持二级菜单</p>
				<!--编辑内容-->
					<div class="operation  mb15">
						<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initMenu(null,0)" type="button">
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
  
  <!-- 菜单信息态框 -->
<div class="modal fade" id="menuModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="menuTitle">
					菜单详情
				</h4>
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
	        url: "/wx/menu/sys/uploadImg",
	        data: data,
	        cache: false,
	        contentType: false,    //不可缺
	        processData: false,    //不可缺
	        dataType:"json",
	        success: function(ret) {
	        	console.log(ret);
	            if(ret.code==0){
	                    $("#icon").val(ret.result.url);//将地址存储好
	                    $("#iconShow").attr("src",path_pre+ret.result.url);//显示图片
	                    alert(ret.message);
	            }else{
	                alertError(ret.message);
	                $("#icon").val("");
	                $("#iconShow").attr("src","");//显示图片
	                $(obj).val('');
	            }
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown) {
	            alert("上传失败，请检查网络后重试");
	        }
	    });
	}
		
  </script>
			
			<div class="modal-body" id ='menuContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				
				 <input type='hidden' id="id" class="form-control" />
				
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							菜单名
							<input type="text" class="form-control" id="name">
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							链接
							<input type="text" class="form-control" id="url" value="#">
						</div>
					</div>
				</div>
				<br/>
				<div class="row">
					<div class="col-lg-10">
						<div class="input-group">
							图标
						<div style="height: 100px;"><br/>
							<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#upload').click();"><br/><br/>
							<img  src="" id="iconShow" style="max-width: 50px">
							<input type="file" name="logoFile" id="upload" onchange="setImg(this)" style="display: none;">
							<input type="hidden" id="icon" class="form-control">
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
				<button type="button" class="btn btn-primary" id="menuBtn" onclick="javascript:checkMenu()">
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
	            field : 'url',
	            title : '菜单链接',
	            align : 'center',
        	},{
	            field : 'name',
	            title : '菜单名',
	            align : 'center',
	        },{
	            field : 'icon',
	            title : '菜单图标',
	            align : 'center',
	            formatter: function(value, row, index) {
	            	if(value==null||value==''){
	            		return "<span style='background-color:#a3e02b;font-style:bold'>无</span>";
	            	}else{
	            		return "<img src='${pageContext.request.contextPath}"+value+"' style='width:50px;'/>";
	            	}
	            }
	        },{
	        	title: '操作',
	            align: 'center',
	            formatter: function(value, row, index) {
	               //处理格式化数据
	            	//处理格式化数据
	            	return '<a class="iconfont" onclick="javascript:removeMenu(\''+row.id+'\')"> </a>'+
	      			'<a class="iconfont" onclick="javascript:initMenu('+row.id+')"> </a>';
	            }
		    }],
        url: "/wx/menu/sys/getAll",      //请求数据的地址URL
        method: 'post',  //请求方式(*)
        striped: true,  //是否显示行间隔色
        cache: false,  //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性(*)
        pagination: true,
        sortable: true,  //是否启用排序
        sortMenu: "desc", //排序方式
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
       	
           //  onloadInitTable(index, row, $detail);
               //console.log(index);
               //console.log(row);
               onclick = row.id;
               var parentId = row.id; 
               var prjLogBookProblemTable = $detail.html('<table></table>').find('table');
               //var test = $detail.html('<table></table>').find('.fixed-table-toolbar');
               
               $(prjLogBookProblemTable).bootstrapTable({    

        	   columns: [/* {                         
                   checkbox : true,
       	        },*/{
    	            field : 'id',
    	            title : '自增id',
    	            align : 'center',
    	            visible : false, //隐藏列
    	        },{
    	            field : 'url',
    	            title : '菜单链接',
    	            align : 'center',
            	},{
    	            field : 'name',
    	            title : '菜单名',
    	            align : 'center',
    	        },{
    	            field : 'icon',
    	            title : '菜单图标',
    	            align : 'center',
    	            formatter: function(value, row, index) {
    	            	if(value==null||value==''){
    	            		return "<span style='background-color:#a3e02b;font-style:bold'>无</span>";
    	            	}else{
    	            		return "<img src='${pageContext.request.contextPath}"+value+"' style='width:50px;'/>";
    	            	}
    	            }
    	        },{
    	        	title: '操作',
    	            align: 'center',
    	            formatter: function(value, row, index) {
    	               //处理格式化数据
    	            	return '<a class="iconfont" onclick="javascript:removeMenu(\''+row.id+'\')"> </a>'+
    	      			'<a class="iconfont" onclick="javascript:initMenu('+row.id+','+row.pid+')"> </a>';
    	            }
    		    }],
                url :'/wx/menu/sys/getAllItem?pid='+parentId,
                method : 'POST', //请求方式(*)
                sortable : true, //是否启用排序
                sortName : 'id',
                pagination: true,
       	        sidePagination: "server",  //分页方式：client客户端分页，server服务端分页(*)
       	        pageNumber: 1, //初始化加载第一页，默认第一页
       	        pageSize: 8,  //每页的记录行数(*)
       	        pageList: [20, 50, 100],  //可供选择的每页的行数(*)
       	        clickToSelect: true,   //是否启用点击选中行
                   sortOrder : 'asc', //排序方式                               
                   clickToSelect : true, //是否启用点击选中行
                   uniqueId : "id", //每一行的唯一标识，一般为主键列
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
       	            		//id: $("input[name='id']").val(),
           	                //name: $("input[name='name']").val(),
       	                    limit : params.limit, // 每页显示数量
       	                    offset : params.offset, // SQL语句起始索引
       	                    page: (params.offset/params.limit) + 1, //当前页码
       	                };
       	                return temp;
       	        },
                onLoadError: function(){  //加载失败时执行  
                     layer.msg("加载数据出错!", {time : 1500, icon : 5});
                }
       	    	 
              });
               var addMenuHtml='<div class="operation  mb15">'+
				'<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle="modal" onclick="javascript:initMenu(null,'+parentId+')" type="button">'+
				'<i class="iconfont"></i>&nbsp;添加'+
				'</button>'+
				'</div><br/>';
				$('tr[data-index="'+index+'"]').next().find(".fixed-table-toolbar").html(addMenuHtml);
           }
	 })
        
}); 
</script>

<!--拼团的CRUD  -->
<script type="text/javascript">
//删除
function removeMenu(id){
	var is_ok = true;
	$.ajax({
		type : 'get',
		async : false,
		url : "/wx/menu/sys/checkItem?id="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				alert(msg.message);
				is_ok = false;
			}else{
				console.log("无子菜单");
				is_ok = true;
			}
		},
		error : function(msg) {
			console.log("删除失败");
		}
	});
	
	
	
	if(is_ok){
		var message= confirm("确定要删除吗？");
		if(message){
			$.ajax({
				type : 'get',
				async : false,
				url : "/wx/menu/sys/remove?id="+id,
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
}

var curr_pId,curr_id;
function initMenu(id,pId){
	$('#menuModel').modal('show');
	
	if(id!=null&&id!="null"&&typeof(id)!="undefinded"){
		$("#menuTitle").text("修改菜单");
		$("#menuBtn").text("修改");
		//修改初始化
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/menu/sys/get?id="+id,
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				if(msg){
					console.log("menu:"+msg.goods);
				
					curr_id = msg.id;
					curr_pId = msg.pid
					$("#url").val(msg.url);
					$("#icon").val(msg.icon);
					$("#iconShow").attr("src",path_pre+msg.icon);
					$("#name").val(msg.name);
					
				}
			},
			error : function(msg) {
				alert("错误：获取失败");
				return false;
			}
		});
	}else{
		//添加
		curr_pId = pId;
		curr_id = id;
		$("#url").val("");
		$("#icon").val("");
		$("#iconShow").attr("src","");
		$("#name").val("");
	}
}


//输入框验证
function checkMenu(){
	var url = $("#url").val();
	var icon = $("#icon").val();
	var name = $("#name").val();
	
	if (typeof(url)=="undefined"||url.trim().length<=0) {
		alert("请填写链接");
		return false;
	}
	/* if (typeof(icon)=="undefined"||icon.trim().length<=0) {
		alert("请添加图标！");
		return false;
	} */
	if (typeof(name)=="undefined"||name.trim().length<=0) {
		alert("请填写菜单名！");
		return false;
	}
	if(curr_pId!=null&&curr_pId!=0){
		var message= confirm("子菜单添加！上级菜单链接将清楚,继续吗？");
		if(!message){
			alert("请确认");
			return false;
		}
	}
	 var data ={
		'id':curr_id,
		'pid':curr_pId,
		'name':name,
		'icon':icon,
		'url':url,
	};
	console.log(data);
	
	saveMenu(data);
}
function saveMenu(data){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/menu/sys/save",
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
	$('#menuModel').modal('hide');
	$('#table').bootstrapTable('refresh');
	
}
</script>


 </body>
</html>
