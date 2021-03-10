<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

    Map<String,String> map = (Map<String, String>) application.getAttribute("propertiesMap");
    Set<String> set = map.keySet();
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

    <script>

        var json = {
            <%
                for(String key:set){
                    String value = map.get(key);
            %>
                "<%=key%>" : "<%=value%>",
            <%
                }
            %>
        };

        console.log(json);

        $(function () {

            $(".time1").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });

            $(".time2").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "top-left"
            });

            $("#create-customerName").typeahead({
                source: function (query, process) {
                    $.post(
                        "workbench/transaction/getCustomerName.do",
                        { "name" : query },
                            function (data) {
                                // alert(data);

                                //填充
                            process(data);
                        },
                        "json"
                    );
                },
                delay: 1500
            });



            $("#cancelBtn").click(function () {
                window.location.href = "workbench/transaction/index.jsp";
            })


            //为阶段的下拉框，绑定选中下拉框的事件。根据选中的阶段填写可能性
            $("#create-transactionStage").change(function () {
                //取得选中阶段
                var stage = $("#create-transactionStage").val();

                // alert(stage)

                //目标：填写可能性

                var possibility = json[stage];


                //填充
                $("#create-possibility").val(possibility)

            })

            //为保存按钮绑定事件，执行交易添加操作
            $("#saveBtn").click(function () {

                //发出传统请求，提交表单
                $("#tranForm").submit();


            })

            // 点击市场活动搜索图标，打开模态窗口页面
            $("#findActivityList").click(function () {

                // $.ajax({
                //     url: "workbench/transaction/getActivityList.do",
                //     type: "post",
                //     dataType: "json",
                //     success: function (data) {
                //
                //         var html = "";
                //
                //         $.each(data,function (i,n) {
                //
                //             html += '<tr>';
                //             html += '<td><input type="radio" name="activity" id="'+ n.id +'"/></td>';
                //             html += '<td>'+ n.name +'</td>';
                //             html += '<td>'+ n.startDate +'</td>';
                //             html += '<td>'+ n.endDate +'</td>';
                //             html += '<td>'+ n.owner +'</td>';
                //             html += '</tr>';
                //
                //         });
                //
                //         $("#ActivityBody").html(html);
                //
                //
                //     }
                //
                // })

                $("#ActivityBody").html("");

                $("#findMarketActivity").modal("show");
            })

            //搜索市场活动信息列表，展示对应的市场活动信息，将其展示在列表项内，支持模糊查询
            $("#searchActivityList").keydown(function (event) {

                var name = $.trim($("#searchActivityList").val());

                    if(event.keyCode == 13){
                        if(name == ""){
                            alert("请输入市场活动名称，支持模糊查询");
                            return false;
                        }else {
                            $.ajax({
                                url: "workbench/transaction/searchActivityList.do",
                                data: {
                                    "name": $.trim($("#searchActivityList").val())
                                },
                                type: "post",
                                dataType: "json",
                                success: function (data) {

                                    var html = "";

                                    $.each(data, function (i, n) {

                                        html += '<tr>';
                                        html += '<td><input type="radio" name="xz" value="' + n.id + '"/></td>';
                                        html += '<td>' + n.name + '</td>';
                                        html += '<td>' + n.startDate + '</td>';
                                        html += '<td>' + n.endDate + '</td>';
                                        html += '<td>' + n.owner + '</td>';
                                        html += '</tr>';

                                    });

                                    $("#ActivityBody").html(html);

                                }
                            });

                        return false;
                    }
                }
            })

            // 点击市场活动赋值的保存按钮
            $("#submitActivityBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if($xz.length == 0){
                    alert("请选择想要提交的市场活动");
                    return;
                }else {

                    var id = $xz.val();

                    $.ajax({
                        url: "workbench/transaction/getActivityNameByActivityId.do",
                        data: {
                            "activityId": id
                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            $("#searchActivityList").val("");

                            $("#create-activitySrc").val(data.name);
                            $("#activityId").val(id);

                            $("#findMarketActivity").modal("hide");

                        }
                    })

                }

            })

            $("#findContactsList").click(function () {

                $("#contactsBody").html("");

                $("#findContacts").modal("show");
            })

            $("#searchContactsList").keydown(function (event) {

                var name = $.trim($("#searchContactsList").val());

                if(event.keyCode == 13){
                    if(name == ""){
                        alert("请输入联系人名称，支持模糊查询");
                        return false;
                    }else {
                        $.ajax({
                            url: "workbench/transaction/searchContactsList.do",
                            data: {
                                "name": $.trim($("#searchContactsList").val())
                            },
                            type: "post",
                            dataType: "json",
                            success: function (data) {

                                var html = "";

                                $.each(data, function (i, n) {

                                    html += '<tr>';
                                    html += '<td><input type="radio" name="xz" value="'+ n.id +'"/></td>';
                                    html += '<td>'+ n.fullname +'</td>';
                                    html += '<td>'+ n.email +'</td>';
                                    html += '<td>'+ n.mphone +'</td>';
                                    html += '</tr>';
                                });

                                $("#contactsBody").html(html);

                            }
                        });

                        return false;
                    }
                }
            })

            // 点击联系人赋值的保存按钮
            $("#submitContactsBtn").click(function () {

                var $xz = $("input[name=xz]:checked");

                if($xz.length == 0){
                    alert("请选择想要提交的市场活动");
                    return;
                }else {

                    var id = $xz.val();

                    $.ajax({
                        url: "workbench/transaction/getContactsNameByContactsId.do",
                        data: {
                            "contactsId": id
                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            $("#searchContactsList").val("");

                            $("#create-contactsName").val(data.fullname);
                            $("#contactsId").val(id);

                            $("#findContacts").modal("hide");

                        }
                    })

                }

            })





        })
        //关于阶段和可能性
        //一个阶段对应一个可能性
        /**
         * 对于以上的情况。
         * 1、数据量不大
         * 2、而且是键值对的对应关系
         *      存储在数据表中没意义
         *      建议存储在properties属性配置文件中来保存
         *      stageToPossibility.properties
         * */


    </script>
