package com.Harmoni.Master.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * AJAX endpoints returning JSON for dynamic dropdowns.
 * Mirrors Django's get_city() and get_subcat() views.
 */
@RestController
@RequiredArgsConstructor
public class CommonController {

    private final CityRepository cityRepo;
    private final EventSubcategoryRepository subcategoryRepo;

    /** GET /get-city?state_id=1 */
    @GetMapping("/get-city")
    public ResponseEntity<List<Map<String, Object>>> getCities(@RequestParam("state_id") Long stateId) {
        List<City> cities = cityRepo.findByStateStateId(stateId);
        List<Map<String, Object>> result = cities.stream()
                .map(c -> Map.<String, Object>of("id", c.getCityId(), "name", c.getCityName()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(result);
    }

    /** GET /vendor/get-subcat?cat_id=1 */
    @GetMapping("/vendor/get-subcat")
    public ResponseEntity<List<Map<String, Object>>> getSubcategories(@RequestParam("cat_id") Long catId) {
        List<EventSubcategory> subs = subcategoryRepo.findByEventCategoryEventCategoryId(catId);
        List<Map<String, Object>> result = subs.stream()
                .map(s -> Map.<String, Object>of("id", s.getEventSubcategoryId(), "name", s.getEventSubcategoryName()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(result);
    }
}
