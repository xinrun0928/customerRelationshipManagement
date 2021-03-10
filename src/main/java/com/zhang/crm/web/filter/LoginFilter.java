package com.zhang.crm.web.filter;

import com.zhang.crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println("----------------------------------进入到验证有没有登录过的过滤器---------------------------------");

        //转换成带有http协议的request，response对象
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;

        //获取当前的请求路径信息
        String path = httpServletRequest.getServletPath();

        //放行不应该拦截的请求路径
        if("/login.jsp".equals(path) || "/settings/user/login.do".equals(path)){
            //放行请求
            chain.doFilter(httpServletRequest,httpServletResponse);
        }else {
            HttpSession session = httpServletRequest.getSession();
            User user = (User) session.getAttribute("user");

            if(user != null){
                //如果user不为空，则说明能从session中取出user对象，则说明已经登陆过该系统，则需要将请求放行
                chain.doFilter(httpServletRequest,httpServletResponse);
            }else {
                //从session域中取不出user对象，则说明未登录过，需要跳转回登陆界面
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override
    public void destroy() {

    }
}
