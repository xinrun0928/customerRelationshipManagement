package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.settings.dao.UserDao;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.dao.CustomerDao;
import com.zhang.crm.workbench.dao.CustomerRemarkDao;
import com.zhang.crm.workbench.domain.Customer;
import com.zhang.crm.workbench.domain.CustomerRemark;
import com.zhang.crm.workbench.service.CustomerService;
import javafx.scene.control.Pagination;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerServiceImpl implements CustomerService {

    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public List<String> getCustomerName(String name) {
        List<String> sList = customerDao.getCustomerName(name);
        return sList;
    }

    @Override
    public PaginationVO<Customer> pageList(Map<String, Object> map) {

        //计算total
        int total = customerDao.getTotalByCondition(map);

        //取得dataList
        List<Customer> dataList = customerDao.getCustomerListByCondition(map);

        PaginationVO<Customer> customerPaginationVO = new PaginationVO<>();
        customerPaginationVO.setTotal(total);
        customerPaginationVO.setDataList(dataList);

        return customerPaginationVO;
    }

    @Override
    public boolean saveCustomerInfo(Customer customer) {
        boolean flag = true;

        int count = customerDao.saveCustomerInfo(customer);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {

        List<User> uList = userDao.getUserList();

        Customer customer = customerDao.getCustomerInfoById(id);

        Map<String, Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("c",customer);

        return map;
    }

    @Override
    public boolean updateCustomerList(Customer customer) {
        boolean flag = true;

        int count = customerDao.updateCustomerList(customer);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean deleteCustomerListInfo(String[] ids) {
        boolean flag = true;

        int count = customerDao.deleteCustomerListInfo(ids);
        if(count != ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Customer showCustomerDetailInfo(String id) {

        Customer customer = customerDao.showCustomerDetailInfo(id);

        return customer;
    }
}
