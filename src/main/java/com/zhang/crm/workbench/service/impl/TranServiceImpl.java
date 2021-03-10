package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.dao.CustomerDao;
import com.zhang.crm.workbench.dao.TranDao;
import com.zhang.crm.workbench.dao.TranHistoryDao;
import com.zhang.crm.workbench.domain.Customer;
import com.zhang.crm.workbench.domain.Tran;
import com.zhang.crm.workbench.domain.TranHistory;
import com.zhang.crm.workbench.service.TranService;

import java.util.List;
import java.util.Map;

public class TranServiceImpl implements TranService {

    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);

    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);

    @Override
    public boolean save(Tran tran, String customerName) {
        boolean flag = true;

        //交易添加业务：
        //      在做添加之前，参数t里面少了一项信息，就是客户的主键，customerId
        //      先处理客户相关的需求
                    //（1）判断customerName，根据客户名称在客户表进行精确查询
                        //如果有这个客户，则取出这个客户的id。封装到t对象中
                        //如果没有这个客户，则在客户表新建一条客户信息，然后将新建的客户的id取出，封装到t对象中
                    //（2）经过以上操作后，t对象中的信息就全了，需要执行添加交易的操作
                    //（3）添加交易完毕后，需要创建一条交易历史

        Customer customer = customerDao.getCustomerByName(customerName);

        //如果customer为空。新建客户
        if(customer == null){

            customer = new Customer();

            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setContactSummary(tran.getContactSummary());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setOwner(tran.getOwner());

            //添加客户
            int customerCount = customerDao.save(customer);
            if(customerCount != 1){
                flag = false;
            }

        }

        //通过以上对于客户的处理，可以获得id值
        //将客户id封装到t对象中
        tran.setCustomerId(customer.getId());

        //添加交易
        int tranCount = tranDao.save(tran);

        if(tranCount != 1){
            flag = false;
        }

        //添加交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateBy(tran.getCreateBy());

        int tranHistoryCount = tranHistoryDao.save(tranHistory);
        if(tranHistoryCount != 1) {
            flag = false;
        }

        return flag;
    }

    @Override
    public Tran detail(String id) {

        Tran tran = tranDao.detail(id);

        return tran;
    }

    @Override
    public List<TranHistory> getHistoryListByTranId(String tranId) {
        List<TranHistory> tranHistories = tranHistoryDao.getHistoryListByTranId(tranId);

        return tranHistories;
    }

    @Override
    public boolean changeStage(Tran tran) {
        boolean flag = true;

        //该表交易阶段

        int tranCount = tranDao.changeStage(tran);
        if(tranCount != 1){
            flag = false;
        }

        //交易阶段改变后，生成一条交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setTranId(tran.getId());

        //添加交易历史
        int tranHistoryCount = tranHistoryDao.save(tranHistory);
        if(tranHistoryCount != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public PaginationVO<Tran> getTransactionList(Map<String, Object> map) {
        //取得total
        int total = tranDao.getTotalByCondition(map);

        //取得dataList
        List<Tran> dataList = tranDao.getTransactionListByCondition(map);

        PaginationVO<Tran> tranPaginationVO = new PaginationVO<>();
        tranPaginationVO.setTotal(total);
        tranPaginationVO.setDataList(dataList);

        return tranPaginationVO;
    }

    @Override
    public boolean deleteTransactionListInfo(String id) {
        boolean flag = true;

        int count = tranDao.deleteTransactionListInfo(id);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public Tran getTransactionInfoById(String id) {

        Tran tran = tranDao.getTransactionInfoById(id);

        return tran;
    }
}
