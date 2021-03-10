package com.zhang.crm.workbench.service;

import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsService {
    PaginationVO<Contacts> pageList(Map<String, Object> map);

    boolean saveContact(Contacts contacts, String customerName);

    Map<String, Object> getUserListAndContacts(String id);

    boolean updateContactsList(Contacts contacts, String customerName);

    boolean deleteContactsListInfo(String[] ids);

    Contacts detail(String id);

    List<Contacts> searchContactsList(String name);

    Contacts getContactsNameByContactsId(String id);
}
