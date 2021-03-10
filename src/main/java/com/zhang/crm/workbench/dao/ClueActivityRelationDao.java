package com.zhang.crm.workbench.dao;

import com.zhang.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueActivityRelationDao {


    int unbund(String id);

    int bund(ClueActivityRelation clueActivityRelation);

    List<ClueActivityRelation> getListClueId(String clueId);

    int delete(ClueActivityRelation clueActivityRelation);

    int getRelationCountByClueIds(String[] ids);

    int deleteRelationByClueIds(String[] ids);
}
