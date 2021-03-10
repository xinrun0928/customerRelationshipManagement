package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.workbench.dao.TranDao;
import com.zhang.crm.workbench.service.EChartsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EChartsServiceImpl implements EChartsService {

    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);

    @Override
    public Map<String, Object> getTransactionFunnelCharts() {

        //取得total
        int total = tranDao.getTotal();

        //取得dataList
        List<Map<String, Object>> dataList = tranDao.getCharts();

//        System.out.println(dataList);

        //将total和dataList封装到map中
        Map<String, Object> map = new HashMap<>();
        map.put("total",total);
        map.put("dataList",dataList);

        return map;
    }

    @Override
    public Map<String, Object> getTransactionRefererOfAWebsiteCharts() {
        return null;
    }

    //    @Override
    public String[] getTransactionBasicBarCharts() {

        //获取阶段名称

        //获得每个阶段的总数

        return null;
    }
}
