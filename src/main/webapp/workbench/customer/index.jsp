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
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){

		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });

		//日期控件
        $(".time").datetimepicker({
            minView: "month",
            language:  'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "top-left"
        });

        //添加客户信息按钮
        $("#addBtn").click(function () {

            $.ajax({
                url: "workbench/customer/getAllUserTableOfNameInfoList.do",
                type: "post",
                dataType: "json",
                success: function (data) {

                    var html = "<option></option>";

                    $.each(data,function (i,n) {
                        html += "<option value='"+ n.id +"'>"+ n.name +"</option>";
                    });

                    $("#create-customerOwner").html(html);

                    var id = "${user.id}";

                    $("#create-customerOwner").val(id);

                    $("#createCustomerModal").modal("show");
                }
            })
        })

        $("#saveCustomerInfoBtn").click(function () {

            $.ajax({
                url: "workbench/customer/saveCustomerInfo.do",
                data: {
                    "owner": $.trim($("#create-customerOwner").val()),

                    "name": $.trim($("#create-customerName").val()),
                    "website": $.trim($("#create-website").val()),
                    "phone": $.trim($("#create-phone").val()),
                    "description": $.trim($("#create-description").val()),
                    "contactSummary": $.trim($("#create-contactSummary").val()),
                    "nextContactTime": $.trim($("#create-nextContactTime").val()),
                    "address": $.trim($("#create-address1").val())
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    if(data.success){

                        pageList(1 ,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

                        $("#customerAddForm")[0].reset();

                        $("#createCustomerModal").modal("hide");

                    }else {
                        alert("添加客户信息失败");
                    }
                }
            })

        })

        //修改客户信息按钮
        $("#editBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择您需要修改的客户信息");
                return;
            }else if($xz.length > 1){
                alert("您只能选择一条客户信息进行修改");
                return;
            }else {

                var id = $xz.val();

                $.ajax({
                    url: "workbench/customer/getUserListAndCustomer.do",
                    data:{
                        "id": id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        var html = "<option></option>";

                        $.each(data.uList,function (i,n) {
                            html += "<option value='"+ n.id +"'>"+ n.name +"</option>";
                        });

                        $("#edit-customerOwner").html(html);

                        $("#edit-id").val(data.c.id);

                        $("#edit-customerOwner").val(data.c.owner);
                        $("#edit-customerName").val(data.c.name);
                        $("#edit-website").val(data.c.website);
                        $("#edit-phone").val(data.c.phone);
                        $("#edit-description").val(data.c.description);
                        $("#edit-contactSummary").val(data.c.contactSummary);
                        $("#edit-nextContactTime").val(data.c.nextContactTime);
                        $("#edit-address").val(data.c.address);

                        $("#editCustomerModal").modal("show");
                    }
                })

            }


        })

        //更新客户信息功能
        $("#updateCustomerInfoBtn").click(function () {

            var id = $("#edit-id").val();

            $.ajax({
                url: "workbench/customer/updateCustomerList.do",
                data: {
                    "id": id,

                    "owner": $("#edit-customerOwner").val(),
                    "name": $("#edit-customerName").val(),
                    "website": $("#edit-website").val(),
                    "phone": $("#edit-phone").val(),
                    "description": $("#edit-description").val(),
                    "contactSummary": $("#edit-contactSummary").val(),
                    "nextContactTime": $("#edit-nextContactTime").val(),
                    "address": $("#edit-address").val()
                },
                type: "post",
                dataType: "json",
                success: function (data) {

                    if(data.success){

                        pageList($("#customerPage").bs_pagination('getOption', 'currentPage')
                            ,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

                        $("#editCustomerModal").modal("hide");
                    }else {
                        alert("修改客户信息失败");
                    }
                }
            })

        })

        //删除客户信息按钮
        $("#deleteBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择一条或多条您想要的客户信息记录")
            }else {

                if(confirm("您确定要删除所有选中的客户信息记录吗？")){

                    var param = "";

                    for(var i = 0; i < $xz.length; i++){
                        param += "id=" + $($xz[i]).val();
                        if(i < $xz.length - 1){
                            param += "&"
                        }
                    }

                    $.ajax({
                        url: "workbench/customer/deleteCustomerListInfo.do",
                        data: param,
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            if(data.success){

                                pageList(1 ,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

                            }else {
                                alert("删除客户信息失败");
                            }
                        }
                    })

                }

            }

        })

        //条件查询按钮
        $("#searchBtn").click(function () {

            $("#name").val($.trim($("#search-name").val()));
            $("#owner").val($.trim($("#search-owner").val()));
            $("#phone").val($.trim($("#search-phone").val()));
            $("#website").val($.trim($("#search-website").val()));

            pageList(1 ,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

        })

        $("#qx").click(function () {
            $("input[name=xz]").prop("checked",this.checked);
        })

        $("#customerBody").on("click",$("input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]:checked").length == $("input[name=xz]").length)
        })

        //分页查询加搜索
		pageList(1,5)
	});

	//分页
	function pageList(pageNo,pageSize){

	    $("#qx").prop("checked",false);

        $("#search-name").val($.trim($("#name").val()));
        $("#search-owner").val($.trim($("#owner").val()));
        $("#search-phone").val($.trim($("#phone").val()));
        $("#search-website").val($.trim($("#website").val()));

	    $.ajax({
            url: "workbench/customer/getCustomerList.do",
            data: {
                "pageNo": pageNo,
                "pageSize": pageSize,

                "name": $.trim($("#search-name").val()),
                "owner": $.trim($("#search-owner").val()),
                "phone": $.trim($("#search-phone").val()),
                "website": $.trim($("#search-website").val())
            },
            type: "post",
            dataType: "json",
            success: function (data) {

                //{"total":总数,"dataList":[{客户1},{客户2}...]}

                var html = "";

                $.each(data.dataList,function (i,n) {
                    html += '<tr>';
                    html += '<td><input type="checkbox" name="xz" value="'+ n.id +'" /></td>';
                    html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/customer/showCustomerDetailInfo.do?id='+ n.id +'\';">'+ n.name+'</a></td>';
                    html += '<td>'+ n.owner +'</td>';
                    html += '<td>'+ n.phone +'</td>';
                    html += '<td>'+ n.website +'</td>';
                    html += '</tr>';
                });

                $("#customerBody").html(html);

                //计算总页数
                var totalPages = data.total % pageSize == 0 ? data.total / pageSize : data.total / pageSize + 1;

                //数据处理完毕后，结合分页查询，对前端展现分页信息
                $("#customerPage").bs_pagination({
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
<input type="hidden" id="name">
<input type="hidden" id="owner">
<input type="hidden" id="phone">
<input type="hidden" id="website">

<input type="hidden" id="edit-id">

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="customerAddForm">
					
						<div class="form-group">
							<label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-customerOwner">
								  <%--<option>zhangsan</option>--%>
								  <%--<option>lisi</option>--%>
								  <%--<option>wangwu</option>--%>
								</select>
							</div>
							<label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-website">
                            </div>
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>

						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" id="create-nextContactTime">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address1"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveCustomerInfoBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-customerOwner">
								  <%--<option>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>--%>
								</select>
							</div>
							<label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-website">
                            </div>
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
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
                                    <input type="text" class="form-control time" id="edit-nextContactTime">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address">

                                    </textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateCustomerInfoBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="search-phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司网站</div>
				      <input class="form-control" type="text" id="search-website">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx" /></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="customerBody">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点</a></td>
							<td>zhangsan</td>
							<td>010-84846003</td>
							<td>http://www.bjpowernode.com</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点</a></td>
                            <td>zhangsan</td>
                            <td>010-84846003</td>
                            <td>http://www.bjpowernode.com</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="customerPage">

                </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>