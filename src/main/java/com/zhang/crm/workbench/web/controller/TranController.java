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
import com.zhang.crm.workbench.domain.Contacts;
import com.zhang.crm.workbench.domain.Tran;
import com.zhang.crm.workbench.domain.TranHistory;
import com.zhang.crm.workbench.service.ActivityService;
import com.zhang.crm.workbench.service.ContactsService;
import com.zhang.crm.workbench.service.CustomerService;
import com.zhang.crm.workbench.service.TranService;
import com.zhang.crm.workbench.service.impl.ActivityServiceImpl;
import com.zhang.crm.workbench.service.impl.ContactsServiceImpl;
import com.zhang.crm.workbench.service.impl.CustomerServiceImpl;
import com.zhang.crm.workbench.service.impl.TranServiceImpl;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TranController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("========================================进入到交易控制器========================================");

        //获取当前的请求路径
        String path = request.getServletPath();

        if("/workbench/transaction/add.do".equals(path)){
            add(request,response);
        }else if("/workbench/transaction/getCustomerName.do".equals(path)){
            getCustomerName(request,response);
        }else if("/workbench/transaction/save.do".equals(path)){
            save(request,response);
        }else if("/workbench/transaction/detail.do".equals(path)){
            detail(request,response);
        }else if("/workbench/transaction/getHistoryListByTranId.do".equals(path)){
            getHistoryListByTranId(request,response);
        }else if("/workbench/transaction/changeStage.do".equals(path)){
            changeStage(request,response);
        }else if("/workbench/transaction/getTransactionList.do".equals(path)){
            getTransactionList(request,response);
        }else if("/workbench/transaction/deleteTransactionListInfo.do".equals(path)){
            deleteTransactionListInfo(request,response);
        }else if("/workbench/transaction/edit.do".equals(path)){
            edit(request,response);
        }else if("/workbench/transaction/getActivityList.do".equals(path)){
            getActivityList(request,response);
        }else if("/workbench/transaction/searchActivityList.do".equals(path)){
            searchActivityList(request,response);
        }else if("/workbench/transaction/getActivityNameByActivityId.do".equals(path)){
            getActivityNameByActivityId(request,response);
        }else if("/workbench/transaction/searchContactsList.do".equals(path)){
            searchContactsList(request,response);
        }else if("/workbench/transaction/getContactsNameByContactsId.do".equals(path)){
            getContactsNameByContactsId(request,response);
        }

    }

    /**
     * 通过联系人id获取联系人姓名
     * @param request
     * @param response
     */
    private void getContactsNameByContactsId(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("contactsId");

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());

        Contacts contacts = contactsService.getContactsNameByContactsId(id);

        PrintJson.printJsonObj(response,contacts);
    }

    /**
     * 按下回车键查询联系人列表信息
     * @param request
     * @param response
     */
    private void searchContactsList(HttpServletRequest request, HttpServletResponse response) {

        String name = request.getParameter("name");

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());
        List<Contacts> contacts = contactsService.searchContactsList(name);

        PrintJson.printJsonObj(response,contacts);

    }

    /**
     * 通过市场活动id获取市场活动名称
     * @param request
     * @param response
     */
    private void getActivityNameByActivityId(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("activityId");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Activity activity = activityService.getActivityNameByActivityId(id);

        PrintJson.printJsonObj(response,activity);

    }

    /**
     * 按下回车键通过市场活动名称模糊查询市场活动信息列表
     * @param request
     * @param response
     */
    private void searchActivityList(HttpServletRequest request, HttpServletResponse response) {

        String name = request.getParameter("name");

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> activities = activityService.searchActivityListByName(name);

        PrintJson.printJsonObj(response,activities);

    }

    /**
     * 点击市场活动的超链接图标，将市场活动列表展示到模态窗口上
     * @param request
     * @param response
     */
    private void getActivityList(HttpServletRequest request, HttpServletResponse response) {

        ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> activities = activityService.getActivityList();

        PrintJson.printJsonObj(response,activities);
    }

    /**
     * 修改交易信息之前，获取交易信息列表转发到修改交易页面
     * @param request
     * @param response
     */
    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        Tran tran = tranService.getTransactionInfoById(id);


        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> uList = userService.getAllUserTableOfNameInfoList();

        request.setAttribute("tran",tran);
        request.setAttribute("uList",uList);

        request.getRequestDispatcher("/workbench/transaction/edit.jsp").forward(request,response);
    }

    private void deleteTransactionListInfo(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());

        boolean flag = tranService.deleteTransactionListInfo(id);

        PrintJson.printJsonFlag(response,flag);
    }

    private void getTransactionList(HttpServletRequest request, HttpServletResponse response) {
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录条数
        int skipCount = (pageNo - 1) * pageSize;

        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String customerName = request.getParameter("customerName");
        String stage = request.getParameter("stage");
        String type = request.getParameter("type");
        String source = request.getParameter("source");
        String contactsName = request.getParameter("contactsName");

        Map<String, Object> map = new HashMap<>();
        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        map.put("owner",owner);
        map.put("name",name);
        map.put("customerName",customerName);
        map.put("stage",stage);
        map.put("type",type);
        map.put("source",source);
        map.put("contactsName",contactsName);

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        PaginationVO<Tran> tranPaginationVO = tranService.getTransactionList(map);

        PrintJson.printJsonObj(response,tranPaginationVO);

    }

    private void changeStage(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("执行改变阶段操作");

        String id = request.getParameter("id");
        String stage = request.getParameter("stage");
        String money = request.getParameter("money");
        String expectedDate = request.getParameter("expectedDate");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        Tran tran = new Tran();
        tran.setId(id);
        tran.setStage(stage);
        tran.setMoney(money);
        tran.setExpectedDate(expectedDate);
        tran.setEditBy(editBy);
        tran.setEditTime(editTime);

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        boolean flag = tranService.changeStage(tran);

        ServletContext application = this.getServletContext();
        Map<String ,String > propertiesMap = (Map<String, String>) application.getAttribute("propertiesMap");
        String possibility = propertiesMap.get(stage);

        tran.setPossibility(possibility);

        Map<String ,Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("t",tran);

        PrintJson.printJsonObj(response,map);

    }

    private void getHistoryListByTranId(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("根据交易id取得相应的历史交易列表");

        String tranId = request.getParameter("tranId");

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());

        List<TranHistory> tranHistories = tranService.getHistoryListByTranId(tranId);

        ServletContext application = this.getServletContext();
        Map<String ,String > propertiesMap = (Map<String, String>) application.getAttribute("propertiesMap");

        //将交易列表遍历
        for(TranHistory tranHistory : tranHistories){
            //根据每一条交易历史，取出每一个阶段
            String stage = tranHistory.getStage();
            String possibility = propertiesMap.get(stage);
            tranHistory.setPossibility(possibility);
        }

        PrintJson.printJsonObj(response,tranHistories);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("跳转到详细信息页");

        String id = request.getParameter("id");

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());

        Tran tran = tranService.detail(id);

        //处理可能性
        String stage = tran.getStage();

        ServletContext application = this.getServletContext();
        Map<String ,String > propertiesMap = (Map<String, String>) application.getAttribute("propertiesMap");
        String possibility = propertiesMap.get(stage);

        tran.setPossibility(possibility);

        request.setAttribute("tran",tran);

        request.getRequestDispatcher("/workbench/transaction/detail.jsp").forward(request,response);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) throws IOException {

        System.out.println("进入到添加交易的操作");

        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String money = request.getParameter("money");
        String name = request.getParameter("name");
        String expectedDate = request.getParameter("expectedDate");
        String customerName = request.getParameter("customerName");     //没有customerId
        String stage = request.getParameter("stage");
        String type = request.getParameter("type");
        String source = request.getParameter("source");
        String activityId = request.getParameter("activityId");
        String contactsId = request.getParameter("contactsId");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");

        Tran tran = new Tran();
        tran.setId(id);
        tran.setOwner(owner);
        tran.setMoney(money);
        tran.setName(name);
        tran.setExpectedDate(expectedDate);
//        tran.setCustomerId();
        tran.setStage(stage);
        tran.setType(type);
        tran.setSource(source);
        tran.setActivityId(activityId);
        tran.setContactsId(contactsId);
        tran.setCreateBy(createBy);
        tran.setCreateTime(createTime);
        tran.setDescription(description);
        tran.setContactSummary(contactSummary);
        tran.setNextContactTime(nextContactTime);

        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        boolean flag = tranService.save(tran,customerName);

        if(flag){
            //如果添加交易成功，跳转到列表页

            response.sendRedirect(request.getContextPath() + "/workbench/transaction/index.jsp");
        }

    }

    private void getCustomerName(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("---------------------------取得 客户名称列表（按照客户名称模糊查询）----------------------------");

        String name = request.getParameter("name");

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());

        List<String> sList = customerService.getCustomerName(name);

        PrintJson.printJsonObj(response,sList);

    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("----------------------------------进入到跳转到交易添加页的操作----------------------------------");

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> uList = userService.getAllUserTableOfNameInfoList();

        request.setAttribute("uList",uList);

        request.getRequestDispatcher("/workbench/transaction/save.jsp").forward(request,response);

    }
}
