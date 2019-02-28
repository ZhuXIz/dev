
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
<c:import url="../../common/import2.jsp"></c:import>
<style type ="text/css" >
        .off
        {
        	display :none ;
        }
        .yes
        {
        	display:block ;
        }
    </style>

	<script type="text/javascript">
        /*用window.onload调用myfun()*/
        window.onload = myfun;

        function myfun() {

            $("#report").bootstrapTable({
                url: '/wx/employee/sys/get?id=3', //父表加载数据用到的url
                method: 'get',
                detailView: true,//父子表，为true会在父数据前添加 “+”
                //sidePagination: "server",
                pagination: false, //是否翻页
                pageSize: 5,
                pageList: [10, 25],
                columns: [
					{ field: 'project_name', 
					title: '项目名称' }, 
					{ field: 'domnum',
					 title: '接入域' },
					 { field: 'domnum',
					 title: '接入域' }],

					 
                //注册加载子表的事件。注意下这里的三个参数！ row会传递数据到子表
                onExpandRow: function (index, row, $detail) {
                	console.log(row);
                    InitSubTable(index, row, $detail);
                    $detail.html('<table id="child_table"></table>').find('table');
                }
            });
            //初始化子表格(无线循环)
            InitSubTable = function (index, row, $detail) {
                var parentid = row.business_id;
                var cur_table = $detail.html('<table></table>').find('table');
                $(cur_table).bootstrapTable({
                	 url: '/wx/employee/sys/get?id=2', 
                    method: 'get',
                    queryParams: {busid: parentid},
                    ajaxOptions: {strParentID: parentid},
                    clickToSelect: true,
					detailView: true,//父子表
                    uniqueId: "MENU_ID",
                    pageSize: 10,
                    pageList: [10, 25],
                    columns: [{
                        field: 'project_name',
                        title: '项目名称'

                    }, {
                        field: 'domnum',
                        title: '接入域'
                    }],
                    //无线循环取子表，直到子表里面没有记录
                    onExpandRow: function (index, row, $Subdetail) {
                    	
                        InitSubTable(index, row, $Subdetail);
                    }
                });
            };
        };

    </script>
<script type="text/javascript">
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
</script>
</head>


<body id="situation">

	<div class="pages-style">
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
				<button class="btn button_btn bg-deep-blue" type="button" id="add">
					<i class="iconfont"></i>&nbsp;添加
				</button>
			</div>
			

			<!--列表内容-->
			<div class="page_content clearfix mb15 table-module ">
				<table
					class="gallery table table_list table_striped table-bordered "
					id="">
					<thead>
						<tr>
							<th><label><input type="checkbox" class="ace"><span
									class="lbl"></span></label></th>
							<th>活动</th>
							<th>商家名</th>
							<th>商铺图</th>
							<th>联系人</th>
							<th>联系电话</th>
							<th>地址</th>
							<th>状态</th>
						</tr>
					</thead>
					<c:forEach items="${list.rows}" var="obj">
						<tbody>
							<tr>
								<td><input type="hidden" value="${obj.id}"><label><input
										type="checkbox" class="ace"><span class="lbl"></span></label></td>
											<td> <a  onclick="show(this,'${obj.id}')">查看</a>
											</td>
								<td>${obj.name}</td>
								<td><img
									src="${pageContext.request.contextPath}${obj.introduceImage}"
									style="max-width: 200px"></td>
								<td>${obj.phoneName}</td>
								<td>${obj.phoneNum}</td>
								<td>${obj.addressStr}</td>
								<td>
								<c:if test="${obj.isValid}">
								营业中
								</c:if>
								<c:if test="${!obj.isValid}">
									<button class="btn button_btn bg-deep-blue" type="button"  onclick="javascript:pass('${obj.id}')" ><i class="iconfont"></i>&nbsp;通过</button>
								</c:if>
								</td>
								
							</tr>
                            </tbody>
                            <ins></ins>
                            
                            <tbody id="${obj.id}" class="off">
								  	<tr>
								  	 <td>
						                 	<div >
						                 		<div>
							                 		<span>活动</span>
							                 		<span>商家名</span>
							                 		<span>商家名</span>
							                 		<span>商家名</span>
							                 		<span>活动</span>
							                 		<span>商家名</span>
							                 		<span>商家名</span>
							                 		<span>商家名</span>
						                 		</div>
											</div>
						                 </td>
								  	</tr>
				            </tbody>
						</c:forEach>

					
				</table>
			</div>
			
			
			
			
			
		</div>
	</div>
