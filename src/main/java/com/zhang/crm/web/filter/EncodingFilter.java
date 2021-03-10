package com.zhang.crm.web.filter;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("====================欢迎使用小小张的CRM<Customer Relationship Management>系统====================");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println("------------------------------------进入到过滤字符编码的过滤器-----------------------------------");
        //过滤post请求，中文请求参数乱码问题
        request.setCharacterEncoding("utf-8");
        //过滤post请求，响应流乱码问题
        response.setContentType("text/html;charset=utf-8");

        //请求放行
        chain.doFilter(request,response);
    }

    public void destroy() {
        System.out.println("==========感谢您使用小小张的CRM<Customer Relationship Management>系统，期待您的再次使用==========");
    }
}
