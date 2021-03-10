package com.zhang.crm.workbench.dao;


import com.zhang.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueDao {

    int save(Clue clue);

    Clue detail(String id);

    Clue getById(String clueId);

    int delete(String clueId);

    int getTotalByCondition(Map<String, Object> map);

    List<Clue> getClueListByCondition(Map<String, Object> map);

    int deleteClue(String[] ids);

    int updateClueList(Clue clue);
}
