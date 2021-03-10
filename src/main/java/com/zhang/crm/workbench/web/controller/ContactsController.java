package com.zhang.crm.workbench.web.controller;

import com.zhang.crm.settings.domain.User;
import com.zhang.crm.settings.service.UserService;
import com.zhang.crm.settings.service.impl.UserServiceImpl;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.PrintJson;
import com.zhang.crm.utils.ServiceFactory;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Contacts;
import com.zhang.crm.workbench.service.ContactsService;
import com.zhang.crm.workbench.service.impl.ContactsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ContactsController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入联系人控制器");

        String path = request.getServletPath();

        if("/workbench/contacts/getContactsList.do".equals(path)){
            getContactsList(request,response);
        }else if("/workbench/contacts/saveContact.do".equals(path)){
            saveContact(request,response);
        }else if("/workbench/contacts/getAllUserTableOfNameInfoList.do".equals(path)){
            getAllUserTableOfNameInfoList(request,response);
        }else if("/workbench/contacts/getUserListAndContacts.do".equals(path)){
            getUserListAndContacts(request,response);
        }else if("/workbench/customer/updateContactsList.do".equals(path)){
            updateContactsList(request,response);
        }else if("/workbench/contacts/deleteContactsListInfo.do".equals(path)){
            deleteContactsListInfo(request,response);
        }else if("/workbench/contacts/showContactsDetailInfo.do".equals(path)){
            showContactsDetailInfo(request,response);
        }
    }

    /**
     * 跳转到联系人详细信息页面
     * @param request
     * @param response
     */
    private void showContactsDetailInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());

        Contacts contacts = contactsService.detail(id);

        request.setAttribute("c",contacts);

        request.getRequestDispatcher("/workbench/contacts/detail.jsp").forward(request,response);
    }

    /**
     * 删除联系人列表信息功能
     * @param request
     * @param response
     */
    private void deleteContactsListInfo(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("id");

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());

        boolean flag = contactsService.deleteContactsListInfo(ids);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 更新联系人列表
     * @param request
     * @param response
     */
    private void updateContactsList(HttpServletRequest request, HttpServletResponse response) {

        String customerName = request.getParameter("customerName");

        String id = request.getParameter("id");
        String owner = request.getParameter("owner");

        String source = request.getParameter("source");
        String fullname = request.getParameter("fullname");
        String appellation = request.getParameter("appellation");
        String email = request.getParameter("email");
        String mphone = request.getParameter("mphone");
        String job = request.getParameter("job");
        String birth = request.getParameter("birth");
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String address = request.getParameter("address");

        Contacts contacts = new Contacts();
        contacts.setId(id);
        contacts.setOwner(owner);
        contacts.setSource(source);
        contacts.setFullname(fullname);
        contacts.setAppellation(appellation);
        contacts.setMphone(mphone);
        contacts.setJob(job);
        contacts.setBirth(birth);
        contacts.setEmail(email);
        contacts.setEditBy(editBy);
        contacts.setEditTime(editTime);
        contacts.setDescription(description);
        contacts.setContactSummary(contactSummary);
        contacts.setNextContactTime(nextContactTime);
        contacts.setAddress(address);

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());

        boolean flag = contactsService.updateContactsList(contacts,customerName);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 获得用户列表信息和对应id的联系人列表信息
     * @param request
     * @param response
     */
    private void getUserListAndContacts(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());

        Map<String, Object> map = contactsService.getUserListAndContacts(id);

        PrintJson.printJsonObj(response,map);
    }

    /**
     * 获取tbl_user表中的name列的值
     * @param request
     * @param response
     */
    private void getAllUserTableOfNameInfoList(HttpServletRequest request, HttpServletResponse response) {

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> users = userService.getAllUserTableOfNameInfoList();

        //返回：[{用户列表1},{用户列表2},{用户列表3}...]
        PrintJson.printJsonObj(response,users);
    }

    /**
     * 执行保存联系人的操作
     * @param request
     * @param response
     */
    private void saveContact(HttpServletRequest request, HttpServletResponse response) {

        // customerId

        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String source = request.getParameter("source");
        String customerName = request.getParameter("customerName");
        String fullname = request.getParameter("fullname");
        String appellation = request.getParameter("appellation");
        String email = request.getParameter("email");
        String mphone = request.getParameter("mphone");
        String job = request.getParameter("job");
        String birth = request.getParameter("birth");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String address = request.getParameter("address");

        Contacts contacts = new Contacts();
        contacts.setId(id);
        contacts.setOwner(owner);
        contacts.setSource(source);
//        contacts.setCustomerId();
        contacts.setFullname(fullname);
        contacts.setAppellation(appellation);
        contacts.setEmail(email);
        contacts.setMphone(mphone);
        contacts.setJob(job);
        contacts.setBirth(birth);
        contacts.setCreateBy(createBy);
        contacts.setCreateTime(createTime);
        contacts.setDescription(description);
        contacts.setContactSummary(contactSummary);
        contacts.setNextContactTime(nextContactTime);
        contacts.setAddress(address);

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());
        boolean flag = contactsService.saveContact(contacts, customerName);

        PrintJson.printJsonFlag(response,flag);

    }

    /**
     * 查询联系人列表（结合条件查询+分页查询）
     * @param request
     * @param response
     */
    private void getContactsList(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("进入到查询联系人列表的操作（结合条件查询+分页查询）");

        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        String owner = request.getParameter("owner");
        String fullname = request.getParameter("fullname");
        String customerName = request.getParameter("customerName");
        String source = request.getParameter("source");
        String birth = request.getParameter("birth");

        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<>();
        map.put("skipCount", skipCount);
        map.put("pageSize",pageSize);

        map.put("owner",owner);
        map.put("fullname",fullname);
        map.put("source",source);
        map.put("birth",birth);

        map.put("customerName",customerName);

        ContactsService contactsService = (ContactsService) ServiceFactory.getService(new ContactsServiceImpl());
        PaginationVO<Contacts> contactsPaginationVO = contactsService.pageList(map);

        PrintJson.printJsonObj(response, contactsPaginationVO);

    }
}
