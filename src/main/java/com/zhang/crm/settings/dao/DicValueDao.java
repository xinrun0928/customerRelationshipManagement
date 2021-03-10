package com.zhang.crm.settings.dao;

import com.zhang.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {

    //通过code查询出所有对应的数据字典值，并根据orderNo进行升序排序
    List<DicValue> getListByCode(String code);

}