</body>
</html>
<script>
	$(function() {
		$("#pagestyle").Hupage(
				{
					slide : '#breadcrumb',
					scrollbar : function(e) {
						e.niceScroll({
							cursorcolor : "#dddddd",
							cursoropacitymax : 1,
							touchbehavior : false,
							cursorwidth : "3px",
							cursorborder : "0",
							cursorborderradius : "3px",
						});
					},
					expand : function(thisBox, settings) {
						settings.scrollbar($(".box-content").css(
								{
									height : $(window).height()
											- $('.box-title').outerHeight()
											- 30
								}));
					}
				})
	});
	$(document)
			.ready(
					function() {
						var spotMax = 11;

						$("#add").on('click', function() {
							var id = '';
							var cid = '';
							$('.notescontent').each(function(i) {
								var cid = $(this).attr('id', "Notes" + i);
								var id = $(this).attr('data-id', +i);
								;
							});
							addSpot(this, spotMax, cid, id);
						});
						function p(s) {
							return s < 10 ? '0' + s : s;
						}
						;
						var myDate = new Date();
						//获取当前年
						var year = myDate.getFullYear();
						//获取当前月
						var month = myDate.getMonth() + 1;
						//获取当前日
						var date = myDate.getDate();
						var h = myDate.getHours(); //获取当前小时数(0-23)
						var m = myDate.getMinutes(); //获取当前分钟数(0-59)
						var s = myDate.getSeconds();
						var now = year + '-' + p(month) + "-" + p(date) + " "
								+ p(h) + ':' + p(m) + ":" + p(s);
						//添加
						function addSpot(obj, sm, cid, id) {
							noteshtml(cid, id);
						}
						function noteshtml(cid, id) {
							var str = "";
							str = "<div class='notescontent  box-module clearfix notesbox' id='" + cid + "' data-id='" + id + "'>"
									+ "<div class='box-title'>添加便签 <i class='iconfont colseNotes'>&#xe70a</i></div><div class='box-content  padding15'><div class='cell-item'>"
									+ "<label class='cell-left label_name'>便签标题:</label>"
									+ "<div class='cell-right'><input name='tilte' type='text' data-name='标题' value='' class='addtext width100b'></div>"
									+ "</div>"
									+ "<div class='cell-item'>"
									+ "<label class='cell-left label_name'>便签内容:</label>"
									+ "<div class='cell-right'><textarea name='content' type='text' data-name='内容' value='' class='textarea addtextarea addtext width100b'></textarea></div>"
									+ "</div>"
									+ "</div><div class='box Notesbtn commonbtn'>"
									+ "<button type='button' class='box-flex addNotes btnbox  bg-deep-blue' id='saveNotes'>添加便签</button>"
									+ "<button type='button' class='box-flex colseNotes btnbox btn-danger' id='colseNotes'>取消</button>"
									+ "</div></div> <div class='baglayer' id='colselayer'></div>";
							$("body").append(str);
						}
						$(".colseNotes")
								.on(
										'click',
										function() {
											var menu = JSON
													.parse(window.localStorage
															.getItem("menu"));
											if (menu != null) {
												for (var i = 0; i < menu.length; i++) {
													if ($(this).attr(
															'data-name') == menu[i].title) {
														$(this)
																.parents(
																		".notescontent")
																.remove();
														menu.splice(i, 1);
														window.localStorage
																.setItem(
																		"menu",
																		JSON
																				.stringify(menu));
													}
												}
											}

										});
						//修改
						$('#modifyNotes').on(
								'click',
								function() {
									var menu = JSON.parse(window.localStorage
											.getItem("menu"));

								});
					})
</script>