package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    List<ClueRemark> getListByClueId(String clueId);

    int delete(ClueRemark clueRemark);

    int getRemarkCountByClueids(String[] ids);

    int deleteByClueids(String[] ids);

    int deleteRemarkInfo(String id);

    int saveRemarkInfo(ClueRemark clueRemark);

    List<ClueRemark> getRemarkListByClueId(String clueId);
}
