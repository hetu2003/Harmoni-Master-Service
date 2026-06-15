package com.Harmoni.Master.EventList;

import com.Harmoni.Master.Entity.Events;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequiredArgsConstructor
public class EventListController {

    private final EventListService eventListService;

    private static final int PAGE_SIZE = 6;

    @GetMapping("/event")
    public String eventList(@RequestParam(defaultValue = "0") int page,
                            @RequestParam(required = false) Long catId,
                            Model model) {

        Page<Events> events = eventListService.getUpcomingEvents(page, PAGE_SIZE, catId);

        model.addAttribute("events",        events);
        model.addAttribute("categories",    eventListService.getAllCategories());
        model.addAttribute("selectedCatId", catId);
        model.addAttribute("totalPageList", pageNumbers(events));
        model.addAttribute("currentPage",   events.getNumber() + 1);
        model.addAttribute("totalEvents",   events.getTotalElements());
        model.addAttribute("active", "event");
        model.addAttribute("viewName", "Event/event-list");
        return "base/base";
    }

    @PostMapping("/event/search")
    public String searchEvent(@RequestParam("keyword") String keyword,
                              @RequestParam(value = "catId", required = false) Long catId,
                              @RequestParam(defaultValue = "0") int page,
                              Model model) {

        if (keyword == null || keyword.isBlank()) {
            return "redirect:/event";
        }

        Page<Events> results = eventListService.searchUpcomingEvents(keyword, catId, page, PAGE_SIZE);

        model.addAttribute("events",        results);
        model.addAttribute("categories",    eventListService.getAllCategories());
        model.addAttribute("selectedCatId", catId);
        model.addAttribute("keyword",       keyword);
        model.addAttribute("totalPageList", pageNumbers(results));
        model.addAttribute("currentPage",   results.getNumber() + 1);
        model.addAttribute("totalEvents",   results.getTotalElements());
        model.addAttribute("active", "event");
        model.addAttribute("viewName", "Event/event-list");
        return "base/base";
    }

    @GetMapping("/closed-event")
    public String closedEventList(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<Events> events = eventListService.getRecentlyClosedEvents(page, PAGE_SIZE);
        model.addAttribute("events",        events);
        model.addAttribute("totalPageList", pageNumbers(events));
        model.addAttribute("currentPage",   events.getNumber() + 1);
        model.addAttribute("totalEvents",   events.getTotalElements());
        model.addAttribute("viewName", "Event/closed-event");
        return "base/base";
    }

    private List<Integer> pageNumbers(Page<?> p) {
        return IntStream.rangeClosed(1, p.getTotalPages())
                .boxed().collect(Collectors.toList());
    }
}
