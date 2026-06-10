package com.Harmoni.Master.Common;

import com.Harmoni.Master.Entity.EventSubcategory;
import com.Harmoni.Master.Repository.CityRepository;
import com.Harmoni.Master.Repository.EventSubcategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommonServiceImpl implements CommonService {

    private final CityRepository cityRepo;
    private final EventSubcategoryRepository subcategoryRepo;

    @Override
    public List<Map<String, Object>> getCitiesByStateId(Long stateId) {
        return cityRepo.findCitiesByStateId(Math.toIntExact(stateId)).stream()
                .map(row -> { Map<String, Object> m = new LinkedHashMap<>(); m.put("id", row[0]); m.put("name", row[1]); return m; })
                .collect(Collectors.toList());
    }

    @Override
    public List<Map<String, Object>> getSubcategoriesByCategoryId(Long catId) {
        List<EventSubcategory> subs = subcategoryRepo.findByEventCategoryEventCategoryId(catId);
        return subs.stream()
                .map(s -> Map.<String, Object>of("id", s.getEventSubcategoryId(), "name", s.getEventSubcategoryName()))
                .collect(Collectors.toList());
    }
}
