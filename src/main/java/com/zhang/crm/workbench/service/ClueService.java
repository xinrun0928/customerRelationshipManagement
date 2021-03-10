package com.zhang.crm.workbench.service;

import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.domain.Clue;
import com.zhang.crm.workbench.domain.ClueRemark;
import com.zhang.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface ClueService {
    boolean save(Clue clue);

    Clue detail(String id);

    boolean unbund(String id);

    boolean bund(String clueId, String[] activityIds);


    boolean convert(String clueId, Tran tran, String createBy);

    PaginationVO<Clue> pageList(Map<String, Object> map);

    boolean deleteClueListInfo(String[] ids);

    Map<String, Object> getUserListAndClue(String id);

    boolean updateClueList(Clue clue);

    boolean deleteRemarkInfo(String id);

    boolean saveRemarkInfo(ClueRemark clueRemark);

    List<ClueRemark> getRemarkListByClueId(String clueId);
}
