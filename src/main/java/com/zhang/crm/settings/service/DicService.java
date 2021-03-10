package com.zhang.crm.settings.service;

import com.zhang.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {

    //
    Map<String, List<DicValue>> getAllInfo();
}
