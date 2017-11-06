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
<style type="text/css">
/* 警告框样式 */
div[class*="alert"] {
	position: absolute;
	top: 50%;
	left: 50%;
	display: none;
	z-index: 1001;
}
/* 遮罩样式 */
.mask {
	display: none;
	position: absolute;
	top: 0px;
	left: 0px;
	z-index: 1000;
	opacity: 0.5;
	background-color: gray;
}
</style>
</head>
<body>
	<div class="mask"></div>
	<div class="jumbotron">
		<h1 class="page-header text-center text-info">员工信息管理平台</h1>
	</div>
	<!-- 工具栏条 -->
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
				/* 给所有输入框添加样式 */
				$("input").addClass("text-center");
/*  绑定表格行双击是触发函数 */
				$("#tab01").on("dbl-click-row.bs.table", function(e, a) {
					console.log(a);
					/* 模态框显示 */
					$(".modal").modal("show");
					/* 表单赋值 */
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
	<!--警告框  -->
	<div class="alert alert-success ">
		<!-- 删除提示信息 -->
		<h3 class="page-header">确认要删除吗?</h3>
		<!-- 确认删除 -->
		<button type="button" class="btn btn-success">确定删除</button>
		<!-- 取消删除 -->
		<button type="button" class="btn btn-info">取消</button>

	</div>
</body>

<script>
/*页面加载完毕执行  */
	$(function() {
		/* bootstrap-table初始化 */
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
			showFooter:true,
			queryParams : function(params) {
				return {
					limit : params.limit,/*  请求参数*/
					offset : params.offset,
					search : params.search,
					ename : "abc"
				}
			}, //自定义参数
			minimumCountColumns : 2, //最少允许的列数
			clickToSelect : true, //是否启用点击选中行
			height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "eid", //每一行的唯一标识，一般为主键列
			showToggle : true, //是否显示详细视图和列表视图的切换按钮
			cardView : false, //是否显示详细视图
			detailView : false, //是否显示父子表
			//silent : true, //刷新事件必须设置  
			/* formatLoadingMessage : function() {
				return "请稍等，正在加载中...";
			}, */
			columns : [ { /* 列 */
				checkbox : true//是否显示复选框
			}, {
				field : 'eid',//域名
				title : '编号'//标题即页面显示
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
				title : "性别",
				formatter : function(value, row, index) {// 依据列值返回不同的格式化数据
					if ("F" == value) {// f则显示为男
						return "男";
					} else {
						return "女";//m则显示为女
					}

				}
			}, {
				field : "operate",// 添加操作列
				title : "操作",
				events : operateEvents,// 添加操作事件
				formatter : oformatter//格式化操作数据
			} ]
		});
	});

	window.operateEvents = {// 操作事件
		'click .a' : function(e, value, row, index) {// 绑定格式 点击时触发函数 
			/* 遮罩层赋予样式 */
			$(".mask").css({
				height:$(document).height(),
			    width:$(document).width()
			});
		/* 遮罩显示 */
			$(".mask").show();
			$("div[class*='alert']").show();/* 显示警告框 */
			$("h3 ~ button").off();/* 移除所有事件 */
			$("h3 ~ button").on("click", function() {/* 重新绑定事件 */
				$("div[class*='alert']").hide();/* 警告框隐藏 */
				/* 遮罩隐藏 */
				$(".mask").hide();
			});
			$("button:contains('确定删除')").on("click", function() {/* 给确认删除按钮绑定第二个事件点击发送删除请求 */
				$.ajax({
					url : "${pageContext.request.contextPath}/Servlet02",
					data : {
						"eid" : row.eid
					},
					success : function() {
						$("#tab01").bootstrapTable('refresh', {/* 请求成功后刷新当前页面 */
							silent : true/* 配置是否刷新当前页面 */
						});
					}

				});
			});

			/* 			if(confirm("确定删除吗")){
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
			 }
			 return; */

		},
		'click .b' : function(e, value, row, index) {/* 给类名为.b的元素绑定点击事件 */

			$(".modal").modal("show");/* 显示模态框 */
			/* 赋值数据 */
			$("input[type='text']").eq(-5).val(row.eid);
			$("input[type='text']").eq(-4).val(row.ename);
			$("input[type='text']").eq(-3).val(row.sex);
			$("input[type='text']").eq(-2).val(row.city);
			$("input[type='text']").last().val(row.bdate);

		}
	};

	function oformatter(value, row, index) {/* 格式化操作数据函数 */
      /* 显示数格式 */
		return [
				'<button id="btn1" type="button" class="a btn   btn-danger">删除</button>',
				'<button id="btn2" type="button" class="b btn   btn-success">详情</button>' ]
				.join('');
	}
</script>
<!-- 模态框显示数据 -->
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
				<!--  关闭按钮-->
				<button type="button" class="btn btn-info" data-dismiss="modal">close</button>
				<button type="button" data-dismiss="modal" class="btn btn-success">ok</button>
			</div>
			<script type="text/javascript">
				$(function() {
                /* 表格加载完成触发时间函数 */
					$("#tab01").on("load-success.bs.table", function(e) {
						$(this).addClass("bg-info");
					});
/* 绑定事件 */
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
