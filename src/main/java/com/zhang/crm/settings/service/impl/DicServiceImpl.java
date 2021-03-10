package com.zhang.crm.settings.service.impl;

import com.zhang.crm.settings.dao.DicTypeDao;
import com.zhang.crm.settings.dao.DicValueDao;
import com.zhang.crm.settings.domain.DicType;
import com.zhang.crm.settings.domain.DicValue;
import com.zhang.crm.settings.service.DicService;
import com.zhang.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DicServiceImpl implements DicService {

    private DicTypeDao dicTypeDao = SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    private DicValueDao dicValueDao = SqlSessionUtil.getSqlSession().getMapper(DicValueDao.class);

    @Override
    public Map<String, List<DicValue>> getAllInfo() {

        Map<String, List<DicValue>> map = new HashMap<>();

        //从数据库将数据字典的    “类型”    取出
        List<DicType> dicTypeList = dicTypeDao.getTypeList();

        //遍历数据字典类型，从中取出每项数据字典对应的  “值”
        for(DicType dicType :dicTypeList){

            //取出数据字典的code值
            String code = dicType.getCode();

            //通过数据字典的类型，分别取得所有对应的数据字典值数组
            List<DicValue> dicValueList = dicValueDao.getListByCode(code);

            //每遍历一次，就将数据字典类型和数据字典值数组存储到map集合中
            map.put(code,dicValueList);
        }

        return map;
    }
}
