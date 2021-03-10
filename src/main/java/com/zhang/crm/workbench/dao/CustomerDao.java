package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {

    Customer getCustomerByName(String company);

    int save(Customer customer);

    List<String> getCustomerName(String name);

    int getTotalByCondition(Map<String, Object> map);

    List<Customer> getCustomerListByCondition(Map<String, Object> map);

    int saveCustomerInfo(Customer customer);

    Customer getCustomerInfoById(String id);

    int updateCustomerList(Customer customer);

    int deleteCustomerListInfo(String[] ids);

    Customer showCustomerDetailInfo(String id);

    Customer getCustomerIdByCustomerName(String customerName);
}
