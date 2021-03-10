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

	    //日期控件
        $(".time").datetimepicker({
            minView: "month",
            language:  'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left"
        });

		//为创建市场活动按钮绑定事件，打开添加市场活动的模态窗口
        $("#addBtn").click(function () {
            //操作模态窗口的方式：
            //     需要操作的模态窗口的jqurey对象，调用modal方法。传递参数可以有：
            //             show：打开模态窗口
            //             hide：关闭模态窗口
            //     $("#createActivityModal").modal("show");

            //进入后台，为“所有者”下拉框列表框取得用户数据
            $.ajax({
                url: "workbench/activity/getAllUserTableOfNameInfoList.do",
                type: "post",
                dataType: "json",
                success: function (data) {

                    var html = "<option></option>";

                    //取出接口中的数据，遍历下拉列表框
                    $.each(data,function (i,n) {
                        //n.id：取得的用户id（user.id）
                        //n.name：取得的用户名（user.name）
                        html += "<option value='" + n.id + "'>" + n.name + "</option>";
                    });

                    //将遍历的结果填充至下拉列表框中
                    $("#create-marketActivityOwner").html(html);

                    //从session会话域中取得user对象的id值
                    var id = "${user.id}";

                    //通过id值设置默认选中当前登录的用户名
                    $("#create-marketActivityOwner").val(id);

                    //填充数据完毕，打开模态窗口
                    $("#createActivityModal").modal("show");
                }
            })
        })

        //创建市场活动中的保存按钮
		$("#saveBtn").click(function () {

            $.ajax({
                url: "workbench/activity/saveActivityInfo.do",
                //create-marketActivityOwner,create-marketActivityName,create-startTime,
                //create-endTime,create-cost,create-describe
                data: {
                    //所有者：tbl_user表中的主键id字段
                    "owner": $.trim($("#create-marketActivityOwner").val()),

                    "name": $.trim($("#create-marketActivityName").val()),
                    "startDate": $.trim($("#create-startTime").val()),
                    "endDate": $.trim($("#create-endTime").val()),
                    "cost": $.trim($("#create-cost").val()),
                    "description": $.trim($("#create-describe").val())
                },
                type: "post",
                dataType: "json",
                success:function (data) {
                    //{"success":true/false}
                    if(data.success){
                        //添加成功后，刷新信息列表，
                        // pageList(1,2);

                        // $("#activityPage").bs_pagination('getOption', 'currentPage')
                        //      表示停留在当前页面
                        // $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                        //      表示维持在当前页面的记录数

                        //返回首页，并且保持当前的记录条数
                        pageList(1 ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                        /*
                        * jquery没有reset()方法
                        * 原生js有reset()方法
                        *
                        * jquery对象转换为dom对象：
                        *   jquery[0]
                        * dom对象转换为jquery对象：
                        *   $(dom)
                        */
                        //清空添加后的数据，使用原生js对象的reset方法，重置表单
                        $("#activityAddForm")[0].reset();

                        //关闭模态窗口
                        $("#createActivityModal").modal("hide");
                    }else {
                        alert("添加市场活动失败");
                    }
                }
            })
        })


        //模糊查询按钮
        $("#searchBtn").click(function () {
            //点击查询按钮时，将搜索框中的信息保存在隐藏域中
            $("#hidden-name").val($.trim($("#search-name").val()));
            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-startDate").val($.trim($("#search-startDate").val()));
            $("#hidden-endDate").val($.trim($("#search-endDate").val()));
            // pageList(1,3);
            pageList(1 ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
        })

        //全选按钮事件
        $("#qx").click(function () {
            $("input[name=xz]").prop("checked",this.checked);
        });

        //动态生成的元素
        //语法：$(需要绑定元素的有效外层元素).on(绑定事件的方式，需要绑定的元素的jQuery对象，回调函数)
        $("#activityBody").on("click",$("input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]").length == $("input[name=xz]:checked").length);
        });

        //为删除按钮绑定事件，执行市场活动删除操作
        $("#deleteBtn").click(function () {

            //找到复选框所有选中的复选框
            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择一条或多条您想要删除的市场活动");
                return;
            }else {
                //workbench/activity/delete.do?id=xxx&id=xxx

                //给用户友好的提示
                var confirms = confirm("您确定要删除所有选中的市场活动记录吗？");

                if(confirms == true){

                    //拼接参数
                    var param = "";

                    //将$xz中的每一个dom对象遍历出来，取出value。就相当于取得了id值
                    for(var i = 0;i < $xz.length;i++ ){
                        param += "id="+$($xz[i]).val();

                        //非最后一个元素，每个元素后面追加一个    &   符号
                        if(i < $xz.length - 1){
                            param += "&";
                        }
                    }

                    $.ajax({
                        url: "workbench/activity/deleteActivityListInfo.do",
                        data: param,
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            if(data.success){
                                // pageList(1,2);
                                pageList(1 ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除市场活动失败");
                            }

                        }
                    })
                }

            }
        })

        //修改市场活动信息
        $("#editBtn").click(function () {

            var $xz = $("input[name=xz]:checked");

            if($xz.length == 0){
                alert("请选择您想要修改的市场活动记录");
                return;
            }else if($xz.length > 1){
                alert("您只能选择一条市场活动记录进行修改");
                return;
            }else {
                //获取需要修改的记录条id
                var id = $xz.val();

                $.ajax({
                    url: "workbench/activity/getUserListAndActivity.do",
                    data: {
                        "id": id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        var html = "<option></option>";

                        //处理下拉框
                        $.each(data.uList,function (i,n) {
                            html += "<option value='"+ n.id +"'>"+ n.name +"</option>";
                        });

                        $("#edit-marketActivityOwner").html(html);

                        //处理单条activity
                        $("#edit-id").val(data.a.id);

                        $("#edit-marketActivityOwner").val(data.a.owner);
                        $("#edit-marketActivityName").val(data.a.name);
                        $("#edit-startTime").val(data.a.startDate);
                        $("#edit-endTime").val(data.a.endDate);
                        $("#edit-cost").val(data.a.cost);
                        $("#edit-description").val(data.a.description);

                        //所有的值赋好值之后。打卡修改操作的模态窗口
                        $("#editActivityModal").modal("show");
                    }
                })
            }
        })

        //更新按钮绑定事件，修改操作
        $("#updateBtn").click(function () {
            $.ajax({
                url: "workbench/activity/updateActivityList.do",
                data: {
                    "id": $.trim($("#edit-id").val()),
                    //owner：tbl_user表的主键id字段
                    "owner": $.trim($("#edit-marketActivityOwner").val()),

                    "name": $.trim($("#edit-marketActivityName").val()),
                    "startDate": $.trim($("#edit-startTime").val()),
                    "endDate": $.trim($("#edit-endTime").val()),
                    "cost": $.trim($("#edit-cost").val()),
                    "description": $.trim($("#edit-description").val())
                },
                type: "post",
                dataType: "json",
                success:function (data) {
                    //{"success":true/false}
                    if(data.success){
                        // pageList(1,2);
                        //停留在当前页面，并且保持上一次的记录条数
                        pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                            ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                        $("#editActivityModal").modal("hide");
                    }else {
                        alert("修改市场活动失败");
                    }
                }
            })
        })

        //页面加载完毕，刷新出记录条
        pageList(1,5);

	});

    /*
    * pageNo：页码
    * pageSize：每页展示的记录条数
    *
    * pageList方法：发出ajax请求到后台，从后台取得最新的市场信息
    *
    * 使用场景：
    *   1、点击市场活动，
    *   2、添加，修改，删除
    *   3、查询
    *   4、分页组件
    * */
    function pageList(pageNo,pageSize) {

        //将全选的复选框取消选择
        $("#qx").prop("checked",false);

        //查询前，将隐藏域保存的信息取出，重新赋予到搜索框
        $("#search-name").val($.trim($("#hidden-name").val()));
        $("#search-owner").val($.trim($("#hidden-owner").val()));
        $("#search-startDate").val($.trim($("#hidden-startDate").val()));
        $("#search-endDate").val($.trim($("#hidden-endDate").val()));

        $.ajax({
            url: "workbench/activity/pageList.do",
            data: {
                "pageNo": pageNo,
                "pageSize": pageSize,

                "name": $.trim($("#search-name").val()),
                //owner：tbl_user表中的主键id字段
                "owner": $.trim($("#search-owner").val()),
                "startDate": $.trim($("#search-startTime").val()),
                "endDate": $.trim($("#search-endTime").val())
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                // {"total":记录条数,"dataList":[{市场活动1},{}]}
                var html = "";

                //遍历出dataList中的记录数
                $.each(data.dataList,function (i,n) {
                    html += '<tr class="active">';
                    html += '<td><input type="checkbox" name="xz" value="'+ n.id +'" /></td>';
                    //通过id获得市场活动的列表，将其铺展到前端页面中
                    html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/showActivityDetailInfo.do?id='+ n.id +'\';">'+ n.name +'</a></td>';
                    html += '<td>'+ n.owner +'</td>';
                    html += '<td>'+ n.startDate+'</td>';
                    html += '<td>'+ n.endDate +'</td>';
                    html += '</tr>';
                });

                //将遍历结果填充到id值为activityBody的标签内
                $("#activityBody").html(html);

                //计算总页数
                var totalPages = data.total % pageSize == 0 ? data.total / pageSize : data.total / pageSize + 1;

                //数据处理完毕后，结合分页查询，对前端展现分页信息
                $("#activityPage").bs_pagination({
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

<input type="hidden" id="hidden-name">
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-startDate">
<input type="hidden" id="hidden-endDate">

<input type="hidden" id="edit-id">

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="activityAddForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">
                                    <%--<option></option>--%>
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startTime" autocomplete="off">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endTime" autocomplete="off">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
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
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName">
                            </div>
						</div>
						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startTime" autocomplete="off">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime" autocomplete="off">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
                                <!--
                                    关于文本域texterea：
                                        1、一定要以标签对的形式存在，正常状态下标签对要紧紧的挨着
                                        2、使用val()方法取值/赋值
                                -->
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
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
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="search-startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control time" type="text" id="search-endTime">
				    </div>
				  </div>
				  
				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
                    <!--
                        data-toggle="modal"
                            表示打开一个模态窗口
                        data-target="#createActivityModal"
                            表示表示哪个模态窗口

                        存在问题，无法对按钮的其他功能进行扩充
                    -->
                    <%--data-toggle="modal" data-target="#createActivityModal"--%>
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                    <%--data-toggle="modal" data-target="#editActivityModal"--%>
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
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage">

				</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>