<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        //模糊查询按钮
        $("#searchBtn").click(function () {
            //点击查询按钮时，将搜索框中的信息保存在隐藏域中

            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-name").val($.trim($("#search-name").val()));
            $("#hidden-customerName").val($.trim($("#search-customerName").val()));
            $("#hidden-stage").val($.trim($("#search-stage").val()));
            $("#hidden-type").val($.trim($("#search-type").val()));
            $("#hidden-clueSource").val($.trim($("#create-clueSource").val()));
            $("#hidden-contactsName").val($.trim($("#contactsName").val()));

            pageList(1 ,$("#transactionPage").bs_pagination('getOption', 'rowsPerPage'));
        });

        //全选按钮事件
        $("#qx").click(function () {
            $("input[name=xz]").prop("checked",this.checked);
        });

        $("#transactionBody").on("click",$("input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]").length == $("input[name=xz]:checked").length);
        });

        //修改市场活动信息
        // $("#editBtn").click(function () {
        //
        //     var $xz = $("input[name=xz]:checked");
        //
        //     if($xz.length == 0){
        //         alert("请选择您想要修改的市场活动记录");
        //         return;
        //     }else if($xz.length > 1){
        //         alert("您只能选择一条市场活动记录进行修改");
        //         return;
        //     }else {
        //         //获取需要修改的记录条id
        //         var id = $xz.val();
        //
        //         $.ajax({
        //             url: "workbench/transaction/getUserListAndActivity.do",
        //             data: {
        //                 "id": id
        //             },
        //             type: "post",
        //             dataType: "json",
        //             success: function (data) {
        //
        //             }
        //         })
        //     }
        // })

        $("#editBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择您想要修改的交易记录");
                return;
            }else if($xz.length > 1){
                alert("您只能选择一条交易记录进行修改");
                return;
            }else {
                //获取需要修改的记录条id
                var id = $xz.val();
                window.location.href = "workbench/transaction/edit.do?id=" + id;
            }
        });

        //为删除按钮绑定事件，执行市场活动删除操作
        $("#deleteBtn").click(function () {

            //找到复选框所有选中的复选框
            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择一条或多条您想要删除的交易记录");
                return;
            }else {

                //给用户友好的提示
                var confirms = confirm("您确定要删除所有选中的交易记录吗？");

                if(confirms == true){

                    var param = "";

                    for(var i = 0;i < $xz.length;i++ ){
                        param += "id=" + $($xz[i]).val();

                        if(i < $xz.length - 1){
                            param += "&";
                        }
                    }

                    $.ajax({
                        url: "workbench/transaction/deleteTransactionListInfo.do",
                        data: param,
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            if(data.success){
                                // pageList(1,2);
                                pageList(1 ,$("#transactionPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除市场活动失败");
                            }

                        }
                    })
                }

            }
        })

	    pageList(1,5);
	});

	//分页
	function pageList(pageNo,pageSize){

        //将全选的复选框取消选择
        $("#qx").prop("checked",false);

        //查询前，将隐藏域保存的信息取出，重新赋予到搜索框
        $("#search-owner").val($.trim($("#hidden-owner").val()));
        $("#search-name").val($.trim($("#hidden-name").val()));
        $("#search-customerName").val($.trim($("#hidden-customerName").val()));
        $("#search-stage").val($.trim($("#hidden-stage").val()));
        $("#search-type").val($.trim($("#hidden-type").val()));
        $("#search-clueSource").val($.trim($("#hidden-clueSource").val()));
        $("#search-contactsName").val($.trim($("#hidden-contactsName").val()));

	    $.ajax({
            url: "workbench/transaction/getTransactionList.do",
            data: {
                "pageNo": pageNo,
                "pageSize": pageSize,

                "owner": $.trim($("#search-owner").val()),
                "name": $.trim($("#search-name").val()),
                "customerName": $.trim($("#search-customerName").val()),
                "stage": $.trim($("#search-stage").val()),
                "type": $.trim($("#search-type").val()),
                "source": $.trim($("#search-clueSource").val()),
                "contactsName": $.trim($("#search-contactsName").val())

            },
            type: "post",
            dataType: "json",
            success: function (data) {

                var html = "";

                $.each(data.dataList,function (i,n) {
                    html += '<tr>';
                    html += '<td><input type="checkbox" name="xz" value="'+ n.id +'" /></td>';
                    html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/transaction/detail.do?id='+ n.id +'\';">'+ n.name +'</a></td>';
                    html += '<td>'+ n.customerId +'</td>';
                    html += '<td>'+ n.stage +'</td>';
                    html += '<td>'+ n.type +'</td>';
                    html += '<td>'+ n.owner +'</td>';
                    html += '<td>'+ n.source +'</td>';
                    html += '<td>'+ n.contactsId+'</td>';
                    html += '</tr>';
                });

                //填充
                $("#transactionBody").html(html);

                //计算总页数
                var totalPages = data.total % pageSize == 0 ? data.total / pageSize :data.total / pageSize + 1;

                $("#transactionPage").bs_pagination({
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
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-name">
<input type="hidden" id="hidden-customerName">
<input type="hidden" id="hidden-stage">
<input type="hidden" id="hidden-type">
<input type="hidden" id="hidden-clueSource">
<input type="hidden" id="hidden-contactsName">

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
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
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
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
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="search-stage">
					  	<option></option>
					  	<c:forEach items="${stage}" var="s">
                            <option value="${s.value}">${s.text}</option>
                        </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="search-type">
					  	<option></option>
					  	<c:forEach items="${transactionType}" var="t">
                            <option value="${t.value}">${t.text}</option>
                        </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="create-clueSource">
						  <option></option>
						  <c:forEach items="${source}" var="s">
                              <option value="${s.value}">${s.text}</option>
                          </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" type="text" id="contactsName">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='workbench/transaction/add.do';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
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
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="transactionBody">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/transaction/detail.do?id=63b13fd87f36407b98dbc115a63fbad3';">xiaoxiao zhang</a></td>
							<td>动力节点</td>
							<td>谈判/复审</td>
							<td>新业务</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>李四</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点-交易01</a></td>
                            <td>动力节点</td>
                            <td>谈判/复审</td>
                            <td>新业务</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>李四</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 20px;">
				<div id="transactionPage">

                </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>