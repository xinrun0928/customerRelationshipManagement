package com.zhang.crm.workbench.web.controller;

import com.zhang.crm.settings.domain.User;
import com.zhang.crm.settings.service.UserService;
import com.zhang.crm.settings.service.impl.UserServiceImpl;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.PrintJson;
import com.zhang.crm.utils.ServiceFactory;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Customer;
import com.zhang.crm.workbench.service.CustomerService;
import com.zhang.crm.workbench.service.impl.CustomerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入到客户控制器");

        //获取当前的请求路径
        String path = request.getServletPath();

        if("/workbench/customer/getCustomerList.do".equals(path)){
            getCustomerList(request,response);
        }else if("/workbench/customer/getAllUserTableOfNameInfoList.do".equals(path)){
            getAllUserTableOfNameInfoList(request,response);
        }else if("/workbench/customer/saveCustomerInfo.do".equals(path)){
            saveCustomerInfo(request,response);
        }else if("/workbench/customer/getUserListAndCustomer.do".equals(path)){
            getUserListAndActivity(request,response);
        }else if("/workbench/customer/updateCustomerList.do".equals(path)){
            updateCustomerList(request,response);
        }else if("/workbench/customer/deleteCustomerListInfo.do".equals(path)){
            deleteCustomerListInfo(request,response);
        }else if("/workbench/customer/showCustomerDetailInfo.do".equals(path)){
            showCustomerDetailInfo(request,response);
        }

    }

    /**
     * 跳转到详细信息页面
     * @param request
     * @param response
     */
    private void showCustomerDetailInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());

        Customer customer = customerService.showCustomerDetailInfo(id);

        request.setAttribute("c",customer);

        request.getRequestDispatcher("/workbench/customer/detail.jsp").forward(request,response);
    }

    /**
     * 删除客户信息功能
     * @param request
     * @param response
     */
    private void deleteCustomerListInfo(HttpServletRequest request, HttpServletResponse response) {

        String[] ids = request.getParameterValues("id");

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        boolean flag = customerService.deleteCustomerListInfo(ids);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 更新客户信息功能
     * @param request
     * @param response
     */
    private void updateCustomerList(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String website = request.getParameter("website");
        String phone = request.getParameter("phone");
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editTime = DateTimeUtil.getSysTime();
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String description = request.getParameter("description");
        String address = request.getParameter("address");

        Customer customer = new Customer();
        customer.setId(id);
        customer.setOwner(owner);
        customer.setName(name);
        customer.setWebsite(website);
        customer.setPhone(phone);
        customer.setEditBy(editBy);
        customer.setEditTime(editTime);
        customer.setContactSummary(contactSummary);
        customer.setNextContactTime(nextContactTime);
        customer.setDescription(description);
        customer.setAddress(address);

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        boolean flag = customerService.updateCustomerList(customer);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 编辑客户信息按钮（编辑信息之前）
     * @param request
     * @param response
     */
    private void getUserListAndActivity(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        Map<String, Object> map = customerService.getUserListAndActivity(id);

        PrintJson.printJsonObj(response,map);

    }

    /**
     * 保存客户信息
     * @param request
     * @param response
     */
    private void saveCustomerInfo(HttpServletRequest request, HttpServletResponse response) {

        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String website = request.getParameter("website");
        String phone = request.getParameter("phone");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String description = request.getParameter("description");
        String address = request.getParameter("address");

        Customer customer = new Customer();
        customer.setId(id);
        customer.setOwner(owner);
        customer.setName(name);
        customer.setWebsite(website);
        customer.setPhone(phone);
        customer.setCreateBy(createBy);
        customer.setCreateTime(createTime);
        customer.setContactSummary(contactSummary);
        customer.setNextContactTime(nextContactTime);
        customer.setDescription(description);
        customer.setAddress(address);

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        boolean flag = customerService.saveCustomerInfo(customer);

        PrintJson.printJsonFlag(response,flag);
    }

    /**
     * 添加客户信息按钮功能，获得tbl_user表的用户信息
     * @param request
     * @param response
     */
    private void getAllUserTableOfNameInfoList(HttpServletRequest request, HttpServletResponse response) {

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> user = userService.getAllUserTableOfNameInfoList();

        //返回：[{用户信息1},{用户信息2},{用户信息3}....]
        PrintJson.printJsonObj(response,user);
    }

    /**
     * 查询客户信息（条件查询结合分页查询）
     * @param request
     * @param response
     */
    private void getCustomerList(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("进入到查询客户信息的操作（结合条件查询+分页查询）");

        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        String name = request.getParameter("name");
        String owner = request.getParameter("owner");
        String phone = request.getParameter("phone");
        String website = request.getParameter("website");

        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("phone",phone);
        map.put("website",website);

        map.put("skipCount",skipCount);
        map.put("pageSize",pageSize);

        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        PaginationVO<Customer> customerPaginationVO = customerService.pageList(map);

        //返回{"total":总数,"pageList":[{客户1},{客户2}...]}
        PrintJson.printJsonObj(response,customerPaginationVO);
    }
}
