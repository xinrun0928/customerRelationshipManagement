<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
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

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

    <script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
    <script type="text/javascript">

	$(function(){
        //日期控件
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

		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });

        //创建按钮事件
        $("#addBtn").click(function () {

            $.ajax({
                url: "workbench/contacts/getAllUserTableOfNameInfoList.do",
                type: "post",
                dataType: "json",
                success: function (data) {

                    var html = "<option></option>";

                    $.each(data,function (i,n) {
                        html += "<option value='"+ n.id +"'>"+ n.name +"</option>";
                    });

                    //将下拉列表填充到所有者下拉控件上
                    $("#create-contactsOwner").html(html);

                    //获取当前用户的id
                    var id = "${user.id}";

                    //默认选中当前登录用户
                    $("#create-contactsOwner").val(id);

                    //打开模态窗口
                    $("#createContactsModal").modal("show");
                }
            })

        })

        //为创建联系人模态窗口的保存绑定事件，实现添加操作
        $("#saveBtn").click(function () {

            $.ajax({
                url: "workbench/contacts/saveContact.do",
                data: {

                    "owner": $.trim($("#create-contactsOwner").val()),
                    "source": $.trim($("#create-clueSource").val()),
                    "fullname": $.trim($("#create-surname").val()),
                    "appellation": $.trim($("#create-call").val()),
                    "job": $.trim($("#create-job").val()),
                    "mphone": $.trim($("#create-mphone").val()),
                    "email": $.trim($("#create-email").val()),
                    "birth": $.trim($("#create-birth").val()),
                    "customerName": $.trim($("#create-customerName").val()),
                    "description": $.trim($("#create-description").val()),
                    "contactSummary": $.trim($("#create-contactSummary1").val()),
                    "nextContactTime": $.trim($("#create-nextContactTime1").val()),
                    "address": $.trim($("#edit-address1").val())
                },
                type: "post",
                dataType: "json",
                success: function (data) {

                    if(data.success){

                        pageList(1 ,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));

                        //重置表单
                        $("#contactsAddForm")[0].reset();

                        $("#createContactsModal").modal("hide");
                    }else {
                        alert("添加联系人失败");
                    }

                }
            })
        })

        //自动补全功能
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

        //编辑按钮
        $("#editBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择您想要修改的联系人信息");
                return;
            }else if($xz.length > 1){
                alert("您只能选择一条联系人信息进行修改");
                return;
            }else {

                var id = $xz.val();

                $.ajax({
                    url: "workbench/contacts/getUserListAndContacts.do",
                    data: {
                        "id": id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        var html = "";

                        $.each(data.uList,function (i,n) {
                            html += "<option value='"+ n.id +"'>"+ n.name +"</option>";
                        });

                        $("#edit-contactsOwner").html(html);

                        $("#edit-id").val(data.c.id);

                        $("#edit-contactsOwner").val(data.c.owner);
                        $("#edit-clueSource1").val(data.c.source);
                        $("#edit-surname").val(data.c.fullname);
                        $("#edit-call").val(data.c.appellation);
                        $("#edit-job").val(data.c.job);
                        $("#edit-mphone").val(data.c.mphone);
                        $("#edit-email").val(data.c.email);
                        $("#edit-birth").val(data.c.birth);
                        $("#edit-customerName").val(data.c.customerId);
                        $("#edit-description").val(data.c.description);
                        $("#edit-contactSummary").val(data.c.contactSummary);
                        $("#edit-nextContactTime").val(data.c.nextContactTime);
                        $("#edit-address2").val(data.c.address);

                        $("#editContactsModal").modal("show");
                    }
                })

            }
        })

        //编辑之后更新联系人信息
        $("#updateContactsBtn").click(function () {

            $.ajax({
                url: "workbench/customer/updateContactsList.do",
                data: {
                    "id": $.trim($("#edit-id").val()),
                    //owner：tbl_user表的主键id字段
                    "owner": $.trim($("#edit-contactsOwner").val()),

                    "source": $.trim($("#edit-clueSource1").val()),
                    "fullname": $.trim($("#edit-surname").val()),
                    "appellation": $.trim($("#edit-call").val()),
                    "job": $.trim($("#edit-job").val()),
                    "mphone": $.trim($("#edit-mphone").val()),
                    "email": $.trim($("#edit-email").val()),
                    "birth": $.trim($("#edit-birth").val()),
                    "customerName": $.trim($("#edit-customerName").val()),
                    "description": $.trim($("#edit-description").val()),
                    "contactSummary": $.trim($("#edit-contactSummary").val()),
                    "nextContactTime": $.trim($("#edit-nextContactTime").val()),
                    "address": $.trim($("#edit-address2").val())
                },
                type: "post",
                dataType: "json",
                success:function (data) {
                    //{"success":true/false}
                    if(data.success){

                        // pageList(1,2);
                        //停留在当前页面，并且保持上一次的记录条数
                        pageList($("#contactsPage").bs_pagination('getOption', 'currentPage')
                            ,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));

                        $("#editContactsModal").modal("hide");
                    }else {
                        alert("修改市场活动失败");
                    }
                }
            })
        })

        //自动补全功能
        $("#edit-customerName").typeahead({
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

        //删除按钮
        $("#deleteBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择您想要删除的联系人记录")
            }else {

                if(confirm("您确定要删除所有选中的市场活动记录吗？")){

                    var param = "";

                    for(var i = 0; i < $xz.length;i++){
                        param += "id=" + $($xz[i]).val();
                        if(i < $xz.length - 1){
                            param += "&";
                        }
                    }

                    $.ajax({
                        url: "workbench/contacts/deleteContactsListInfo.do",
                        data: param,
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            if(data.success){
                                // pageList(1,2);
                                pageList(1 ,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除联系人列表失败");
                            }

                        }
                    })

                }

            }

        })

        $("#qx").click(function () {
            $("input[name=xz]").prop("checked",this.checked);
        })

        $("#contactsBody").on("click",$("#input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]:checked").length == $("input[name=xz]").length);
        })

		//页面加载时，刷新出当前页面的分页列表信息
		pageList(1,5);
	});

	//分页局部刷新
    function pageList(pageNo,pageSize){

        $.ajax({
            url: "workbench/contacts/getContactsList.do",
            data: {
                "pageNo": pageNo,
                "pageSize": pageSize,

                "owner": $.trim($("#search-owner").val()),
                "fullname": $.trim($("#search-fullname").val()),
                "customerName": $.trim($("#search-customerName").val()),
                "source": $.trim($("#search-clueSource").val()),
                "birth": $.trim($("#search-birth").val())
            },
            type: "post",
            dataType: "json",
            success: function (data) {

                var html = "";

                $.each(data.dataList,function (i,n) {
                    html += '<tr>';
                    html += '<td><input type="checkbox" name="xz" value="'+ n.id +'" /></td>';
                    html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/contacts/showContactsDetailInfo.do?id='+ n.id +'\';">'+ n.fullname +'</a></td>';
                    html += '<td>'+ n.customerId +'</td>';
                    html += '<td>'+ n.owner +'</td>';
                    html += '<td>'+ n.source +'</td>';
                    html += '<td>'+ n.birth +'</td>';
                    html += '</tr>';
                });

                $("#contactsBody").html(html);

                var totalPages = data.total % pageSize == 0 ? data.total / pageSize : data.total / pageSize + 1;

                //数据处理完毕后，结合分页查询，对前端展现分页信息
                $("#contactsPage").bs_pagination({
                    currentPage: pageNo, // 页码
                    rowsPerPage: pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages: totalPages, // 总页数
                    totalRows: data.total, // 总记录条数

                    visiblePageLinks: 5, // 显示几个卡片

                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,

                    onChangePage : function(event, data){
                        pageList(data.currentPage , data.rowsPerPage);
                    }
                });
            }
        })

    }
