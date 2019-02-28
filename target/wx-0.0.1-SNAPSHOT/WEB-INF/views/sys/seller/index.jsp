
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
 <!-- 引入bootstrap样式 -->
		
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
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/show.css">
	    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
		<link href="${pageContext.request.contextPath}/css/bootstrap-select.min.css" rel="stylesheet">
		
	 	<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
	    <script src="${pageContext.request.contextPath}/js/bootstrap-select.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/defaults-zh_CN.min.js"></script>
	
		
	    <!-- 导出 -->
		<%-- <script src="${pageContext.request.contextPath}/js/bootstrap-table-export.min.js"></script> --%>
		<!-- <script src="js/tableExport.js"></script> -->
		
		<!-- **************地图接口*********** -->
		<script charset="utf-8" src="https://map.qq.com/api/js?v=2.exp&key=2ZXBZ-CTX3J-EPVFZ-KRXCX-2PVVZ-N4BPQ"></script>
						
<style type="text/css">
body, button, input, select, textarea {
	font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
}

p {
	width: 100%;
	padding-top: 3px;
	margin-top: 10px;
	overflow: hidden;
}

input#address {
	width: 300px;
}

#container {
	width: 300px;
	height: 300px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.inputCom{
	display: flex;
	margin-top:10px;
	margin-bottom:10px;
    justify-content:center;
}

.titleImage{
	width: 100%;
	height: 160px;
}

.autoImg{
	width:23%;
	height:75px;
	margin-top: 5px;
}
</style>



