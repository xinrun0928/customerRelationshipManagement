package com.zhang.crm.settings.service;

import com.zhang.crm.exception.LoginException;
import com.zhang.crm.exception.UpdatePasswordException;
import com.zhang.crm.settings.domain.UpdatePassword;
import com.zhang.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    //登录验证功能组装
    User login(String loginAct, String loginPwd, String ipAddress) throws LoginException;

    //获得所有用户对象数组
    List<User> getAllUserTableOfNameInfoList();

    User updatePassword(UpdatePassword updatePassword) throws UpdatePasswordException;

}
