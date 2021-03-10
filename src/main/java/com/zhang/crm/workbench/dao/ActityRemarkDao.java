package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActityRemarkDao {
    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    int deleteRemarkById(String id);

    int saveRemark(ActivityRemark activityRemark);

    int updateRemark(ActivityRemark activityRemark);

    int getCountByActivityId(String activityId);
}
