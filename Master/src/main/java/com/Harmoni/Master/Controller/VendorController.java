package com.Harmoni.Master.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Company/Vendor dashboard.
 * Routes use event_id and user_id (no slug column in schema).
 * Mirrors Django's company/views.py.
 */
@Controller
@RequestMapping("/vendor")
@RequiredArgsConstructor
public class VendorController {

    private final EventRepository eventRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final EventRegistrationRepository registrationRepo;
    private final EventSubcategoryRepository eventSubcategoryRepo;
    private final UserRepository userRepo;
    private final EventRegistrationService registrationService;

    // ─────────────────────────────────────────────
    // My Events list
    // ─────────────────────────────────────────────

    @GetMapping("/my-events")
    public String myEvents(@RequestParam(value = "page", defaultValue = "0") int page,
                           @AuthenticationPrincipal UserDetails principal,
                           Model model) {

        User company = getCompany(principal);
        Pageable pageable = PageRequest.of(page, 2);
        Page<Event> eventPage = eventRepo.findByCompanyOrderByStartDatetimeDesc(company, pageable);

        List<Integer> pageNumbers = IntStream.rangeClosed(1, eventPage.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("active", "myevent");
        model.addAttribute("events", eventPage);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage", eventPage.getNumber() + 1);
        model.addAttribute("eventCount", eventPage.getTotalElements());
        model.addAttribute("totalEvent", eventRepo.findByCompanyOrderByStartDatetimeDesc(company).size());
        return "vendor/company-events";
    }

    @PostMapping("/my-events/search")
    public String searchMyEvents(@RequestParam("search") String search,
                                 @AuthenticationPrincipal UserDetails principal,
                                 Model model) {
        User company = getCompany(principal);
        if ("all".equals(search)) return "redirect:/vendor/my-events";

        EventSubcategory sub = eventSubcategoryRepo.findById(Long.parseLong(search)).orElse(null);
        List<Event> events = (sub != null)
                ? eventRepo.findByCompanyAndEventSubcategoryOrderByStartDatetime(company, sub)
                : List.of();

        model.addAttribute("active", "myevent");
        model.addAttribute("events", events);
        model.addAttribute("eventCount", events.size());
        model.addAttribute("totalEvent", eventRepo.findByCompanyOrderByStartDatetimeDesc(company).size());
        return "vendor/company-events";
    }

    // ─────────────────────────────────────────────
    // Workhand Requests (pending)
    // ─────────────────────────────────────────────

    @GetMapping("/workhand-requests/{eventId}")
    public String workhnadRequests(@PathVariable Long eventId, Model model) {
        Event event = findEvent(eventId);
        List<EventRegistration> requests = registrationRepo.findByEventOrderByEventWorkhnadIdDesc(event);

        model.addAttribute("active", "myevent");
        model.addAttribute("event", event);
        model.addAttribute("workhnadRequests", requests);
        model.addAttribute("eventWorkhands", eventWorkhnadRepo.findByEvent(event));
        return "vendor/request-approve";
    }

    @GetMapping("/request-approve")
    public String approveRequest(@RequestParam("registrationId") Long registrationId,
                                 RedirectAttributes redirectAttrs) {

        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found"));
        Long eventId = reg.getEvent().getEventId();

        String error = registrationService.approveRegistration(registrationId);
        if (error != null) redirectAttrs.addFlashAttribute("errorMessage", error);

        return "redirect:/vendor/workhand-requests/" + eventId;
    }

    // ─────────────────────────────────────────────
    // Approved Requests
    // ─────────────────────────────────────────────

    @GetMapping("/approved-requests/{eventId}")
    public String approvedRequests(@PathVariable Long eventId, Model model) {
        Event event = findEvent(eventId);
        List<EventRegistration> approved =
                registrationRepo.findByEventAndRegistrationStatusTrueOrderByEventWorkhandEventWorkhnadIdAsc(event);

        model.addAttribute("active", "myevent");
        model.addAttribute("event", event);
        model.addAttribute("approvedRequests", approved);
        return "vendor/approved-requests";
    }

    @PostMapping("/approved-requests/{eventId}/revoke")
    public String revokeApproval(@PathVariable Long eventId,
                                 @RequestParam("registrationId") Long registrationId) {
        registrationService.revokeApproval(registrationId);
        return "redirect:/vendor/approved-requests/" + eventId;
    }

    // ─────────────────────────────────────────────
    // Payment
    // ─────────────────────────────────────────────

    @GetMapping("/payment/{eventId}")
    public String payment(@PathVariable Long eventId, Model model) {
        Event event = findEvent(eventId);
        List<EventRegistration> approved = registrationRepo.findByEventAndRegistrationStatusTrue(event);

        int totalPrice = approved.stream()
                .mapToInt(r -> r.getEventWorkhand().getPrice().intValue())
                .sum();

        model.addAttribute("active", "myevent");
        model.addAttribute("event", event);
        model.addAttribute("workhands", approved);
        model.addAttribute("totalPrice", totalPrice);
        return "vendor/payment";
    }

    @GetMapping("/payment/success")
    public String paymentSuccess(@RequestParam("registration_id") Long registrationId,
                                 @RequestParam("rating") int rating,
                                 RedirectAttributes redirectAttrs) {

        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found"));
        Long eventId = reg.getEvent().getEventId();

        try {
            registrationService.processPayment(registrationId, rating);
            registrationService.sendPaymentEmail(reg.getWorkhand().getEmail());
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Payment processing failed.");
        }
        return "redirect:/vendor/payment/" + eventId;
    }

    // ─────────────────────────────────────────────
    // Workhand profile (vendor view)
    // ─────────────────────────────────────────────

    @GetMapping("/workhand-profile/{userId}")
    public String workhnadProfile(@PathVariable Long userId, Model model) {
        User workhand = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));

        List<EventRegistration> workhnadEvents =
                registrationRepo.findByWorkhandAndRegistrationStatusTrueAndEvent(workhand, null);

        model.addAttribute("active", "myevent");
        model.addAttribute("workhand", workhand);
        model.addAttribute("workhnadEvents", workhnadEvents);
        return "vendor/workhand-profile";
    }

    // ─────────────────────────────────────────────
    // Utility
    // ─────────────────────────────────────────────

    private User getCompany(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("Company user not found"));
    }

    private Event findEvent(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }
}
