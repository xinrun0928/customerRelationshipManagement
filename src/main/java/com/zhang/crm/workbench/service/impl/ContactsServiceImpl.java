package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.settings.dao.UserDao;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.dao.ContactsDao;
import com.zhang.crm.workbench.dao.ContactsRemarkDao;
import com.zhang.crm.workbench.dao.CustomerDao;
import com.zhang.crm.workbench.dao.CustomerRemarkDao;
import com.zhang.crm.workbench.domain.Contacts;
import com.zhang.crm.workbench.domain.Customer;
import com.zhang.crm.workbench.service.ContactsService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ContactsServiceImpl implements ContactsService {

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    private ContactsDao contactsDao = SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);
    private ContactsRemarkDao contactsRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkDao.class);

    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    @Override
    public PaginationVO<Contacts> pageList(Map<String, Object> map) {

        int total = contactsDao.getTotalByCondition(map);

        List<Contacts> dataList = contactsDao.getContactsListByCondition(map);

        PaginationVO<Contacts> contactsPaginationVO = new PaginationVO<>();
        contactsPaginationVO.setTotal(total);
        contactsPaginationVO.setDataList(dataList);

        return contactsPaginationVO;
    }

    @Override
    public boolean saveContact(Contacts contacts, String customerName) {

        boolean flag = true;

        Customer customer = customerDao.getCustomerByName(customerName);
        if(customer == null){

            customer = new Customer();

            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(contacts.getOwner());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setContactSummary(contacts.getContactSummary());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(contacts.getCreateBy());
            customer.setName(customerName);
            customer.setDescription(contacts.getDescription());
            customer.setAddress(contacts.getAddress());
            customer.setPhone(contacts.getMphone());

            int customerCount = customerDao.save(customer);
            if(customerCount != 1){
                flag = false;
            }
        }

        contacts.setCustomerId(customer.getId());

        int contactCount = contactsDao.saveContact(contacts);
        if(contactCount != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndContacts(String id) {

        List<User> uList = userDao.getUserList();

        Contacts contacts = contactsDao.getById(id);

        Map<String, Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("c",contacts);

        return map;
    }

    @Override
    public boolean updateContactsList(Contacts contacts, String customerName) {
        boolean flag = true;

        Customer customer = customerDao.getCustomerIdByCustomerName(customerName);

//        System.out.println("customer = " + customer);

        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(contacts.getOwner());
            customer.setName(customerName);
            customer.setCreateBy(contacts.getEditBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setContactSummary(contacts.getContactSummary());
            customer.setAddress(contacts.getAddress());
            customer.setDescription(contacts.getDescription());

            int customerCount = customerDao.save(customer);
            if(customerCount != 1){
                flag = false;
            }
        }

        String customerId = customer.getId();
        contacts.setCustomerId(customerId);

        int count = contactsDao.updateContactsList(contacts);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean deleteContactsListInfo(String[] ids) {

        boolean flag = true;

        int queryCount = contactsDao.getByIds(ids);
        if(queryCount != ids.length){
            flag = false;
        }

        int count = contactsDao.deleteContactsListInfo(ids);
        if(count != queryCount){
            flag = false;
        }

        return flag;
    }

    @Override
    public Contacts detail(String id) {
        Contacts contacts = contactsDao.detail(id);

        return contacts;
    }

    @Override
    public List<Contacts> searchContactsList(String name) {
        List<Contacts> contacts = contactsDao.searchContactsList(name);

        return contacts;
    }

    @Override
    public Contacts getContactsNameByContactsId(String id) {
        Contacts contacts = contactsDao.getContactsNameByContactsId(id);
        return contacts;
    }

}