</script>
</head>
<body>

<input type="hidden" id="edit-id">

	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form id="contactsAddForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-contactsOwner">
								  <%--<option>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>--%>
								</select>
							</div>
							<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueSource">
								  <option></option>
								  <c:forEach items="${source}" var="source">
                                      <option value="${source.value}">${source.value}</option>
                                  </c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname">
							</div>
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-call">
								  <option></option>
								  <c:forEach items="${appellation}" var="appellation">
                                      <option value="${appellation.value}">${appellation.text}</option>
                                  </c:forEach>
								</select>
							</div>
							
						</div>

						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time1" id="create-birth">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time2" id="create-nextContactTime1">
								</div>
							</div>
						</div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address1"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-contactsOwner">
								  <%--<option selected>zhangsan</option>--%>
								  <%--<option>lisi</option>--%>
								  <%--<option>wangwu</option>--%>
								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource1">
								  <option></option>
								  <c:forEach items="${source}" var="source">
                                      <option value="${source.value}">${source.text}</option>
                                  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option></option>
								  <c:forEach items="${appellation}" var="appellation">
                                      <option value="${appellation.value}">${appellation.text}</option>
                                  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time1" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description">

                                </textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time2" id="edit-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address2">

                                    </textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateContactsBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="search-fullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="search-customerName">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="search-clueSource">
						  <option></option>
                          <c:forEach items="${source}" var="source">
                              <option value="${source.value}">${source.value}</option>
                          </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control time1" type="text" id="search-birth">
				    </div>
				  </div>
				  
				  <button type="submit" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>姓名</td>
							<td>客户名称</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="contactsBody">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四</a></td>
							<td>动力节点</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>2000-10-10</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四</a></td>
                            <td>动力节点</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>2000-10-10</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 10px;">
				<div id="contactsPage">

                </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>