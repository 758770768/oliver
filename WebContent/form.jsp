<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.0.0.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	</head>
	<script>
		var a = {
			"name": "18",
			"age": "20"
		};

		function abc() {
			$.ajax({
				type: "post",
				url: "Servlet01",
				async: true,
				data: $("#form01").serialize(),
				success: function(i) {
					$.each(i, function(a, n) {
						alert(a + ":" + n);
					});
				},
				dataType: "json"
			});
		}
	</script>

	<body>

		<div class="container">
			<button type="button" onclick="abc()">go</button>
			<form id="form01">
				<input type="text" name="ename" /> <input type="password" name="pass" />
				<input type="text" name="eaddr" /> <input type="text" name="eps" />

			</form>
			<button type="button" class="btn btn-default " data-toggle="modal" data-target="#modal">modal</button>

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
							<form class="form-horizontal">
								<div class="form-group">
								 <label class="form-control">姓名:<input type="text" name="ename"/></label>
								</div>
								<div class="form-group">
								 <label class="form-control">性别:<input type="text" name="sex"/></label>
								</div>
								 
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" data-dismiss="modal">close</button>
							<button type="button" data-dismiss="modal">ok</button>
						</div>

					</div>
				</div>

			</div>

		</div>
	</body>

</html>