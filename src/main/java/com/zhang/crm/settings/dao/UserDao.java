package com.zhang.crm.settings.dao;

import com.zhang.crm.settings.domain.UpdatePassword;
import com.zhang.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {

    //登录校验
    User login(Map<String, String> map);

    //获取所有用户列表信息
    List<User> getUserList();

    User getUserByIdAndPassword(UpdatePassword updatePassword);

    int updatePassword(UpdatePassword updatePassword);
}
