package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Full CRUD for Events — vendor side.
 *
 * Routes:
 *   GET  /vendor/event/add              → show add form
 *   POST /vendor/event/add              → create event + workhand slots
 *   GET  /vendor/event/{id}/edit        → show edit form (pre-populated)
 *   POST /vendor/event/{id}/edit        → update event + replace workhand slots
 *   POST /vendor/event/{id}/delete      → soft-delete event
 *
 * Mirrors Django's add_event() in company/views.py plus adds Update & Delete.
 */
@Controller
@RequestMapping("/vendor/event")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;
    private final EventRepository eventRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final EventCategoryRepository eventCategoryRepo;
    private final EventSubcategoryRepository eventSubcategoryRepo;
    private final StateRepository stateRepo;
    private final CityRepository cityRepo;
    private final UserRepository userRepo;

    // ─────────────────────────────────────────────────────────────
    // CREATE
    // ─────────────────────────────────────────────────────────────

    /** GET /vendor/event/add */
    @GetMapping("/add")
    public String showAddForm(@AuthenticationPrincipal UserDetails principal, Model model) {
        model.addAttribute("eventCategories", eventCategoryRepo.findAll());
        model.addAttribute("states", stateRepo.findAllByOrderByStateNameDesc());
        model.addAttribute("active", "myevent");
        model.addAttribute("formAction", "/vendor/event/add");
        model.addAttribute("pageTitle", "Add New Event");
        return "vendor/add-event";
    }

    /** POST /vendor/event/add */
    @PostMapping("/add")
    public String createEvent(
            @RequestParam("cat_id")                                   Long categoryId,
            @RequestParam("subcat_id")                                Long subcategoryId,
            @RequestParam("event_name")                               String eventName,
            @RequestParam("start_datetime")
            @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")          LocalDateTime startDatetime,
            @RequestParam("end_datetime")
            @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")          LocalDateTime endDatetime,
            @RequestParam("street_address")                           String streetAddress,
            @RequestParam("state_id")                                 Long stateId,
            @RequestParam("city_id")                                  Long cityId,
            @RequestParam("description")                              String description,
            @RequestParam("workhand_category_ids")                    List<Integer> workhandCategoryIds,
            @RequestParam("workhand_numbers")                         List<Integer> workhandNumbers,
            @RequestParam("prices")                                   List<BigDecimal> prices,
            @AuthenticationPrincipal UserDetails principal,
            RedirectAttributes redirectAttrs) {

        try {
            // Validate dates
            if (!startDatetime.isAfter(LocalDateTime.now())) {
                redirectAttrs.addFlashAttribute("errorMessage",
                        "Start date must be in the future.");
                return "redirect:/vendor/event/add";
            }
            if (!endDatetime.isAfter(startDatetime)) {
                redirectAttrs.addFlashAttribute("errorMessage",
                        "End datetime must be after start datetime.");
                return "redirect:/vendor/event/add";
            }
            if (workhandCategoryIds.size() != workhandNumbers.size()
                    || workhandCategoryIds.size() != prices.size()) {
                redirectAttrs.addFlashAttribute("errorMessage",
                        "Workhand slot data is inconsistent. Please re-enter.");
                return "redirect:/vendor/event/add";
            }

            Users company = getCompany(principal);
            eventService.createEvent(categoryId, subcategoryId, eventName,
                    startDatetime, endDatetime, streetAddress, stateId, cityId,
                    description, workhandCategoryIds, workhandNumbers, prices, company);

            redirectAttrs.addFlashAttribute("successMessage", "Event created successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage",
                    "Something went wrong: " + e.getMessage());
        }
        return "redirect:/vendor/event/add";
    }

    // ─────────────────────────────────────────────────────────────
    // UPDATE
    // ─────────────────────────────────────────────────────────────

    /** GET /vendor/event/{eventId}/edit */
    @GetMapping("/{eventId}/edit")
    public String showEditForm(@PathVariable Long eventId,
                               @AuthenticationPrincipal UserDetails principal,
                               Model model) {

        Events event = findEvent(eventId);
        List<EventWorkhand> slots = eventWorkhnadRepo.findByEvent(event);

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        model.addAttribute("event", event);
        model.addAttribute("slots", slots);
        model.addAttribute("startDatetimeStr", event.getStartDatetime().format(dtf));
        model.addAttribute("endDatetimeStr",   event.getEndDatetime().format(dtf));
        model.addAttribute("eventCategories", eventCategoryRepo.findAll());
        model.addAttribute("eventSubcategories",
                eventSubcategoryRepo.findByEventCategory(event.getEventCategory()));
        model.addAttribute("states", stateRepo.findAllByOrderByStateNameDesc());
        model.addAttribute("cities", cityRepo.findByState(event.getState()));
        model.addAttribute("active", "myevent");
        return "vendor/edit-event";
    }

    /** POST /vendor/event/{eventId}/edit */
    @PostMapping("/{eventId}/edit")
    public String updateEvent(
            @PathVariable Long eventId,
            @RequestParam("cat_id")                                   Long categoryId,
            @RequestParam("subcat_id")                                Long subcategoryId,
            @RequestParam("event_name")                               String eventName,
            @RequestParam("start_datetime")
            @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")          LocalDateTime startDatetime,
            @RequestParam("end_datetime")
            @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")          LocalDateTime endDatetime,
            @RequestParam("street_address")                           String streetAddress,
            @RequestParam("state_id")                                 Long stateId,
            @RequestParam("city_id")                                  Long cityId,
            @RequestParam("description")                              String description,
            @RequestParam("workhand_category_ids")                    List<Integer> workhandCategoryIds,
            @RequestParam("workhand_numbers")                         List<Integer> workhandNumbers,
            @RequestParam("prices")                                   List<BigDecimal> prices,
            @AuthenticationPrincipal UserDetails principal,
            RedirectAttributes redirectAttrs) {

        try {
            if (!endDatetime.isAfter(startDatetime)) {
                redirectAttrs.addFlashAttribute("errorMessage",
                        "End datetime must be after start datetime.");
                return "redirect:/vendor/event/" + eventId + "/edit";
            }

            Users company = getCompany(principal);
            eventService.updateEvent(eventId, categoryId, subcategoryId, eventName,
                    startDatetime, endDatetime, streetAddress, stateId, cityId,
                    description, workhandCategoryIds, workhandNumbers, prices, company);

            redirectAttrs.addFlashAttribute("successMessage", "Event updated successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage",
                    "Update failed: " + e.getMessage());
        }
        return "redirect:/vendor/event/" + eventId + "/edit";
    }

    // ─────────────────────────────────────────────────────────────
    // DELETE (soft)
    // ─────────────────────────────────────────────────────────────

    /** POST /vendor/event/{eventId}/delete */
    @PostMapping("/{eventId}/delete")
    public String deleteEvent(@PathVariable Long eventId,
                              @AuthenticationPrincipal UserDetails principal,
                              RedirectAttributes redirectAttrs) {
        try {
            Users company = getCompany(principal);
            eventService.softDeleteEvent(eventId, company);
            redirectAttrs.addFlashAttribute("successMessage", "Event deleted successfully.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage",
                    "Delete failed: " + e.getMessage());
        }
        return "redirect:/vendor/my-events";
    }

    // ─────────────────────────────────────────────────────────────
    // Helpers
    // ─────────────────────────────────────────────────────────────

    private Users getCompany(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found"));
    }

    private Events findEvent(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }
}
