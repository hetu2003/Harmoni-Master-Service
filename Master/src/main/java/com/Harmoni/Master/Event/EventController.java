package com.Harmoni.Master.Event;

import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/vendor/event")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('COMPANY', 'ADMIN')")
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

    @GetMapping("/add")
    public String showAddForm(@AuthenticationPrincipal UserDetails principal, Model model) {
        model.addAttribute("eventCategories", eventCategoryRepo.findAll());
        model.addAttribute("states", stateRepo.findAllByOrderByStateNameDesc());
        model.addAttribute("active", "myevent");
        return "Event/add-event";
    }

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
            @RequestParam(value = "imageFile", required = false)      MultipartFile imageFile,
            @AuthenticationPrincipal UserDetails principal,
            RedirectAttributes redirectAttrs) {

        try {
            if (!startDatetime.isAfter(LocalDateTime.now())) {
                redirectAttrs.addFlashAttribute("errorMessage", "Start date must be in the future.");
                return "redirect:/vendor/event/add";
            }
            if (!endDatetime.isAfter(startDatetime)) {
                redirectAttrs.addFlashAttribute("errorMessage", "End datetime must be after start datetime.");
                return "redirect:/vendor/event/add";
            }
            if (workhandCategoryIds.size() != workhandNumbers.size() || workhandCategoryIds.size() != prices.size()) {
                redirectAttrs.addFlashAttribute("errorMessage", "Workhand slot data is inconsistent.");
                return "redirect:/vendor/event/add";
            }
            Users company = getCompany(principal);
            eventService.createEvent(categoryId, subcategoryId, eventName,
                    startDatetime, endDatetime, streetAddress, stateId, cityId,
                    description, workhandCategoryIds, workhandNumbers, prices, company, imageFile);
            redirectAttrs.addFlashAttribute("successMessage", "Event created successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Something went wrong: " + e.getMessage());
        }
        return "redirect:/vendor/event/add";
    }

    // ─────────────────────────────────────────────────────────────
    // UPDATE
    // ─────────────────────────────────────────────────────────────

    @GetMapping("/{eventId}/edit")
    public String showEditForm(@PathVariable Long eventId,
                               @AuthenticationPrincipal UserDetails principal,
                               Model model) {

        Events event = findEvent(eventId);
        List<EventWorkhand> slots = eventWorkhnadRepo.findByEvent(event.getId().intValue());

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        model.addAttribute("event", event);
        model.addAttribute("slots", slots);
        model.addAttribute("startDatetimeStr", event.getStartDatetime().format(dtf));
        model.addAttribute("endDatetimeStr",   event.getEndDatetime().format(dtf));
        model.addAttribute("eventCategories", eventCategoryRepo.findAll());
        model.addAttribute("eventSubcategories",
                eventSubcategoryRepo.findByEventCategoryEventCategoryId(
                        event.getEventCategory() != null
                                ? event.getEventCategory().getEventCategoryId()
                                : null));
        model.addAttribute("states", stateRepo.findAllByOrderByStateNameDesc());
        model.addAttribute("cities",
                event.getState() != null
                        ? cityRepo.findByState(event.getState())
                        : List.of());
        model.addAttribute("active", "myevent");
        return "Event/edit-event";
    }

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
            @RequestParam(value = "imageFile", required = false)      MultipartFile imageFile,
            @AuthenticationPrincipal UserDetails principal,
            RedirectAttributes redirectAttrs) {

        try {
            if (!endDatetime.isAfter(startDatetime)) {
                redirectAttrs.addFlashAttribute("errorMessage", "End datetime must be after start datetime.");
                return "redirect:/vendor/event/" + eventId + "/edit";
            }
            Users company = getCompany(principal);
            eventService.updateEvent(eventId, categoryId, subcategoryId, eventName,
                    startDatetime, endDatetime, streetAddress, stateId, cityId,
                    description, workhandCategoryIds, workhandNumbers, prices, company, imageFile);
            redirectAttrs.addFlashAttribute("successMessage", "Event updated successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Update failed: " + e.getMessage());
        }
        return "redirect:/vendor/event/" + eventId + "/edit";
    }

    // ─────────────────────────────────────────────────────────────
    // DELETE (soft)
    // ─────────────────────────────────────────────────────────────

    @PostMapping("/{eventId}/delete")
    public String deleteEvent(@PathVariable Long eventId,
                              @AuthenticationPrincipal UserDetails principal,
                              RedirectAttributes redirectAttrs) {
        try {
            Users company = getCompany(principal);
            eventService.softDeleteEvent(eventId, company);
            redirectAttrs.addFlashAttribute("successMessage", "Event deleted successfully.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Delete failed: " + e.getMessage());
        }
        return "redirect:/vendor/my-events";
    }

    private Users getCompany(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found"));
    }

    private Events findEvent(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }
}
