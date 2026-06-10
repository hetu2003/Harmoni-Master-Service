package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Repository.CityRepository;
import com.Harmoni.Master.Repository.StateRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/location")
@RequiredArgsConstructor
public class LocationController {

    private final StateRepository stateRepo;
    private final CityRepository  cityRepo;

    @GetMapping("/states")
    public List<Map<String, Object>> getStates() {
        return stateRepo.findAllByOrderByStateNameDesc().stream()
                .map(s -> Map.<String, Object>of("id", s.getId(), "name", s.getStateName()))
                .collect(Collectors.toList());
    }

    @GetMapping("/cities/{stateId}")
    public List<Map<String, Object>> getCitiesByState(@PathVariable Integer stateId) {
        return cityRepo.findCitiesByStateId(stateId).stream()
                .map(row -> { Map<String, Object> m = new LinkedHashMap<>(); m.put("id", row[0]); m.put("name", row[1]); return m; })
                .collect(Collectors.toList());
    }
}