<script type="text/javascript">
//获取网站根路径
var path_pre ="<%= pageContext.getServletContext().getContextPath()%>";


    function show(obj,to_obj) {
        var item = $("#"+to_obj)[0];
        
        if (item.className == "yes") {
            item.className="off";
            $(obj).html("查看");
        }else{
        	item.className = "yes";
        	$(obj).html("收起");
        }
    }
    
    
    
    
    
    //图片上传
	
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
	        url: "/wx/seller/sys/uploadImg",
	        data: data,
	        cache: false,
	        contentType: false,    //不可缺
	        processData: false,    //不可缺
	        dataType:"json",
	        success: function(ret) {
	        	console.log(ret);
	            if(ret.code==0){
	                    $("#introduceImage").val(ret.result.url);//将地址存储好
	                    $("#introduceImageShow").attr("src",path_pre+ret.result.url);//显示图片
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
function pass(id){
	$.ajax({
		type : 'post',
		async : false,
		url : "/wx/seller/sys/pass?id="+id,
		// 如果参数为json，加上这句
		contentType : "text/json",
		// 规定反参类型为text
		dataType : "json",
		success : function(msg) {
			if(msg.code==0){
				alert("通过审核");
				window.location.reload();
					
			}else{
				alert(msg.message);
			}
		},
		error : function(msg) {
			alert("未知错误");
		}
	})
	
}


//模态框处理
function viewIntro(obj){
	$('#introContent').html("");
	var content = $(obj).find("#introduceText").val();
	if(content.trim().length<=0)
		$('#introContent').html("没有内容");
	else
		$('#introContent').html(content);
}

function viewGoodsItem(obj){
	var str = $("#goodsItem").val();
	$('#goodsItemContent').html("");
	if(str.trim().length<=0||str=='#'){
		$('#goodsItemContent').html("没有内容！");
	}else{
		$('#goodsItemContent').load(path_pre+str);
	}
	
	if($('#goodsItemContent').html()==""){
		$('#goodsItemContent').html("没有内容！");
	}
}

function addSelller(){
}
</script>
</head>


<body id="situation">

	<div class="pages-style">
		<!--右侧内容-->
		<div class="bk-con-message message-section " id="iframe_box">
		
			<!--编辑内容-->
			<div class="operation  mb15">
				<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle='modal' onclick="javascript:initSeller()" type="button">
					<i class="iconfont"></i>&nbsp;添加商家
				</button>
			</div>
			<table id="table"></table>
    
    <script>
   
    $(function() {
    	
    	//先销毁表格，在初始化
    	    $('#table').bootstrapTable('destroy').bootstrapTable({
    	        columns: [/* {
    	            checkbox: true
    	        }, */{
                    field : 'id',
                    title : '自增id',
                    align : 'center',
                    visible : false, //隐藏列
                },{
                    field : 'name',
                    title : '商家名',
                    align : 'center',
                },{
                    field : 'phoneName',
                    title : '联系人',
                    align : 'center',
                },{
                    field : 'phoneNum',
                    title : '联系电话',
                    align : 'center',
                },
    	        {
                	field: 'addressStr',
    	            title: '地址',
    	            align: 'center',
    	        },
    	        {
    	        	field: 'introduceImage',
    	        	title: '商家图',
    	            align: 'center',
    	            formatter: function(value, row, index) {
      	               //处理格式化数据
      	            	return "<img src='${pageContext.request.contextPath}"+value+"' style='max-width: 50px'>";
      	            }
    	        },
    	        {
    	        	field: 'introduceText',
    	        	title: '商家介绍',
    	            align: 'center',
    	            formatter: function(value, row, index) {
  	            		//处理格式化数据
       	            	return "<button class='btn button_btn bg-deep-blue' data-toggle='modal' data-target='#introModel' onclick='javascript:viewIntro(this)'>"+
       	            	"<input id='introduceText' type='hidden' value='"+value+"'>查看</button>";
     	            }
    	        },
    	        {
    	        	field: 'isValid',
    	        	title: '营业状态',
    	            align: 'center',
    	            formatter: function(value, row, index) {
    	               //处理格式化数据
    	               if(value==1){
    	            	   return "营业中";
    	               }else if(value==0){
    	            	   return '<button class="btn button_btn bg-deep-blue" type="button"  onclick="javascript:pass(\''+row.id+'\')" ><i class="iconfont"></i>&nbsp;通过</button>';
    	               }
    	            }
					
    	        },
    	        {
    	        	title: '操作',
    	            align: 'center',
    	            formatter: function(value, row, index) {
     	               //处理格式化数据
     	            	return '<a class="iconfont" onclick="javascript:removeSeller(\''+row.id+'\')"> </a>'+
	           			'<a class="iconfont" onclick="javascript:initSeller(\''+row.id+'\')"> </a>';
     	            }
    	        }
    	        ],
    	        url: "/wx/seller/sys/getAll",      //请求数据的地址URL
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
    	                    page: (params.offset / params.limit) + 1,  //当前页码
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

                            columns : [/* {                         
                                checkbox : true,
                            },*/{
                                field : 'id',
                                title : '自增id',
                                align : 'center',
                                visible : false, //隐藏列
                            },{
                                field : 'titleName',
                                title : '商品标题',
                                align : 'center',
                            },{
                                field : 'titleImage',
                                title : '商品标题图',
                                align : 'center',
                	            formatter: function(value, row, index) {
                    	               //处理格式化数据
                    	            	return "<img src='${pageContext.request.contextPath}"+row.titleImage+"' style='max-width: 50px'>";
                    	        }
                            },{
                                field : 'images',
                                title : '商品轮播图',
                                align : 'center',
                	            formatter: function(value, row, index) {
                	            	var html="";
                	            	if(value.length <= 0){
                	            		html="暂无图片";
                	            	}else{
                	            		for ( var item in value) {
                    	            		//console.log(value[item].image);
                    	            		html+="<img src='${pageContext.request.contextPath}"+value[item].image+"' style='max-width: 60px'><br/><br/>";
                    	            		
    									}
                	            	}
                	            	
                   	               //处理格式化数据
                   	            	return html;
                   	            }
                            },{
                                field : 'itemSrc',
                                title : '商品详情',
                                align : 'center',
                	            formatter: function(value, row, index) {
                	            	console.log(row);
                	            	console.log("value:"+value);
              	            		//处理格式化数据
                   	            	return "<button class='btn button_btn bg-deep-blue' data-toggle='modal' data-target='#goodsItemModel' onclick='javascript:viewGoodsItem(this)'>"+
                   	            	"<input id='goodsItem' type='hidden' value='"+value+"'>查看</button>";
                 	            }
                            },{
                                field : 'goodsType.id',
                                title : '商品类型',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value == 1){
                                    	 return  "旅游";
                                    }else if(value == 2){
                                    	return  "美食";
                                    }else if(value == 3){
                                    	return  "KTV";
                                    }else if(value == 3){
                                    	return  "服装";
                                    }else{
                                    	return  "其他";
                                    }
                                }
                            },{
                                field : 'payType',
                                title : '支付类型',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value == 1){
                                    	 return  "到店付";
                                    }else if(value == 2){
                                    	return  "在线付";
                                    }
                                }
                            },{
                                field : 'publish',
                                title : '发布时间',
                                align : 'center'
                            },{
                                field : 'preTime',
                                title : '开始时间',
                                align : 'center'/* ,
                                formatter : function(value, row, index) {
                                    if(value == null ||typeof(value)=='undefined'){
                                   	 return  "过期";
                                   }else{
                                	   return  value;
                                   }
                               } */
                            },{
                                field : 'sufTime',
                                title : '结束时间',
                                align : 'center'
                            },{
                                field : 'oldPrice',
                                title : '原价',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value == null ||typeof(value)=='undefined'){
                                   	 return  "未标价";
                                   }else{
                                	   return  value;
                                   }
                               }
                            },{
                                field : 'price',
                                title : '现价',
                                align : 'center'
                            },{
                                field : 'soldNum',
                                title : '售出数量',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value == null ||typeof(value)=='undefined'){
                                   	 return  0;
                                   }else{
                                	   return  value;
                                   }
                               }
                            },{
                                field : 'resNum',
                                title : '总数量',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value == null ||typeof(value)=='undefined'||value==0){
                                   	 return  "无限制";
                                   }else{
                                	   return  value;
                                   }
                               }
                            },{
                                field : 'browNum',
                                title : '浏览量',
                                align : 'center'
                            },{
                                field : 'isRecommend',
                                title : '推荐商家',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value ==1){
                                   	 return  "是";
                                   }else{
                                	   return  "否";
                                   }
                               }
                            },{
                            	/*是否过期(1<==>不过期，0<==>过期,2<==>即将开始)*/
                                field : 'isValid',
                                title : '状态',
                                align : 'center',
                                formatter : function(value, row, index) {
                                    if(value ==1){
                                   	 return  "进行中";
                                   }else if(value ==2){
                                	   return  "即将开始";
                                   }else{
                                	   return  "已结束";
                                   }
                               }
                            },
                	        {
                	        	title: '操作',
                	            align: 'center',
                	            formatter: function(value, row, index) {
                 	               //处理格式化数据
                 	            	return '<a class="iconfont" onclick="javascript:removeGoods(\''+row.id+'\')"> </a>'+
            	           			'<a class="iconfont" onclick="javascript:initGoods(\''+parentId+'\',\''+row.id+'\')"> </a>';
                 	            }
                	        }],
                            url :'/wx/seller/sys/getGoods?sellerId=' +parentId,
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
                        
                        //console.log(parentId);
                        addGoodsHtml='<div class="operation  mb15">'+
        				'<br/> &nbsp;&nbsp;&nbsp;<button class="btn button_btn" data-toggle="modal" onclick="javascript:initGoods(\''+parentId+'\')" type="button">'+
    					'<i class="iconfont"></i>&nbsp;添加商品'+
    					'</button>'+
    					'</div><br/>';
    					$('tr[data-index="'+index+'"]').next().find(".fixed-table-toolbar").html(addGoodsHtml);
                        
                    },   
                    
    	    });
    	/* 
    	$('#table').append("上一页/下一页"); */
    	    
    	}); 
    
    
    
    
