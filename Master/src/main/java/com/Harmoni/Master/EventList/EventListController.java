package com.Harmoni.Master.EventList;

import com.Harmoni.Master.Entity.EventCategory;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Repository.EventCategoryRepository;
import com.Harmoni.Master.Repository.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Public event listing with keyword search and category filter.
 * Mirrors Django's event() and search_event() views.
 */
@Controller
@RequiredArgsConstructor
public class EventListController {

    private final EventRepository eventRepo;
    private final EventCategoryRepository eventCategoryRepo;

    private static final int PAGE_SIZE = 6;

    // ── Browse upcoming events ────────────────────────────────────────────────

    @GetMapping("/event")
    public String eventList(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(required = false) Long catId,
                            Model model) {

        LocalDateTime now = LocalDateTime.now();
        Pageable pageable = PageRequest.of(page, PAGE_SIZE, Sort.by("startDatetime").ascending());
        Page<Events> events;

        if (catId != null) {
            EventCategory cat = eventCategoryRepo.findById(catId).orElse(null);
            events = (cat != null)
                    ? eventRepo.findByStartDatetimeAfterAndEventCategoryOrderByStartDatetime(now, cat, pageable)
                    : eventRepo.findByStartDatetimeAfterOrderByStartDatetime(now, pageable);
        } else {
            events = eventRepo.findByStartDatetimeAfterOrderByStartDatetime(now, pageable);
        }

        List<Integer> pageNumbers = IntStream.rangeClosed(1, events.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("events",       events);
        model.addAttribute("categories",   eventCategoryRepo.findAll());
        model.addAttribute("selectedCatId", catId);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage",  events.getNumber() + 1);
        model.addAttribute("totalEvents",  events.getTotalElements());
        model.addAttribute("active", "event");
        return "user/event-list";
    }

    // ── Keyword search ────────────────────────────────────────────────────────

    @PostMapping("/event/search")
    public String searchEvent(@RequestParam("keyword") String keyword,
                              @RequestParam(value = "catId", required = false) Long catId,
                              Model model) {

        LocalDateTime now = LocalDateTime.now();

        if (keyword == null || keyword.isBlank()) {
            return "redirect:/event";
        }

        List<Events> results = eventRepo.searchByKeyword(keyword.trim())
                .stream()
                .filter(e -> e.getStartDatetime().isAfter(now))
                .collect(Collectors.toList());

        if (catId != null) {
            results = results.stream()
                    .filter(e -> e.getEventCategory().getEventCategoryId().equals(catId))
                    .collect(Collectors.toList());
        }

        model.addAttribute("events",       results);
        model.addAttribute("categories",   eventCategoryRepo.findAll());
        model.addAttribute("selectedCatId", catId);
        model.addAttribute("keyword",      keyword);
        model.addAttribute("totalEvents",  results.size());
        model.addAttribute("active", "event");
        return "user/event-list";
    }
}
