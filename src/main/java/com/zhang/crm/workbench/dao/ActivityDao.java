package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
    int save(Activity activity);

    int getTotalByCondition(Map<String, Object> map);

    List<Activity> getActivityListByCondition(Map<String, Object> map);

    int delete(String[] ids);

    Activity getById(String id);

    int update(Activity activity);

    Activity detailById(String id);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, String> map);

    List<Activity> getActivityListByName(String activityName);

    int updateDetailPageActivityList(Activity activity);

    int deleteById(String activityId);

    List<Activity> getActivityList();

    List<Activity> searchActivityListByName(String name);

    Activity getActivityNameByActivityId(String id);
}
