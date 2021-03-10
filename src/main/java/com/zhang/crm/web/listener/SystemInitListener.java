package com.zhang.crm.web.listener;

import com.zhang.crm.settings.domain.DicValue;
import com.zhang.crm.settings.service.DicService;
import com.zhang.crm.settings.service.impl.DicServiceImpl;
import com.zhang.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

public class SystemInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("===================================服务器缓存处理数据字典开始===================================");
        //创建application域对象
        ServletContext application = event.getServletContext();

        DicService dicService = (DicService) ServiceFactory.getService(new DicServiceImpl());

        //从数据库中查询出数据字典的类型和值，将其封装成map集合
        Map<String, List<DicValue>> map = dicService.getAllInfo();

        //取出map集合中的所有key
        Set<String> set = map.keySet();

        //遍历每一个key,通过key取出map集合中对应的value值，并将key和value存储在application域对象中
        for(String key : set){
            application.setAttribute(key, map.get(key));
        }

        System.out.println("===================================服务器缓存处理数据字典结束===================================");
        System.out.println("");
        System.out.println("========================解析Stage2Possibility.properties属性配置文件开始========================");

        //解析该属性配置文件，将该属性配置文件中的键值对处理成为Java中的键值对关系(map集合存储)
        //通过ResourceBundle解析配置文件时，无需加上  .properties     后缀名
        ResourceBundle resourceBundle = ResourceBundle.getBundle("Stage2Possibility");

        Map<String, String> propertiesMap = new HashMap<>();

        //获得所有key
        Enumeration<String> enumeration = resourceBundle.getKeys();

        //枚举出key对应的value
        while (enumeration.hasMoreElements()){
            String key = enumeration.nextElement();
            String value = resourceBundle.getString(key);

            System.out.println("key = " + key + ",value = " + value);

            //每遍历一次，就将对应的key和value封装到map集合中
            propertiesMap.put(key,value);
        }

        //将map存储到上下文对象中
        application.setAttribute("propertiesMap",propertiesMap);

        System.out.println("========================解析Stage2Possibility.properties属性配置文件结束========================");
    }
}