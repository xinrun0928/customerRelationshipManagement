package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {

    int save(Contacts contacts);

    int getTotalByCondition(Map<String, Object> map);

    List<Contacts> getContactsListByCondition(Map<String, Object> map);

    int saveContact(Contacts contacts);

    Contacts getById(String id);

    int updateContactsList(Contacts contacts);

    int getByIds(String[] ids);

    int deleteContactsListInfo(String[] ids);

    Contacts detail(String id);

    List<Contacts> searchContactsList(String name);

    Contacts getContactsNameByContactsId(String id);
}
