package com.zhang.crm.workbench.service;

import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {

    List<String> getCustomerName(String name);

    PaginationVO<Customer> pageList(Map<String, Object> map);

    boolean saveCustomerInfo(Customer customer);

    Map<String, Object> getUserListAndActivity(String id);

    boolean updateCustomerList(Customer customer);

    boolean deleteCustomerListInfo(String[] ids);

    Customer showCustomerDetailInfo(String id);
}