</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="findMarketActivity" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" id="searchActivityList" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
						<tbody id="ActivityBody">
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

	<!-- 查找联系人 -->	
	<div class="modal fade" id="findContacts" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找联系人</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" id="searchContactsList" class="form-control" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
							</tr>
						</thead>
						<tbody id="contactsBody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>李四</td>
								<td>lisi@bjpowernode.com</td>
								<td>12345678901</td>
							</tr>
							<tr>
								<td><input type="radio" name="activity"/></td>
								<td>李四</td>
								<td>lisi@bjpowernode.com</td>
								<td>12345678901</td>
							</tr>--%>
						</tbody>
					</table>
				</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="submitContactsBtn">提交</button>
                </div>
			</div>
		</div>
	</div>
	
	
	<div style="position:  relative; left: 30px;">
		<h3>创建交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
			<button type="button" class="btn btn-default" id="cancelBtn">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form action="workbench/transaction/save.do" id="tranForm" method="post" class="form-horizontal" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="create-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionOwner" name="owner">
                    <option></option>
				  <c:forEach items="${uList}" var="u">
                      <option value="${u.id}" ${user.id eq u.id ? "selected" : ""}>${u.name}</option>
                  </c:forEach>
				</select>
			</div>
			<label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-amountOfMoney" name="money">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-transactionName" name="name">
			</div>
			<label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time1" id="create-expectedClosingDate" name="expectedDate">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-customerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" name="customerName" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="create-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" id="create-transactionStage" name="stage">
			  	<option></option>
			  	<c:forEach items="${stage}" var="s">
                    <option value="${s.value}">${s.text}</option>
                </c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionType" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionType" name="type">
				  <option></option>
				  <c:forEach items="${transactionType}" var="tr">
                      <option value="${tr.value}">${tr.text}</option>
                  </c:forEach>
				</select>
			</div>
			<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-possibility" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-clueSource" name="source">
				  <option></option>
                    <c:forEach items="${source}" var="so">
                        <option value="${so.value}">${so.text}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="findActivityList"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-activitySrc" value="">

                <input type="hidden" name="activityId" value="" id="activityId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" id="findContactsList"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-contactsName" value="">

                <input type="hidden" name="contactsId" value="" id="contactsId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-description" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-description" name="description"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time2" id="create-nextContactTime" name="contactTime">
			</div>
		</div>
		
	</form>
</body>
</html>