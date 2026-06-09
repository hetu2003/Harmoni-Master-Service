package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Common.CommonService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class CommonController {

    private final CommonService commonService;

    @GetMapping("/get-city")
    public ResponseEntity<List<Map<String, Object>>> getCities(@RequestParam("state_id") Long stateId) {
        return ResponseEntity.ok(commonService.getCitiesByStateId(stateId));
    }

    @GetMapping("/vendor/get-subcat")
    public ResponseEntity<List<Map<String, Object>>> getSubcategories(@RequestParam("cat_id") Long catId) {
        return ResponseEntity.ok(commonService.getSubcategoriesByCategoryId(catId));
    }
}
