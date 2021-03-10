package com.zhang.crm.workbench.service;

import com.zhang.crm.settings.domain.DicValue;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Activity;
import com.zhang.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    boolean save(Activity activity);

    PaginationVO<Activity> pageList(Map<String, Object> map);

    boolean delete(String[] ids);

    Map<String, Object> getUserListAndActivity(String id);

    boolean update(Activity activity);

    Activity detail(String id);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    boolean deleteRemark(String id);

    boolean saveRemark(ActivityRemark activityRemark);

    boolean updateRemark(ActivityRemark activityRemark);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, String> map);

    List<Activity> getActivityListByName(String activityName);

    Map<String,Object> updateDetailPageActivityList(Activity activity);

    boolean deleteActivityAndActivityRemarkList(String activityId);

    List<Activity> getActivityList();

    List<Activity> searchActivityListByName(String name);

    Activity getActivityNameByActivityId(String id);
}
