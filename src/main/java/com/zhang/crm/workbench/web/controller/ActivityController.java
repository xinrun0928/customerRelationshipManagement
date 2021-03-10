package com.zhang.crm.workbench.web.controller;

import com.zhang.crm.settings.domain.User;
import com.zhang.crm.settings.service.UserService;
import com.zhang.crm.settings.service.impl.UserServiceImpl;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.PrintJson;
import com.zhang.crm.utils.ServiceFactory;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Activity;
import com.zhang.crm.workbench.domain.ActivityRemark;
import com.zhang.crm.workbench.service.ActivityService;
import com.zhang.crm.workbench.service.impl.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("======================================进入到市场活动控制器======================================");

        //获取当前的请求路径
        String path = request.getServletPath();

        if("/workbench/activity/getAllUserTableOfNameInfoList.do".equals(path)){
            getAllUserTableOfNameInfoList(request,response);
        }else if("/workbench/activity/saveActivityInfo.do".equals(path)){
            saveActivityInfo(request,response);
        }else if("/workbench/activity/pageList.do".equals(path)){
            pageList(request,response);
        }else if ("/workbench/activity/deleteActivityListInfo.do".equals(path)){
            deleteActivityListInfo(request,response);
        }else if("/workbench/activity/getUserListAndActivity.do".equals(path)){
            getUserListAndActivity(request,response);
        }else if("/workbench/activity/updateActivityList.do".equals(path)){
            updateActivityList(request,response);
        }else if("/workbench/activity/showActivityDetailInfo.do".equals(path)){
            showActivityDetailInfo(request,response);
        }else if("/workbench/activity/getRemarkListByActivityId.do".equals(path)){
            getRemarkListByActivityId(request,response);
        }else if("/workbench/activity/deleteRemarkInfo.do".equals(path)){
            deleteRemarkInfo(request,response);
        }else if("/workbench/activity/saveRemarkInfo.do".equals(path)){
            saveRemarkInfo(request,response);
        }else if("/workbench/activity/updateRemarkInfo.do".equals(path)){
            updateRemarkInfo(request,response);
        }else if("/workbench/activity/updateDetailPageActivityList.do".equals(path)){
            updateDetailPageActivityList(request,response);
        }else if("/workbench/activity/deleteActivityAndActivityRemarkList.do".equals(path)){
            deleteActivityAndActivityRemarkList(request,response);
        }

    }



    /**
     * 删除市场活动以及该条市场活动对应的该条市场活动备注信息列表
     * @param request
     * @param response
     */
    private void deleteActivityAndActivityRemarkList(HttpServletRequest request, HttpServletResponse response) {

        String activityId = request.getParameter("activityId");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.deleteActivityAndActivityRemarkList(activityId);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 编辑按钮功能
     * @param request
     * @param response
     */
    private void updateDetailPageActivityList(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String owner = request.getParameter("owner");

        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");

        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)(request.getSession().getAttribute("user"))).getName();

        Activity activity = new Activity();
        activity.setId(id);
        activity.setOwner(owner);
        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);
        activity.setEditBy(editBy);
        activity.setEditTime(editTime);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Map<String,Object> map = activityService.updateDetailPageActivityList(activity);

        PrintJson.printJsonObj(response, map);
    }

    /**
     * 更新市场活动备注信息
     * @param request
     * @param response
     */
    private void updateRemarkInfo(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        String noteContent = request.getParameter("noteContent");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "1";

        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setId(id);
        activityRemark.setNoteContent(noteContent);
        activityRemark.setEditTime(editTime);
        activityRemark.setEditBy(editBy);
        activityRemark.setEditFlag(editFlag);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = activityService.updateRemark(activityRemark);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("ar",activityRemark);

        PrintJson.printJsonObj(response,map);

    }

    /**
     * 执行市场活动添加备注操作
     * @param request
     * @param response
     */
    private void saveRemarkInfo(HttpServletRequest request, HttpServletResponse response) {

        String noteContent = request.getParameter("noteContent");
        String activityId = request.getParameter("activityId");
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "0";

        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setNoteContent(noteContent);
        activityRemark.setActivityId(activityId);
        activityRemark.setId(id);
        activityRemark.setCreateTime(createTime);
        activityRemark.setCreateBy(createBy);
        activityRemark.setEditFlag(editFlag);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = activityService.saveRemark(activityRemark);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("ar",activityRemark);

        PrintJson.printJsonObj(response,map);
    }

    /**
     * 删除市场活动备注信息
     * @param request
     * @param response
     */
    private void deleteRemarkInfo(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.deleteRemark(id);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 根据市场活动id取得备注信息列表
     * @param request
     * @param response
     */
    private void getRemarkListByActivityId(HttpServletRequest request, HttpServletResponse response) {

        String activityId = request.getParameter("activityId");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<ActivityRemark> activityRemarks = activityService.getRemarkListByAid(activityId);

        PrintJson.printJsonObj(response,activityRemarks);
    }

    /**
     * 转发到详细信息页的操作
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void showActivityDetailInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Activity activity = activityService.detail(id);

        request.setAttribute("a",activity);

        request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request,response);
    }

    /**
     * 执行市场活动修改
     * @param request
     * @param response
     */
    private void updateActivityList(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String owner = request.getParameter("owner");

        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");

        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        Activity activity = new Activity();

        activity.setId(id);
        activity.setOwner(owner);

        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);

        activity.setEditTime(editTime);
        activity.setEditBy(editBy);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.update(activity);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 查询用户信息列表，根据市场活动id查询单条记录
     * @param request
     * @param response
     */
    private void getUserListAndActivity(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        //前端需要返回uList和a
        Map<String,Object> map = activityService.getUserListAndActivity(id);

        //返回：{"uList": ,"u":}
        PrintJson.printJsonObj(response, map);

    }

    /**
     * 删除市场活动列表（可一次性删除多条市场活动）
     * @param request
     * @param response
     */
    private void deleteActivityListInfo(HttpServletRequest request, HttpServletResponse response) {

        //获取要删除的市场活动列表
        String[] ids = request.getParameterValues("id");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.delete(ids);

        //返回：{"success"：true/false}
        PrintJson.printJsonFlag(response, flag);
    }

    /**
     * 查询市场活动信息列表（结合条件查询 + 分页查询）
     * @param request
     * @param response
     */
    private void pageList(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("--------------------进入到查询市场活动信息列表的操作（结合条件查询+分页查询）--------------------");

        String pageNoStr = request.getParameter("pageNo");
        //页数
        int pageNo = Integer.valueOf(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        //每页显示的记录条数
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        String owner = request.getParameter("owner");

        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        Map<String, Object> map = new HashMap<>();
        map.put("owner",owner);

        map.put("name",name);
        map.put("startDate",startDate);
        map.put("endDate",endDate);

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        PaginationVO<Activity> activityPaginationVO = activityService.pageList(map);

        //返回{"total":总数,"dataList":[{活动1},{},{}...]}
        PrintJson.printJsonObj(response, activityPaginationVO);
    }

    /**
     * 市场活动添加功能
     * @param request
     * @param response
     */
    private void saveActivityInfo(HttpServletRequest request, HttpServletResponse response) {

        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        //tbl_user表的主键id字段
        String owner = request.getParameter("owner");

        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");

        Activity activity = new Activity();

        activity.setId(id);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);

        activity.setOwner(owner);

        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = activityService.save(activity);

        //返回：{"success": true/false}
        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 获取tbl_user表的用户名（name）信息，铺展到“所有者”添加的下拉列表框
     * @param request
     * @param response
     */
    private void getAllUserTableOfNameInfoList(HttpServletRequest request, HttpServletResponse response) {

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> users = userService.getAllUserTableOfNameInfoList();

        //返回：[{用户对象1},{用户对象2},{}...]
        PrintJson.printJsonObj(response, users);
    }

}
