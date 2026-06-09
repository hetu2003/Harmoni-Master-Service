package com.Harmoni.Master.Common;

import com.Harmoni.Master.Entity.City;
import com.Harmoni.Master.Entity.EventSubcategory;
import java.util.List;
import java.util.Map;

public interface CommonService {
    List<Map<String, Object>> getCitiesByStateId(Long stateId);
    List<Map<String, Object>> getSubcategoriesByCategoryId(Long catId);
}
