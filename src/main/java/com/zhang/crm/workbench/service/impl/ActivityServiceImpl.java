package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.settings.dao.UserDao;
import com.zhang.crm.settings.domain.DicValue;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.dao.ActityRemarkDao;
import com.zhang.crm.workbench.dao.ActivityDao;
import com.zhang.crm.workbench.domain.Activity;
import com.zhang.crm.workbench.domain.ActivityRemark;
import com.zhang.crm.workbench.service.ActivityService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {

    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    private ActityRemarkDao actityRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ActityRemarkDao.class);

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public boolean save(Activity activity) {

        boolean flag = true;

        int count = activityDao.save(activity);

        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public PaginationVO<Activity> pageList(Map<String, Object> map) {
        //取得total
        int total = activityDao.getTotalByCondition(map);
        //取得dataList
        List<Activity> dataList = activityDao.getActivityListByCondition(map);

        PaginationVO<Activity> activityPaginationVO = new PaginationVO<>();
        activityPaginationVO.setTotal(total);
        activityPaginationVO.setDataList(dataList);

        return activityPaginationVO;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;

        //先查询出需要删除的备注数量
        int queryCount = actityRemarkDao.getCountByAids(ids);

        //删除备注，受到返回影响的条数（实际删除的数量）
        int deleteCount = actityRemarkDao.deleteByAids(ids);

        if(queryCount != deleteCount){
            flag = false;
        }

        // 删除市场活动
        int count = activityDao.delete(ids);
        if(count != ids.length){
            flag = false;
        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {

        //取uList
        List<User> uList = userDao.getUserList();

        //取a
        Activity a = activityDao.getById(id);

        //将uList和a打包成map返回
        Map<String,Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("a",a);

        return map;
    }

    @Override
    public boolean update(Activity activity) {
        boolean flag = true;

        int count = activityDao.update(activity);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Activity detail(String id) {
        Activity activity = activityDao.detailById(id);
        return activity;
    }

    @Override
    public List<ActivityRemark> getRemarkListByAid(String activityId) {
        List<ActivityRemark> activityRemarks = actityRemarkDao.getRemarkListByAid(activityId);
        return activityRemarks;
    }

    @Override
    public boolean deleteRemark(String id) {
        boolean flag = true;

        int count = actityRemarkDao.deleteRemarkById(id);

        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean saveRemark(ActivityRemark activityRemark) {
        boolean flag = true;

        int count  = actityRemarkDao.saveRemark(activityRemark);

        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(ActivityRemark activityRemark) {
        boolean flag = true;

        int count = actityRemarkDao.updateRemark(activityRemark);

        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public List<Activity> getActivityListByClueId(String clueId) {
        List<Activity> aList = activityDao.getActivityListByClueId(clueId);

        return aList;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByClueId(Map<String, String> map) {

        List<Activity> aList = activityDao.getActivityListByNameAndNotByClueId(map);


        return aList;
    }

    @Override
    public List<Activity> getActivityListByName(String activityName) {
        List<Activity> aList = activityDao.getActivityListByName(activityName);
        return aList;
    }

    @Override
    public Map<String,Object> updateDetailPageActivityList(Activity activity) {

        boolean flag = true;

        int count = activityDao.updateDetailPageActivityList(activity);
        if(count != 1){
            flag = false;
        }

        String id = activity.getId();

        Activity myActivity = activityDao.detailById(id);

        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        map.put("a",myActivity);
        return map;
    }

    @Override
    public boolean deleteActivityAndActivityRemarkList(String activityId) {

        boolean flag = true;

        int remarkCount = actityRemarkDao.getCountByActivityId(activityId);

        int activityRemarkCount = actityRemarkDao.deleteRemarkById(activityId);
        if(activityRemarkCount != remarkCount){
            flag = false;
        }
//        System.out.println("remarkCount = " + remarkCount);
//        System.out.println("activityRemarkCount = " + activityRemarkCount);

        int activityCount = activityDao.deleteById(activityId);
        if(activityCount != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public List<Activity> getActivityList() {

        List<Activity> activities = activityDao.getActivityList();

        return activities;
    }

    @Override
    public List<Activity> searchActivityListByName(String name) {
        List<Activity> activities = activityDao.searchActivityListByName(name);
        return activities;
    }

    @Override
    public Activity getActivityNameByActivityId(String id) {
        Activity activity = activityDao.getActivityNameByActivityId(id);

        return activity;
    }

}
