package com.Harmoni.Master.Common;

import com.Harmoni.Master.Entity.City;
import com.Harmoni.Master.Entity.EventSubcategory;
import com.Harmoni.Master.Repository.CityRepository;
import com.Harmoni.Master.Repository.EventSubcategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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
        List<City> cities = cityRepo.findByStateStateId(stateId);
        return cities.stream()
                .map(c -> Map.<String, Object>of("id", c.getId(), "name", c.getCityName()))
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
