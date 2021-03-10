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
import com.zhang.crm.workbench.domain.Clue;
import com.zhang.crm.workbench.domain.ClueRemark;
import com.zhang.crm.workbench.domain.Tran;
import com.zhang.crm.workbench.service.ActivityService;
import com.zhang.crm.workbench.service.ClueService;
import com.zhang.crm.workbench.service.impl.ActivityServiceImpl;
import com.zhang.crm.workbench.service.impl.ClueServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClueController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("========================================进入到线索控制器========================================");

        //获取当前的请求路径
        String path = request.getServletPath();

        if("/workbench/clue/getAllUserTableOfNameInfoList.do".equals(path)){
            getUserList(request,response);
        }else if("/workbench/clue/save.do".equals(path)){
            save(request,response);
        }else if("/workbench/clue/detail.do".equals(path)){
            detail(request,response);
        }else if("/workbench/clue/getActivityListByClueId.do".equals(path)){
            getActivityListByClueId(request,response);
        }else if("/workbench/clue/unbund.do".equals(path)){
            unbund(request,response);
        }else if("/workbench/clue/getActivityListByNameAndNotByClueId.do".equals(path)){
            getActivityListByNameAndNotByClueId(request,response);
        }else if("/workbench/clue/bund.do".equals(path)){
            bund(request,response);
        }else if("/workbench/clue/getActivityListByName.do".equals(path)){
            getActivityListByName(request,response);
        }else if("/workbench/clue/convert.do".equals(path)){
            convert(request,response);
        }else if("/workbench/clue/pageList.do".equals(path)){
            pageList(request,response);
        }else if("/workbench/clue/deleteClueListInfo.do".equals(path)){
            deleteClueListInfo(request,response);
        }else if("/workbench/clue/getUserListAndClue.do".equals(path)){
            getUserListAndClue(request,response);
        }else if("/workbench/clue/updateClueList.do".equals(path)){
            updateClueList(request,response);
        }else if("/workbench/clue/deleteRemarkInfo.do".equals(path)){
            deleteRemarkInfo(request,response);
        }else if("/workbench/clue/saveRemarkInfo.do".equals(path)){
            saveRemarkInfo(request,response);
        }else if("/workbench/clue/getRemarkListByClueId.do".equals(path)){
            getRemarkListByClueId(request,response);
        }

    }

    private void getRemarkListByClueId(HttpServletRequest request, HttpServletResponse response) {
        String clueId = request.getParameter("clueId");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        List<ClueRemark> clueRemark  = clueService.getRemarkListByClueId(clueId);

        PrintJson.printJsonObj(response,clueRemark);
    }

    /**
     * 保存备注信息列表
     * @param request
     * @param response
     */
    private void saveRemarkInfo(HttpServletRequest request, HttpServletResponse response) {

        String clueId = request.getParameter("clueId");
        String noteContent = request.getParameter("noteContent");

        String id = UUIDUtil.getUUID();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String editFlag = "0";

        ClueRemark clueRemark = new ClueRemark();
        clueRemark.setId(id);
        clueRemark.setClueId(clueId);
        clueRemark.setNoteContent(noteContent);
        clueRemark.setCreateBy(createBy);
        clueRemark.setCreateTime(createTime);
        clueRemark.setEditFlag(editFlag);

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = clueService.saveRemarkInfo(clueRemark);

        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("cr",clueRemark);

        PrintJson.printJsonObj(response,map);


    }

    /**
     * 删除单条线索记录
     * @param request
     * @param response
     */
    private void deleteRemarkInfo(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = clueService.deleteRemarkInfo(id);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 更新线索列表信息
     * @param request
     * @param response
     */
    private void updateClueList(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String owner = request.getParameter("owner");

        String fullname = request.getParameter("fullname");
        String appellation = request.getParameter("appellation");
        String company = request.getParameter("company");
        String job = request.getParameter("job");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String website = request.getParameter("website");
        String mphone = request.getParameter("mphone");
        String state = request.getParameter("state");
        String source = request.getParameter("source");
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String address = request.getParameter("address");

        Clue clue = new Clue();
        clue.setId(id);
        clue.setOwner(owner);
        clue.setFullname(fullname);
        clue.setAppellation(appellation);
        clue.setCompany(company);
        clue.setJob(job);
        clue.setEmail(email);
        clue.setPhone(phone);
        clue.setWebsite(website);
        clue.setMphone(mphone);
        clue.setState(state);
        clue.setSource(source);
        clue.setEditBy(editBy);
        clue.setEditTime(editTime);
        clue.setDescription(description);
        clue.setContactSummary(contactSummary);
        clue.setNextContactTime(nextContactTime);
        clue.setAddress(address);

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());

        boolean flag = clueService.updateClueList(clue);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 获取用户和线索列表
     * @param request
     * @param response
     */
    private void getUserListAndClue(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());

        Map<String,Object> map = clueService.getUserListAndClue(id);

        PrintJson.printJsonObj(response,map);
    }

    /**
     * 删除线索（潜在客户）列表
     * @param request
     * @param response
     */
    private void deleteClueListInfo(HttpServletRequest request, HttpServletResponse response) {

        String[] ids = request.getParameterValues("id");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());

        boolean flag = clueService.deleteClueListInfo(ids);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 进入到查询线索列表（结合条件查询+分页查询）
     * @param request
     * @param response
     */
    private void pageList(HttpServletRequest request, HttpServletResponse response) {

        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //略过的记录条数
        int skipCount = (pageNo - 1) * pageSize;

        String fullname = request.getParameter("fullname");
        String company = request.getParameter("company");
        String phone = request.getParameter("phone");
        String mphone = request.getParameter("mphone");
        String source = request.getParameter("source");
        String owner = request.getParameter("owner");
        String state = request.getParameter("state");

        Map<String, Object> map = new HashMap<>();
        map.put("fullname",fullname);
        map.put("company",company);
        map.put("phone",phone);
        map.put("mphone",mphone);
        map.put("source",source);
        map.put("owner",owner);
        map.put("state",state);

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        PaginationVO<Clue> cluePaginationVO = clueService.pageList(map);

        //返回{"total":总数,"dataList":[{线索1},{},{}...]}
        PrintJson.printJsonObj(response,cluePaginationVO);
    }

    /**
     * 执行线索转换操作
     * @param request
     * @param response
     * @throws IOException
     */
    private void convert(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String clueId = request.getParameter("clueId");

        //接受是否需要创建交易的标记
        String flag = request.getParameter("isFlag");

        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        Tran tran = null;

        if("isFlag".equals(flag)){
            //接受表单的参数
            String activityId = request.getParameter("activityId");
            String money = request.getParameter("money");
            String name = request.getParameter("name");
            String expectedData = request.getParameter("expectedData");
            String stage = request.getParameter("stage");
            String id = UUIDUtil.getUUID();
            String createTime = DateTimeUtil.getSysTime();

            tran = new Tran();
            tran.setId(id);
            tran.setActivityId(activityId);
            tran.setMoney(money);
            tran.setName(name);
            tran.setExpectedDate(expectedData);
            tran.setStage(stage);
            tran.setCreateTime(createTime);
            tran.setCreateBy(createBy);

        }

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean myFlag = clueService.convert(clueId,tran,createBy);

        if(myFlag){
            response.sendRedirect(request.getContextPath() + "/workbench/clue/index.jsp");
        }else {
            System.out.println("执行转换线索失败");
        }
    }

    /**
     * 执行搜索市场活动列表的操作（根据名称查）
     * @param request
     * @param response
     */
    private void getActivityListByName(HttpServletRequest request, HttpServletResponse response) {

        String activityName = request.getParameter("activityName");
//        System.out.println(activityName);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> aList = activityService.getActivityListByName(activityName);

        PrintJson.printJsonObj(response,aList);

    }

    /**
     * 执行关联市场活动的操作
     * @param request
     * @param response
     */
    private void bund(HttpServletRequest request, HttpServletResponse response) {

        String clueId = request.getParameter("clueId");
        String[] activityIds = request.getParameterValues("activityId");
        System.out.println("activityIds = " + activityIds);

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = clueService.bund(clueId, activityIds);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 查询市场活动列表（根据名称模糊查询，排除已关联指定线索的列表）
     * @param request
     * @param response
     */
    private void getActivityListByNameAndNotByClueId(HttpServletRequest request, HttpServletResponse response) {

        String aname = request.getParameter("aname");
        String clueId = request.getParameter("clueId");

        Map<String, String> map = new HashMap<>();
        map.put("aname",aname);
        map.put("clueId",clueId);

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> activities = activityService.getActivityListByNameAndNotByClueId(map);

        PrintJson.printJsonObj(response,activities);
    }

    /**
     * 执行解除关联的操作
     * @param request
     * @param response
     */
    private void unbund(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = clueService.unbund(id);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 根据线索id查询关联的市场活动列表
     * @param request
     * @param response
     */
    private void getActivityListByClueId(HttpServletRequest request, HttpServletResponse response) {

        String clueId = request.getParameter("clueId");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> aList = activityService.getActivityListByClueId(clueId);

        PrintJson.printJsonObj(response,aList);
    }

    /**
     * 进入到线索详细信息页
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Clue clue = clueService.detail(id);

        request.setAttribute("c",clue);
//        System.out.println(clue);

        request.getRequestDispatcher("/workbench/clue/detail.jsp").forward(request,response);
    }

    /**
     * 执行线索添加操作
     * @param request
     * @param response
     */
    private void save(HttpServletRequest request, HttpServletResponse response) {

        String id = UUIDUtil.getUUID();
        String fullname = request.getParameter("fullname");
        String appellation = request.getParameter("appellation");
        String owner = request.getParameter("owner");
        String company = request.getParameter("company");
        String job = request.getParameter("job");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String website = request.getParameter("website");
        String mphone = request.getParameter("mphone");
        String state = request.getParameter("state");
        String source = request.getParameter("source");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String address = request.getParameter("address");

        Clue clue = new Clue();
        clue.setId(id);
        clue.setFullname(fullname);
        clue.setAddress(address);
        clue.setAppellation(appellation);
        clue.setOwner(owner);
        clue.setCompany(company);
        clue.setJob(job);
        clue.setEmail(email);
        clue.setPhone(phone);
        clue.setWebsite(website);
        clue.setMphone(mphone);
        clue.setState(state);
        clue.setSource(source);
        clue.setCreateBy(createBy);
        clue.setCreateTime(createTime);
        clue.setDescription(description);
        clue.setContactSummary(contactSummary);
        clue.setNextContactTime(nextContactTime);

        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = clueService.save(clue);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 取得用户信息列表
     * @param request
     * @param response
     */
    private void getUserList(HttpServletRequest request, HttpServletResponse response) {

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> uList = userService.getAllUserTableOfNameInfoList();

        PrintJson.printJsonObj(response,uList);
    }



}
