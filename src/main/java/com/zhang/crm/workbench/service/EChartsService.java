package com.zhang.crm.workbench.service;

import java.util.Map;

public interface EChartsService {

    //交易阶段数量楼漏斗图
    Map<String, Object> getTransactionFunnelCharts();

    Map<String, Object> getTransactionRefererOfAWebsiteCharts();


//    String[] getTransactionBasicBarCharts();
}
