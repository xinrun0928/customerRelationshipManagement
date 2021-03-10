package com.zhang.crm.settings.web.controller;

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

public class UserController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("========================================进入到用户控制器========================================");

        //获取当前的请求路径信息
        String path = request.getServletPath();

        if("/settings/user/login.do".equals(path)){
            login(request, response);
        }

    }

    private void login(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("---------------------------------------进入到登录验证方法---------------------------------------");

        //获取登录用户名和密码
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        //System.out.println("loginAct = " + loginAct);
        //System.out.println("loginPwd = " + loginPwd);

        //将明文通过MD5转换为密文，不可逆过程
        loginPwd = MD5Util.getMD5(loginPwd);

        //获取当前IP地址
        String ipAddress = request.getRemoteAddr();
        System.out.println("ipAddress = " + ipAddress);


        //动态代理创建userService对象
        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

        try{
            //进行登录验证
            User user = userService.login(loginAct, loginPwd, ipAddress);

            //将当前用户的所有信息添加到session会话域中，方便后面使用
            request.getSession().setAttribute("user", user);

            //如果执行到此处。说明业务层没有抛出任何异常，表示登录成功

            //返回{"success",true}
            PrintJson.printJsonFlag(response,true);
        }catch (Exception e){
            e.printStackTrace();

            //说明登录失败，业务层抛出了异常，并取得该异常的异常信息内容
            String msg = e.getMessage();

            //封装到map集合返回到页面
            Map<String, Object > map = new HashMap<>();
            map.put("success",false);
            map.put("msg",msg);

            //返回{"success":false,"msg":msg}
            PrintJson.printJsonObj(response,map);
        }
    }
}
