package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int save(Tran tran);

    Tran detail(String id);

    int changeStage(Tran tran);

    int getTotal();

    List<Map<String, Object>> getCharts();

    String[] getStages();

    int getTotalByCondition(Map<String, Object> map);

    List<Tran> getTransactionListByCondition(Map<String, Object> map);

    int deleteTransactionListInfo(String id);

    Tran getTransactionInfoById(String id);
}
