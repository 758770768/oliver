<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap-table.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.0.0.js"></script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>

</head>
<body>
	<div id="toolbar" class="btn-group">
		<button id="btn_add" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
		</button>
		<button id="btn_edit" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
		</button>
		<button id="btn_delete" type="button" class="btn btn-default">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
		</button>
		<script type="text/javascript">
			$(function() {
				$("input").addClass("text-center");

				$("#tab01").on("dbl-click-row.bs.table", function(e, a) {
					console.log(a);
					$(".modal").modal("show");
					$("input[type='text']").eq(-5).val(a.eid);
					$("input[type='text']").eq(-4).val(a.ename);
					$("input[type='text']").eq(-3).val(a.sex);
					$("input[type='text']").eq(-2).val(a.city);
					$("input[type='text']").last().val(a.bdate);

				});
			});
		</script>
	</div>

	<table id="tab01"></table>
	hello
</body>

<script>
	$(function() {
		$("#tab01").bootstrapTable({
			url : 'Servlet01', //请求后台的URL（*）
			method : 'get', //请求方式（*）
			toolbar : '#toolbar', //工具按钮用哪个容器
			striped : true, //是否显示行间隔色
			cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : true, //是否显示分页（*）
			sortable : false, //是否启用排序
			sortOrder : "asc", //排序方式
			sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
			idField : "eid", //标识哪个字段为id主键 
			pageNumber : 1, //初始化加载第一页，默认第一页
			pageSize : 10, //每页的记录行数（*）
			pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
			search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			strictSearch : true,
			showColumns : true, //是否显示所有的列
			showRefresh : true, //是否显示刷新按钮
			minimumCountColumns : 2, //最少允许的列数
			clickToSelect : true, //是否启用点击选中行
			height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "eid", //每一行的唯一标识，一般为主键列
			showToggle : true, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			//silent : true, //刷新事件必须设置  
			formatLoadingMessage : function() {
				return "请稍等，正在加载中...";
			},
			columns : [ {
				checkbox : true
			}, {
				field : 'eid',
				title : '编号'
			}, {
				field : 'ename',
				title : '姓名'
			}, {
				field : 'bdate',
				title : '日期'
			}, {
				field : 'city',
				title : '城市'
			}, {
				field : "sex",
				title : "性别"
			}, {
				field : "operate",
				title : "操作",
				events : operateEvents,
				formatter : oformatter
			} ]
		});
	});

	window.operateEvents = {
		'click .a' : function(e, value, row, index) {
			//alert(123);
			$.ajax({
				url : "${pageContext.request.contextPath}/Servlet02",
				data : {
					"eid" : row.eid
				},
				success : function() {
					$("#tab01").bootstrapTable('refresh', {
						url : "Servlet01",
						silent : true
					});
				}

			});

		},
		'click .b' : function(e, value, row, index) {

			$(".modal").modal("show");
			$("input[type='text']").eq(-5).val(row.eid);
			$("input[type='text']").eq(-4).val(row.ename);
			$("input[type='text']").eq(-3).val(row.sex);
			$("input[type='text']").eq(-2).val(row.city);
			$("input[type='text']").last().val(row.bdate);

		}
	};

	function oformatter(value, row, index) {

		return [
				'<button id="btn1" type="button" class="a btn-default btn-danger">删除</button>',
				'<button id="btn2" type="button" class="b btn-default btn-danger">详情</button>' ]
				.join('');
	}
</script>

<div class="modal fade" id="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span>
				</button>
				<div class="modal-title">title</div>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" text-align="center">
					<input type="text" name="eid" readonly="true" class="form-control" />

					<label class="col-sm-2">姓名:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="ename" />
					</div>

					<label for="sex" class="col-sm-2">性别:</label>
					<div class="col-sm-10">
						<input type="text" id="sex" class="form-control" name="sex" />
					</div>

					<label class="col-sm-2">城市:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="city" />
					</div>

					<label class="col-sm-2">开始日期:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="bdate" />
					</div>
				</form>
			</div>
			<div class="modal-footer ">
				<button type="button" class="btn btn-info" data-dismiss="modal">close</button>
				<button type="button" data-dismiss="modal" class="btn btn-success">ok</button>
			</div>
			<script type="text/javascript">
				$(function() {

					$("#tab01").on("load-success.bs.table", function(e) {
						$(this).addClass("bg-info");
					});

					$(".btn-success").on("click", function() {
						//alert(123);
						$.ajax({
							url : "Servlet03",
							data : $(".form-horizontal").serialize(),
							//	dataType : "json",
							success : function() {
								$("#tab01 tr:even").addClass("bg-info");
								//								alert(123);
								$("#tab01").bootstrapTable('refresh', {
									url : "Servlet01",
									silent : true
								});
							},
							type : "post",

						})
					});
				});
			</script>
		</div>
	</div>

</div>

</html>
