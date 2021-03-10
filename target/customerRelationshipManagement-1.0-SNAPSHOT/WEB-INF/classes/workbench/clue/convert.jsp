<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    String fullname = new String(request.getParameter("fullname").getBytes("iso8859-1"),"utf-8");
    String id = new String(request.getParameter("id").getBytes("iso8859-1"),"utf-8");
    String appellation = new String(request.getParameter("appellation").getBytes("iso8859-1"),"utf-8");
    String company = new String(request.getParameter("company").getBytes("iso8859-1"),"utf-8");
    String owner = new String(request.getParameter("owner").getBytes("iso8859-1"),"utf-8");
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	$(function(){

        $(".time").datetimepicker({
            minView: "month",
            language:  'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left"
        });


		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		//放大镜图标绑定事件，打开搜索市场活动的模态窗口
        $("#openSearchModalBtn").click(function () {
            //打开模态窗口
            $("#searchActivityModal").modal("show");


        });

        //搜索操作模态窗口  搜索框事件
        $("#activityName").keydown(function (event) {

            if(event.keyCode == 13){

                $.ajax({
                    url: "workbench/clue/getActivityListByName.do",
                    data: {
                        "activityName": $.trim($("#activityName").val())
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        //[{市场活动1},{},{}...]

                        var html = "";

                        $.each(data,function (i,n) {

                            html += '<tr>';
                            html += '<td><input type="radio" name="xz" value="'+ n.id +'"/></td>';
                            html += '<td id="'+ n.id +'">'+ n.name +'</td>';
                            html += '<td>'+ n.startDate+'</td>';
                            html += '<td>'+ n.endDate +'</td>';
                            html += '<td>'+ n.owner+'</td>';
                            html += '</tr>';
                        });


                        $("#activitySearchBody").html(html);
                    }

                });


                return false;
            }


        })


        //为提交市场活动按钮绑定事件，填充市场活动源（id + 名字）
        $("#submitActivityBtn").click(function () {
            //id
            var $xz = $("input[name=xz]:checked");
            var id = $xz.val();

            //名字
            var name = $("#"+id).html();

            // console.log(id)
            // console.log(name)
            //将市场活动名称添加到activityNames中
            $("#activityNames").val(name);
            // 将id添加到隐藏域中
            $("#activityId").val(id);

            //关闭模态窗口
            $("#searchActivityModal").modal("hide");

        })


        //为转换按钮绑定事件。执行线索转换操作
        $("#convertBtn").click(function () {
            //传统请求,结束后回到线索列表
            // alert("asdfasdfdsa")

            if($("#isCreateTransaction").prop("checked")){
                var activityId = $("#activityId").val();
                // alert("需要创建交易");
                //传递给后台交易表单的信息，金额，预计成交日期，交易名称，阶段，市场活动源（id）
                //window.location.href = "workbench/clue/convert.do?clueId=xxx&money=xxx&expectedDate=xxx&name=xxx&stage=xxx&activityId=" + activityId;
                //使用提交表单的形式

                $("#tranForm").submit();

            }else {
                window.location.href = "workbench/clue/convert.do?clueId=${param.id}";
            }
        })

        $("#cencelBtn").click(function () {
            window.location.href = "workbench/clue/index.jsp";
        })

	});
</script>

</head>
<body>

	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" id="activityName" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="activitySearchBody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>
							<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="submitActivityBtn">提交</button>
                </div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small><%=fullname%><%=appellation%>-<%=company%></small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：<%=company%>
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：<%=fullname%><%=appellation%>
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >



		<form id="tranForm" action="workbench/clue/convert.do" method="post">
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney" name="money">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName" name="name">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control time" id="expectedClosingDate" name="expectedData">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control" name="stage">
		    	<option></option>
		    	<c:forEach items="${stage}" var="s">
                    <option value="${s.value}">${s.text}</option>
                </c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activityNames">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="openSearchModalBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityNames" placeholder="点击上面搜索" readonly>
              <input type="hidden" id="activityId" name="activityId">
              <input type="hidden" id="clueId" name="clueId" value="${param.id}">
              <%--标记--%>
              <input type="hidden" name="isFlag" value="isFlag">
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b><%=owner%></b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" id="convertBtn" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消" id="cencelBtn">
	</div>
</body>
</html>