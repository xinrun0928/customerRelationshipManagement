package com.zhang.crm.workbench.web.controller;

import com.zhang.crm.settings.domain.UpdatePassword;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.settings.service.UserService;
import com.zhang.crm.settings.service.impl.UserServiceImpl;
import com.zhang.crm.utils.MD5Util;
import com.zhang.crm.utils.PrintJson;
import com.zhang.crm.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class SettingsController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入到系统设置控制器");

        String path = request.getServletPath();

        if("/settings/updatePassword.do".equals(path)){
            updatePassword(request,response);
        }else if("/settings/exitSystem.do".equals(path)){
            exitSystem(request,response);
        }

    }

    /**
     * 退出系统
     * @param request
     * @param response
     */
    private void exitSystem(HttpServletRequest request, HttpServletResponse response) {

        PrintJson.printJsonFlag(response,true);
        request.getSession().invalidate();


    }

    /**
     * 修改密码功能
     * @param request
     * @param response
     */
    private void updatePassword(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String oldPwd = request.getParameter("oldPwd");
        String newPwd = request.getParameter("newPwd");
        String confirmPwd = request.getParameter("confirmPwd");

        oldPwd = MD5Util.getMD5(oldPwd);

        newPwd = MD5Util.getMD5(newPwd);
        confirmPwd = MD5Util.getMD5(confirmPwd);

        UpdatePassword updatePassword = new UpdatePassword();
        updatePassword.setId(id);
        updatePassword.setOldPwd(oldPwd);
        updatePassword.setNewPwd(newPwd);
        updatePassword.setConfirmPwd(confirmPwd);

        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        try {
            User user = userService.updatePassword(updatePassword);

            request.getSession().invalidate();

            PrintJson.printJsonFlag(response,true);
        }catch (Exception e){
            e.printStackTrace();

            String msg = e.getMessage();

            Map<String,Object> map = new HashMap<>();
            map.put("msg",msg);
            map.put("success",false);

            PrintJson.printJsonObj(response,map);
        }

    }
}
