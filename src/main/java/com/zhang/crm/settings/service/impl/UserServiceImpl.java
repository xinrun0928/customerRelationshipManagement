package com.zhang.crm.settings.service.impl;

import com.zhang.crm.exception.LoginException;
import com.zhang.crm.exception.UpdatePasswordException;
import com.zhang.crm.settings.dao.UserDao;
import com.zhang.crm.settings.domain.UpdatePassword;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.settings.service.UserService;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    public User login(String loginAct, String loginPwd, String ipAddress) throws LoginException {

        //将用户名和密码封装到map集合中，进行数据库登录校验
        Map<String, String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        //后台校验
        User user = userDao.login(map);

        //如果user为空，那么说明没有此用户
        if(user == null){
            throw new LoginException("账号或密码错误");
        }

        //执行到此处，则说明账号密码正确

        //验证失效时间，将账号失效时间与当前时间比较
        String expireTime = user.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();

        //如果返回小于0的值，则说明失效时间已过，返回大于0的值，说明失效时间还未到
        if(expireTime.compareTo(currentTime) < 0){
            throw new LoginException("该账号已失效（请续费）");
        }

        String lockState = user.getLockState();
        //判断账号的锁定状态，如果为0，则说明账号已锁定，如果为1，说明该账号正常
        if("0".equals(lockState)){
            throw new LoginException("该账号已锁定（请联系管理员）");
        }

        //判断ip地址
        String allowTps = user.getAllowIps();
        //将当前登录的ip地址与后台的比较，如果后台的ip包含当前的ip，则表示此IP下登录正常，反之失败
        if(!allowTps.contains(ipAddress)){
            throw new LoginException("此IP地址受限");
        }

        //执行到此处，说明该用户验证通过
        return user;
    }

    @Override
    public List<User> getAllUserTableOfNameInfoList() {

        List<User> users = userDao.getUserList();

        return users;
    }

    @Override
    public User updatePassword(UpdatePassword updatePassword) throws UpdatePasswordException {

        User user = userDao.getUserByIdAndPassword(updatePassword);
        if(user != null){

            int updateCount = userDao.updatePassword(updatePassword);
            if(updateCount != 1){
                throw new UpdatePasswordException("更新密码失败，请重试");
            }
        }else {
            throw new UpdatePasswordException("原密码输入有误，请重新输入");
        }

        return user;
    }

}