</script>
    
    
    

<!-- 模态框（Modal） -->
<div class="modal fade" id="introModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="myModalLabel">
					商家文字介绍
				</h4>
			</div>
			<div class="modal-body" id ='introContent'>
				无内容
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" >
					确定
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 模态框（Modal）2------------------展示商品详情 -->
<div class="modal fade" id="goodsItemModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="myModalLabel">
					商品详情
				</h4>
			</div>
			<div class="modal-body" id ='goodsItemContent'>
				无内容
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<!-- 模态框（Modal）3------------------添加商家 -->
<div class="modal fade" id="addSellerModel" tabindex="-1" role="dialog" aria-labelledby="sellerModelTitile" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="sellerModelTitile">
					添加商家
				</h4>
			</div>
			
			
			<div class="modal-body" id ='addSellerContent' style="padding: 50px 30% 50px 30%;align-items: center;">
				<form class="bs-example bs-example-form" role="form">
				
				
					<div class="row">
							<div class="col-lg-6">
								<div class="input-group">
									商家图:
									<div style="height: 100px;"><br/>
									<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#upload').click();"><br/><br/>
									<img  src="" id="introduceImageShow" style="max-width: 50px">
									<input type="file" name="logoFile" id="upload" onchange="setImg(this)" style="display: none;">
									<input type="hidden" id="introduceImage" class="form-control">
								</div>
							</div>
						</div>
					</div>
					<br/><br/>
				
				
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								商家名:
								<input type="text" class="form-control" id="name">
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								联系人:
								<input type="text" class="form-control" id="phoneName">
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								联系电话:
								<input type="text" class="form-control" id="phoneNum">
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								地址:
								<input type="text" class="form-control" id="addressStr">
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								营业时间:
								<input type="text" class="form-control" id="onTime">
							</div>
						</div>
					</div>
					<br/>
					
					
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								地图:
								<div id="container" >
									<input type="hidden" class="form-control" id="address">
								</div>
								
							</div>
						</div>
					</div>
					<br/>
					
					
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							商家介绍:
							<textarea rows="8" cols="40"  name="message" id="introduce" placeholder="商家介绍（可不填）"  ></textarea>
							</div>
						</div>
					</div>
					<br/>
				</form>
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="javascript:checkSeller()">
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">

