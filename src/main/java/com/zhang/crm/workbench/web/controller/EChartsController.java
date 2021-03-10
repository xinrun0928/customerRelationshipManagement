package com.zhang.crm.workbench.web.controller;

import com.zhang.crm.utils.PrintJson;
import com.zhang.crm.utils.ServiceFactory;
import com.zhang.crm.workbench.service.EChartsService;
import com.zhang.crm.workbench.service.impl.EChartsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class EChartsController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入到ECharts控制器");

        //获取当前的请求路径
        String path = request.getServletPath();

        if("/workbench/chart/transaction/getTransactionBasicBarCharts.do".equals(path)){
            getTransactionBasicBarCharts(request,response);
        }else if("/workbench/chart/transaction/getTransactionRefererOfAWebsiteCharts.do".equals(path)){
            getTransactionRefererOfAWebsiteCharts(request,response);
        }else if("/workbench/chart/transaction/getTransactionBasicLineCharts.do".equals(path)){
            getTransactionBasicLineCharts(request,response);
        }else if("/workbench/chart/transaction/getTransactionFunnelCharts.do".equals(path)){
            getTransactionFunnelCharts(request,response);
        }

    }

    /**
     * 交易阶段数量统计漏斗图表的数据（漏斗图Funnel Chart）
     * @param request
     * @param response
     */
    private void getTransactionFunnelCharts(HttpServletRequest request, HttpServletResponse response) {

        EChartsService eChartsService = (EChartsService) ServiceFactory.getService(new EChartsServiceImpl());

        /*
            业务层返回：
                total：总记录条数
                dataList：[{value:每项stage对应的总数量,name:stage字段的名字},{...}...]
                通过map打包以上两项进行返回：{"total":每项的总数,"dataList":[{value:值，name:值},{},{}...]}
         */

        Map<String, Object> map = eChartsService.getTransactionFunnelCharts();

        // System.out.println(map);
        // {total=3, dataList=[{name=03价值建议, value=2}, {name=04确定决策者, value=1}]}

        PrintJson.printJsonObj(response,map);
    }

    /**
     * 交易阶段数量统计折线图图表的数据（折线图Basic Line）
     * @param request
     * @param response
     */
    private void getTransactionBasicLineCharts(HttpServletRequest request, HttpServletResponse response) {
    }

    /**
     * 交易阶段数量统计饼状图表的数据（饼图Referer Of A Website）
     * @param request
     * @param response
     */
    private void getTransactionRefererOfAWebsiteCharts(HttpServletRequest request, HttpServletResponse response) {
        EChartsService eChartsService = (EChartsService) ServiceFactory.getService(new EChartsServiceImpl());
        Map<String, Object> map = eChartsService.getTransactionRefererOfAWebsiteCharts();

        PrintJson.printJsonObj(response,map);
    }

    /**
     * 交易阶段数量统计柱状图表的数据（柱状图Basic Bar）
     * @param request
     * @param response
     */
    private void getTransactionBasicBarCharts(HttpServletRequest request, HttpServletResponse response) {
        EChartsService eChartsService = (EChartsService) ServiceFactory.getService(new EChartsServiceImpl());
//        String[] stage = eChartsService.getTransactionBasicBarCharts();
    }

}
