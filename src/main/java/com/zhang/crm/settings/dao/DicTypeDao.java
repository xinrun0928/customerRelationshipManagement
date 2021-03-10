package com.zhang.crm.settings.dao;


import com.zhang.crm.settings.domain.DicType;

import java.util.List;

public interface DicTypeDao {

    // 取出数据字典中的类型
    List<DicType> getTypeList();

}