var imageStr=[];
var images_index=0;
function setGoodsImg(obj){
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
   // console.log(data);
    $.each($(obj)[0].files,function(i,file){
        data.append('file', file);
    });
    //console.log(data);
    $.ajax({
        type: "POST",
        url: "/wx/goods/sys/uploadImg",
        data: data,
        cache: false,
        contentType: false,    //不可缺
        processData: false,    //不可缺
        dataType:"json",
        success: function(ret) {
        	console.log(ret);
        	//var imageStr= $("#goodsImage").val();
            if(ret.code==0){
            	imageStr.push({
            		'image':ret.result.url
            	});
            	 // imageStr+="&"+ret.result.url;
                 //$("#goodsImage").val(imageStr);//将地址存储好
                 images_index++;
                 var showHtml ="<img src='"+path_pre+ret.result.url+"' style='max-width:50px;' onclick='removeImg(this,"+images_index+")'/>";
               	//显示图片  
                 $(".imageShowCon").append(showHtml); 
                 alert(ret.message);
                 console.log($("#goodsImage"));
            }else{
                alertError(ret.message);
                imageStr.length=0;
                $("#goodsImage").val("");
                $(obj).val('');
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
        }
    });
}


function removeImg(obj,index){
	var message= confirm("确定要删除该图片吗？");
	if(message){
		$(obj).remove();
		imageStr.splice(index,1);
		images_index=imageStr.length;
		console.log("imageStr:"+imageStr);
		alert("删除成功!");
		return true;
	}else{
		alert("取消删除!");
		return true;
	}
}

function setTitleImg(obj){
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
    //console.log(data);
    $.each($(obj)[0].files,function(i,file){
        data.append('file', file);
    });
    //console.log(data);
    $.ajax({
        type: "POST",
        url: "/wx/goods/sys/uploadImg",
        data: data,
        cache: false,
        contentType: false,    //不可缺
        processData: false,    //不可缺
        dataType:"json",
        success: function(ret) {
        	//console.log(ret);
            if(ret.code==0){
            	//alert($(".titleImage"));
            		//console.log($(".titleImage"));
            		$(".titleImage").html("<img src='"+path_pre+ret.result.url+"' style='max-width:50px;'/>");
                    $("#titleImage").val(ret.result.url);//将地址存储好
                    //$("#photourlShow").attr("src",path_pre+ret.result.url);//显示图片
                    alert(ret.message);
            }else{
                alertError(ret.message);
                $("#titleImage").val("");
                $(obj).val('');
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
        }
    });
}


</script>

<!-- 模态框（Modal）3------------------添加商品 -->
<div class="modal fade" id="addGoodsModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="goodsModelTitile">
					添加商品
				</h4>
			</div>
			<div class="modal-body" id ='addGoodsContent' style="padding: 50px 30% 50px 30%;align-items: center;">
			
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								商品图<br/><br/>
								<span class="titleImage">
								</span>
								
								<img src="${pageContext.request.contextPath}/upload/imgs/upload.png"  onclick="$('#titleImgUpload').click();">
								<div class="inputCom">
								     <input type="hidden" name="titleImage" id="titleImage"/>
									 <input type="file" name="logoFile" style="display: none;" id="titleImgUpload" onchange="setTitleImg(this)"/>
								</div>	
							</div>
						</div>
					</div>
					<br/>
					
					
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							轮播图<br/><br/>
							<span class="imageShowCon">

							</span>
								<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#imagesUpload').click();">
								<div class="inputCom">
									<input type="file" style="display: none;" id="imagesUpload" name="logoFile" onchange="setGoodsImg(this)">
								</div>
							</div>
						</div>
					</div>
					<br/>
			
				<script type="text/javascript">
					function setDoc(obj){
						var f=$(obj).val();
						alert(f);
						console.log(obj);
						$("#okPNG").html("");
					    if(f == null || f ==undefined || f == ''){
					        return false;
						}
					    if(!/\.(?:doc|Doc|DOC)$/.test(f))
					    {
					        alert("类型必须是(.doc|Doc|DOC)");
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
					        url: "/wx/goods/sys/upload",
					        data: data,
					        cache: false,
					        contentType: false,    //不可缺
					        processData: false,    //不可缺
					        dataType:"json",
					        success: function(ret) {
					        	console.log(ret);
					            if(ret.code==0){
					            	alert("上传成功");
					            	console.log(ret.result.url);
					            	$("#htmlSrc").val(ret.result.url);//将地址存储好 
					            	$("#okPNG").html('<img src="${pageContext.request.contextPath}/icons/ok.png" style="width: 50px;"/>');
					            }else{
					                alertError(ret.message);
					                $("#okPNG").html("");
					                $("#htmlSrc").val("");
					                $(obj).val('');
					            }
					            
					            console.log($("#htmlSrc").val());
					        },
					        error: function(XMLHttpRequest, textStatus, errorThrown) {
					        	console.log(ret);
					            alert("上传失败，请检查网络后重试");
					        }
					    });
					}
				</script>
			
			
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							商品详情
							<div class="htmlPage">

							</div>	   
							<div class="inputCom">
								<img src="${pageContext.request.contextPath}/upload/imgs/upload.png" onclick="$('#docUpload').click();"/>
								<span id="okPNG">
								
								</span>
							    <input type="hidden" id="htmlSrc" name="itemSrc"/>
								<input type="file" name="logoFile" style="display: none;" id="docUpload" onchange="setDoc(this)">
							</div>
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							商品标题:
							<input type="text" class="form-control" id="titleName">
							</div>
						</div>
					</div>
					<br/>
					
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							原价:
							<input type="text" class="form-control" id="oldPrice">
							</div>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							现价（折扣价s）:
							<input type="text" class="form-control" id="price">
							</div>
						</div>
					</div>
					<br/>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							活动参与总人数:<span style="font-size: 10px;color: red;">（0代表无限制）</span>
							<input type="text" class="form-control" id="resNum">
							</div>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							浏览量:
							<input type="text" class="form-control" id="browNum">
							</div>
						</div>
					</div>
					<br/>
					<script>
						$(function () {
							$('#datetimepicker1').datetimepicker({
								  format:'yyyy-mm-dd hh:00',
								  language : 'zh-CN',
								  weekStart : 1,
								  todayBtn : true,
								  autoclose : 1,
								  startView : 'year',
								  maxView:'decade',
								  minView :'day',
								  forceParse : false,
								  pickerPosition: "bottom-left"
							}); 
							$('#datetimepicker2').datetimepicker({
								  format:'yyyy-mm-dd hh:00',
								  language : 'zh-CN',
								  weekStart : 1,
								  todayBtn : true,
								  autoclose : 1,
								  startView : 'year',
								  maxView:'decade',
								  minView :'day',
								  forceParse : false,
								  pickerPosition: "bottom-left"
							}); 
						 
						});
					</script>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							活动开始时间:
							 <div class='input-group date' id='datetimepicker1' >
				               <input type='text' name="preTimeStr" id="preTime" class="form-control" />
				               <span class="input-group-addon">
				                   <span class="glyphicon glyphicon-calendar"></span>
				               </span>
				           </div>
							</div>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							活动结束时间:
							 <div class='input-group date' id='datetimepicker2'>
				                <input type='text' name="sufTimeStr" id="sufTime" class="form-control" />
				                <span class="input-group-addon">
				                    <span class="glyphicon glyphicon-calendar"></span>
				                </span>
				            </div>
							</div>
						</div>
					</div>
					<br/>


					<script type="text/javascript">
						function setGoodsTy(obj,type){
							var text = $(obj).text();
							console.log(text);
							$('.goodsTypeDrop').html(text+"<b class='caret'></b>");
							$('#goodsType').val(type);
						}		
					</script>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								<ul class="nav nav-pills">
									<li class="dropdown all-camera-dropdown">
										<a class="goodsTypeDrop dropdown-toggle" data-toggle="dropdown">
											商品类型
											<b class="caret"></b>
										</a>
										<input type="hidden" class="form-control" id="goodsType">
										<ul class="dropdown-menu">
											<li><a id="goods1" onclick="setGoodsTy(this,1)">旅游</a></li>
											<li><a id="goods2" onclick="setGoodsTy(this,2)">美食</a></li>
											<li><a id="goods3" onclick="setGoodsTy(this,3)">KTV</a></li>
											<li><a id="goods4" onclick="setGoodsTy(this,4)">服装</a></li>
											<li><a id="goods5" onclick="setGoodsTy(this,5)">其他生活服务</a></li>
										</ul>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<br/>

					<script type="text/javascript">
						function setPayTy(obj,type){
							var text = $(obj).text();
							$('.payTypeDrop').html(text+"<b class='caret'></b>");
							$('#payType').val(type);
						}
					</script>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
								<ul class="nav nav-pills">
									<li class="dropdown all-camera-dropdown">
										<a class="payTypeDrop dropdown-toggle" data-toggle="dropdown">
											支付类型
											<b class="caret"></b>
										</a>
										<input type="hidden" class="form-control" id="payType">
										<ul class="dropdown-menu">
											<li><a onclick="setPayTy(this,1)" id="pay1">到店付</a></li>
											<li><a onclick="setPayTy(this,2)" id="pay2">在线付</a></li>
										</ul>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<br/>
					<script type="text/javascript">
						function setRec(obj){
							var value = $(obj).val();
							console.log("preState:"+typeof(value)+value);
							if(value=="true"){
								$(obj).val(false);
							}else{
								$(obj).val(true);
							}
							console.log("state:"+$(obj).val());
						}
					</script>
					
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group">
							&nbsp;&nbsp;&nbsp;&nbsp;推荐&nbsp;<input onclick="javascript:setRec(this)" type="checkbox" id="isRecommend" class="isRecommend" value="false">
							</div>
						</div>
					</div>
					<br/>
					
			</div> 
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="checkGoods()">
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
/*****************地图***************************/
var commonMarker;
var geocoder,map,marker = null,markersArray = [];
function setMap(add){
	
	
		if(add!="" && add!=null && typeof(add)!="undefined"){
			strs=add.split(","); 
			var center = new qq.maps.LatLng(strs[0],strs[1]);
		}
		else{
			var center = new qq.maps.LatLng(29.76416, 104.85212);
		}
			
	    map = new qq.maps.Map(document.getElementById('container'),{
	        center: center,
	        zoom: 15
	    });
	    
	    commonMarker = new qq.maps.Marker({
	        position: center,
	        draggable: true,
	        map: map
	 	});
	    
	    //调用地址解析类
	    geocoder = new qq.maps.Geocoder({
	        complete : function(result){
	        	
	            map.setCenter(result.detail.location);
	            marker = new qq.maps.Marker({
	                position: result.detail.location,
	                draggable: true,
	                map: map
	         	});
	            if(marker!=null){
	        		commonMarker.setMap(null);
	        	}
	            commonMarker = marker;
	        }
	    });
}

function codeAddress() {
	
	
	var address = document.getElementById("address").value;
    //通过getLocation();方法获取位置信息值
    geocoder.getLocation(address);
   
}

</script>
<script>

   $(function () { $('#introModel').modal('hide')});

	var currentId;
	//初始化商家模态框页面
	function initSeller(id){
		console.log(id);
		currentId=id;
		$('#addSellerModel').modal('show');
		//$("#introduce").text("");
		if(currentId!=null){
			$("#sellerModelTitile").text("修改商家");
			//修改初始化
			$.ajax({
				type : 'post',
				async : false,
				url : "/wx/seller/sys/get?id="+id,
		        dataType:"json",
		        contentType:"application/json",
		        async: false,
		        cache:false,
				success : function(msg) {
					console.log(msg);
					if(msg){
						$("#name").val(msg.name);
						$("#onTime").val(msg.onTime);
						$("#phoneNum").val(msg.phoneNum);
						//$("#address").val(msg.address);
						setMap(msg.address);
						$("#introduce").val(msg.introduceText);
						$("#introduceImage").val(msg.introduceImage);
						$("#introduceImageShow").attr("src",path_pre+msg.introduceImage);
						$("#phoneName").val(msg.phoneName);
						$("#addressStr").val(msg.addressStr);
					}
				},
				error : function(msg) {
					console.log(msg);
				}
			});
		}else{
			$("#sellerModelTitile").text("添加商家");
			//添加初始化
			$("#name").val("");
			$("#onTime").val("");
			$("#phoneNum").val("");
			//$("#address").val("");
			setMap("");
			$("#introduce").val("");
			$("#introduceImage").val("");
			$("#introduceImageShow").attr("src","");
			$("#phoneName").val("");
			$("#addressStr").val("");
		} 
	}
	 
	 //输入框验证
	 function checkSeller(){
		var name = $("#name").val();
		var onTime = $("#onTime").val();
		var phoneNum = $("#phoneNum").val();
		var address = commonMarker.position+"";
		$("#address").val(address);
		//console.log($("#address").val());
		var introduceText = $("#introduce").val();
		var introduceImage = $("#introduceImage").val();
		var phoneName = $("#phoneName").val();
		var addressStr = $("#addressStr").val();
		
	  	//验证
		if(typeof(name)=="undefined"||name.trim().length<=0){	
			alert("请填写商家名！");
			return false;
		} 
		if(typeof(onTime)=="undefined"||onTime.trim().length<=0){	
			alert("请填写营业时间");
			return false;
		} 
		var pattern = /^((0\d{2,3}-?\d{7,8})|(1[35784]\d{9}))$/;
		var result =pattern.test(phoneNum);
		if(phoneNum && !result){
			 alert("不支持的手机格式"); 
			 return false;
		} 
		if(typeof(phoneNum)=="undefined"||phoneNum.trim().length<=0){	
			alert("请填写联系电话！");
			return false;
		} 
		/* if(typeof(address)=="undefined"||address.trim().length<=0){	
			alert("请填写");
			return false;
		}  */
		/* if(typeof(introduceText)=="undefined"||introduceText.trim().length<=0){	
			alert("请上传头像");
			return false;
		}  */
		if(typeof(introduceImage)=="undefined"||introduceImage.trim().length<=0){	
			alert("请上传店铺图片！");
			return false;
		} 
		
		if(typeof(phoneName)=="undefined"||phoneName.trim().length<=0){	
			alert("请填写联系人！");
			return false;
		} 
		if(typeof(addressStr)=="undefined"||addressStr.trim().length<=0){	
			alert("请填写详细地址！");
			return false;
		} 
		
		
		
		
		//alert(address);
		 var data ={
			'id':currentId,
			'name':name,
			'onTime':onTime,
			'phoneNum':phoneNum,
			'address':address,
			'introduceText':introduceText,
			'introduceImage':introduceImage,
			'phoneName':phoneName,
			'addressStr':addressStr
		};
		saveSeller(data);
	 }
	
	 
	//添加、修改统一提交
	
	function saveSeller(data){
		console.log(data);
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/seller/sys/save",
			data: JSON.stringify(data),//必要
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				console.log(msg);
				if(msg.code==0){
					alert(msg.message);
					window.location.href="/wx/seller/sys/index";
				}else{
					alert(msg.message);
				}
			},
			error : function(msg) {
				console.log(msg);
				alert("添加失败");
			}
		}); 
		
		$('#addSellerModel').modal('hide');
	}
	
	//删除商家
	function removeSeller(id){
		var message= confirm("确定要删除吗？");
		if(message){
			$.ajax({
				type : 'get',
				async : false,
				url : "/wx/seller/sys/remove?id="+id,
				// 如果参数为json，加上这句
				contentType : "text/json",
				// 规定反参类型为text
				dataType : "json",
				success : function(msg) {
					if(msg.code==0){
						window.location.href='/wx/seller/sys/index';
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
	
	
	/************************商品操作***********************/
	
	
	function setGoodsType(goodsType,genreName){
		$('.goodsTypeDrop').html(genreName+"<b class='caret'></b>");
		$('#goodsType').val(goodsType);
	}
	
	
	function setPayType(payType){
		console.log("payType:"+payType+typeof(payType));
		var typeName;
		if(payType==1){
			typeName="到店付";
		}else if(payType==2){
			typeName="在线付";
		}
		$('.payTypeDrop').html(typeName+"<b class='caret'></b>");
		$("#payType").val(payType);
	}
	
	function setRecommend(isRecommend){
		console.log("isRecommend:"+isRecommend);
		if(isRecommend){
			$("#isRecommend").val(true);
			$("#isRecommend").prop("checked",true);
			//alert("修改初始化true");
		}else{
			$("#isRecommend").val(false);
			$("#isRecommend").prop("checked",false);
			//alert("修改初始化false");
		}
		
	}
	//添加商品
	//初始化商品模态框页面
	var currGoodsId;
	var currParentId;
	var currentIsValid;
	function initGoods(parentId,id){
		//console.log("id:"+id+"\nparentId:"+parentId);
		$('#addGoodsModel').modal('show');
		imageStr.length=0;
		currGoodsId=id;
		currParentId=parentId;
		//$("#introduce").text("");
		$(".imageShowCon").html(""); 
		if(currGoodsId!=null){
			$("#goodsModelTitile").text("修改商品");
			//修改初始化
			$.ajax({
				type : 'post',
				async : false,
				url : "/wx/goods/sys/get?id="+id,
		        dataType:"json",
		        contentType:"application/json",
		        async: false,
		        cache:false,
				success : function(msg) {
					console.log(msg);
					if(msg){
						setPayType(msg.payType);
						setGoodsType(msg.goodsType.id,msg.goodsType.genreName);
						$("#titleName").val(msg.titleName);
						$("#oldPrice").val(msg.oldPrice);
						$("#price").val(msg.price);
						//$("#soldNum").val(msg.soldNum);
						$(".titleImage").html("<img src='"+path_pre+msg.titleImage+"' style='max-width:50px;'/>");
						$("#titleImage").val(msg.titleImage);
						//$("#titleImageShow").attr("src",path_pre+msg.titleImage);
						$("#resNum").val(msg.resNum);
						$("#browNum").val(msg.browNum);
						$("#preTime").val(msg.preTime);
						$("#sufTime").val(msg.sufTime);
						setRecommend(msg.isRecommend);
						//$("#isRecommend").val(msg.isRecommend);
						$("#publish").val(msg.publish);
						$("#htmlSrc").val(msg.itemSrc);
						currentIsValid = msg.isValid;
						$.each(msg.images,function(index,obj){
							var showHtml ='<img src="'+path_pre+obj.image+'" style="max-width:50px;" onclick="removeImg(this,\''+index+'\')"/>&nbsp;';
							imageStr.push({
								'image':obj.image
							});
			               	//显示图片  
			                $(".imageShowCon").append(showHtml); 
						})
						images_index = 0;
					}
				},
				error : function(msg) {
					console.log(msg);
				}
			});
		}else{
			images_index = 0;
			$("#goodsModelTitile").text("添加商品");
			//添加初始化
			$("#payType").val("");
			$("#goodsType").val("");
			$("#titleName").val("");
			$("#oldPrice").val("");
			$("#price").val("");
			//$("#soldNum").val("");
			$("#titleImage").val("");
			$(".titleImage").html("<img src='' style='max-width:50px;'/>");
			$("#resNum").val("");
			$("#browNum").val("");
			$("#preTime").val("");
			$("#sufTime").val("");
			$("#isRecommend").val(false);
			$("#isRecommend").prop('checked',false);
			$("#publish").val("");
			$("#htmlSrc").val("");
			currentIsValid=1;
		} 
	}
	 
	 //输入框验证
	 function checkGoods(){
			var payType = $("#payType").val();
			var goodsType = $("#goodsType").val();
			var titleName = $("#titleName").val();
			var oldPrice = $("#oldPrice").val();
			var price = $("#price").val();
			var titleImage = $("#titleImage").val();
			var resNum = $("#resNum").val();
			var browNum = $("#browNum").val();
			var preTime = $("#preTime").val();
			var sufTime = $("#sufTime").val();
			var isRecommend;
			if($("#isRecommend").val()=="true"){
				isRecommend=true;
			}else{
				isRecommend=false;
			}
			var publish = $("#publish").val();
			var htmlSrc = $("#htmlSrc").val();
			//验证
			//alert(address);
			 var data ={
				'id':currGoodsId,
				'seller':{
					'id':currParentId
				},
				'goodsType':{
					'id':goodsType
				},
				'payType':payType,
				'oldPrice':oldPrice,
				'price':price,
				'titleImage':titleImage,
				'titleName':titleName,
				'resNum':resNum,
				'browNum':browNum,
				'preTime':preTime,
				'sufTime':sufTime,
				'isRecommend':isRecommend,
				'publish':publish,
				'itemSrc':htmlSrc,
				'images':imageStr,
				'isValid':currentIsValid
			};
		saveGoods(data);
	 }
	
	 
	//添加、修改统一提交
	
	function saveGoods(data){
		//重置
		$(".imageShowCon").html("");
		console.log(data);
		$.ajax({
			type : 'post',
			async : false,
			url : "/wx/goods/sys/save",
			data: JSON.stringify(data),//必要
	        dataType:"json",
	        contentType:"application/json",
	        async: false,
	        cache:false,
			success : function(msg) {
				console.log(msg);
				if(msg.code==0){
					alert(msg.message);
					window.location.href="/wx/seller/sys/index";
				}else{
					alert(msg.message);
				}
			},
			error : function(msg) {
				console.log(msg);
				alert("添加失败");
			}
		}); 
		
		$('#addGoodsModel').modal('hide');
	}
	
	//删除商品
	function removeGoods(id){
		var message= confirm("确定要删除吗？");
		if(message){
			$.ajax({
				type : 'get',
				async : false,
				url : "/wx/goods/sys/remove?id="+id,
				// 如果参数为json，加上这句
				contentType : "text/json",
				// 规定反参类型为text
				dataType : "json",
				success : function(msg) {
					if(msg.code==0){
						window.location.href="/wx/seller/sys/index";
						alert(msg.message);
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
<!-- 
    <script>
	    $('#identifier').on('hidden.bs.modal', function () {
		})
    </script> -->
			

		</div>
	</div>
</body>
</html>
