package com.zhang.crm.workbench.service;

import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Tran;
import com.zhang.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranService {
    boolean save(Tran tran, String customerName);

    Tran detail(String id);

    List<TranHistory> getHistoryListByTranId(String tranId);

    boolean changeStage(Tran tran);

    PaginationVO<Tran> getTransactionList(Map<String, Object> map);

    boolean deleteTransactionListInfo(String id);

    Tran getTransactionInfoById(String id);
}
