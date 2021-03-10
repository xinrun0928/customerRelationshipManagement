<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        $(function () {


            $("#editPasswordWindow").click(function () {

                $("#oldPwd").val("");
                $("#newPwd").val("");
                $("#confirmPwd").val("");

                $("#editPwdModal").modal("show");

                $("#oldPwd").focus();

            })

            //修改密码按钮
            $("#updatePasswordBtn").click(function () {
                var oldPwd = $.trim($("#oldPwd").val());
                var newPwd = $.trim($("#newPwd").val());
                var confirmPwd = $.trim($("#confirmPwd").val());

                //1、判断数据是否填写完整
                if(oldPwd == "" || newPwd == "" || confirmPwd == ""){
                    alert("请填写完整");
                    return;
                }

                //2、判断新密码和确认密码是否一致，如果以上条件都不满足，则无法修改
                if(newPwd != confirmPwd){
                    alert("你两次输入的新密码不一致，请重新输入");
                    return;
                }

                //判断新密码和原密码是否一致，如果一致，不允许更改
                if(newPwd == oldPwd){
                    alert("新密码和原密码相同，无法进行修改，请重新输入！");
                    return;
                }

                $.ajax({
                    url: "settings/updatePassword.do",
                    data: {
                        id: "${user.id}",
                        oldPwd: oldPwd,
                        newPwd: newPwd,
                        confirmPwd: confirmPwd
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if(data.success){
                            alert("修改密码成功，请重新登录");
                            window.location.href = "workbench/login.jsp";
                        }else {
                            alert(data.msg);
                        }

                    }

                })

            })


            $("#exitSystem").click(function () {


                $("#exitModal").modal("show");
            })

            //退出系统按钮
            $("#exitConfirmBtn").click(function () {

                $.ajax({
                    url: "settings/exitSystem.do",
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        if(data.success){
                            window.location.href = "workbench/login.jsp";
                            // alert("退出系统成功");
                        }else {
                            alert("退出系统失败");
                        }
                    }
                })

            })

        })

    </script>
</head>
<body>

	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓名：<b>${user.name}</b><br><br>
						登录帐号：<b>${user.loginAct}</b><br><br>
						组织机构：<b>${user.deptno}</b><br><br>
						邮箱：<b>${user.email}</b><br><br>
						失效时间：<b>${user.expireTime}</b><br><br>
						允许访问IP：<b>${user.allowIps}</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="updatePasswordBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="exitConfirmBtn">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> ${user.name} <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="workbench/index.jsp"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="index.jsp"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a id="editPasswordWindow"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a id="exitSystem"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
		<div style="position: relative; top: 30px; width: 60%; height: 100px; left: 20%;">
			<div class="page-header">
			  <h3>系统设置</h3>
			</div>
		</div>
		<div style="position: relative; width: 55%; height: 70%; left: 22%;">
			<div style="position: relative; width: 33%; height: 50%;">
				常规
				<br><br>
				<a href="javascript:void(0);">个人设置</a>
			</div>
			<div style="position: relative; width: 33%; height: 50%;">
				安全控制
				<br><br>
				<!-- 
				<a href="org/index.jsp" style="text-decoration: none; color: red;">组织机构</a>
				 -->
				<a href="dept/index.html">部门管理</a>
				<br>
				<a href="qx/index.html">权限管理</a>
			</div>
			
			<div style="position: relative; width: 33%; height: 50%; left: 33%; top: -100%">
				定制
				<br><br>
				<a href="javascript:void(0);">模块</a>
				<br>
				<a href="javascript:void(0);">模板</a>
				<br>
				<a href="javascript:void(0);">定制内容复制</a>
			</div>
			<div style="position: relative; width: 33%; height: 50%; left: 33%; top: -100%">
				自动化
				<br><br>
				<a href="javascript:void(0);">工作流自动化</a>
				<br>
				<a href="javascript:void(0);">计划</a>
				<br>
				<a href="javascript:void(0);">Web表单</a>
				<br>
				<a href="javascript:void(0);">分配规则</a>
				<br>
				<a href="javascript:void(0);">服务支持升级规则</a>
			</div>
			
			<div style="position: relative; width: 34%; height: 50%;  left: 66%; top: -200%">
				扩展及API
				<br><br>
				<a href="javascript:void(0);">API</a>
				<br>
				<a href="javascript:void(0);">其它的</a>
			</div>
			<div style="position: relative; width: 34%; height: 50%; left: 66%; top: -200%">
				数据管理
				<br><br>
				<a href="dictionary/index.html">数据字典表</a>
				<br>
				<a href="javascript:void(0);">导入</a>
				<br>
				<a href="javascript:void(0);">导出</a>
				<br>
				<a href="javascript:void(0);">存储</a>
				<br>
				<a href="javascript:void(0);">回收站</a>
				<br>
				<a href="javascript:void(0);">审计日志</a>
			</div>
		</div>
	</div>
</body>
</html>