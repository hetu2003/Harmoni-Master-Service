package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Dto.WorkhnadRegistrationDto;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.EventRegistration.EventRegistrationService;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Vendor.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/vendor")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('COMPANY', 'ADMIN')")
public class VendorController {

    private final VendorService vendorService;
    private final EventRegistrationService registrationService;
    private final EventRegistrationRepository registrationRepo;

    private static final int PAGE_SIZE = 2;

    @GetMapping("/my-events")
    public String myEvents(@RequestParam(value = "page", defaultValue = "0") int page,
                           @AuthenticationPrincipal UserDetails principal,
                           Model model) {
        Users company = vendorService.getCompanyFromPrincipal(principal);
        Page<Events> eventPage = vendorService.getMyEvents(company, page, PAGE_SIZE);
        List<Integer> pageNumbers = IntStream.rangeClosed(1, eventPage.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("active", "myevent");
        model.addAttribute("events", eventPage);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage", eventPage.getNumber() + 1);
        model.addAttribute("totalEvent", eventPage.getTotalElements());
        model.addAttribute("title", "My Events");
        model.addAttribute("viewName", "User/company-events");
        return "base/base";
    }

    @PostMapping("/my-events/search")
    public String searchMyEvents(@RequestParam("search") String search,
                                 @AuthenticationPrincipal UserDetails principal,
                                 Model model) {
        if ("all".equals(search)) return "redirect:/vendor/my-events";
        Users company = vendorService.getCompanyFromPrincipal(principal);
        List<Events> events = vendorService.searchMyEvents(company, search);
        model.addAttribute("active", "myevent");
        model.addAttribute("events", events);
        model.addAttribute("totalEvent", events.size());
        model.addAttribute("title", "My Events");
        model.addAttribute("viewName", "User/company-events");
        return "base/base";
    }

    @GetMapping("/workhand-requests/{eventId}")
    public String workhandRequests(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        long acceptedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "ACCEPTED");
        long pendingCount  = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "PENDING");
        long rejectedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "REJECTED");

        model.addAttribute("active", "myevent");
        model.addAttribute("title", "Workhand Applications");
        model.addAttribute("event", event);
        model.addAttribute("workhnadRequests", vendorService.getWorkhandRequestsForEvent(event));
        model.addAttribute("acceptedCount", acceptedCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("rejectedCount", rejectedCount);
        model.addAttribute("viewName", "Event/request-approve");
        return "base/base";
    }

    @PostMapping("/request-approve")
    public String approveRequest(@RequestParam("registrationId") Long registrationId,
                                 RedirectAttributes redirectAttrs) {
        String error = registrationService.approveRegistration(registrationId);
        if (error != null) redirectAttrs.addFlashAttribute("errorMessage", error);
        else redirectAttrs.addFlashAttribute("successMessage", "Workhand accepted successfully.");
        Long eventId = registrationService.getRegistrationById(registrationId).getEvent().longValue();
        return "redirect:/vendor/workhand-requests/" + eventId;
    }

    @PostMapping("/request-reject")
    public String rejectRequest(@RequestParam("registrationId") Long registrationId,
                                RedirectAttributes redirectAttrs) {
        String error = registrationService.rejectRegistration(registrationId);
        if (error != null) redirectAttrs.addFlashAttribute("errorMessage", error);
        else redirectAttrs.addFlashAttribute("successMessage", "Application rejected.");
        Long eventId = registrationService.getRegistrationById(registrationId).getEvent().longValue();
        return "redirect:/vendor/workhand-requests/" + eventId;
    }

    @GetMapping("/approved-requests/{eventId}")
    public String approvedRequests(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        long acceptedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "ACCEPTED");
        long pendingCount  = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "PENDING");
        long rejectedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "REJECTED");

        model.addAttribute("active", "myevent");
        model.addAttribute("title", "Approved Applications");
        model.addAttribute("event", event);
        model.addAttribute("approvedRequests", vendorService.getApprovedRequestsForEvent(event));
        model.addAttribute("acceptedCount", acceptedCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("rejectedCount", rejectedCount);
        model.addAttribute("viewName", "Event/approved-requests");
        return "base/base";
    }

    @GetMapping("/rejected-requests/{eventId}")
    public String rejectedRequests(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        long acceptedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "ACCEPTED");
        long pendingCount  = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "PENDING");
        long rejectedCount = registrationRepo.countByEventAndApplicationStatus(event.getId().intValue(), "REJECTED");

        model.addAttribute("active", "myevent");
        model.addAttribute("title", "Rejected Applications");
        model.addAttribute("event", event);
        model.addAttribute("rejectedRequests", vendorService.getRejectedRequestsForEvent(event));
        model.addAttribute("acceptedCount", acceptedCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("rejectedCount", rejectedCount);
        model.addAttribute("viewName", "Event/rejected-requests");
        return "base/base";
    }

    @PostMapping("/approved-requests/{eventId}/revoke")
    public String revokeApproval(@PathVariable Long eventId,
                                 @RequestParam("registrationId") Long registrationId) {
        registrationService.revokeApproval(registrationId);
        return "redirect:/vendor/approved-requests/" + eventId;
    }

    @GetMapping("/payment/{eventId}")
    public String payment(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        List<WorkhnadRegistrationDto> approved = vendorService.getWorkhandsForPayment(event);
        int totalPrice = vendorService.calculateTotalPrice(approved);

        model.addAttribute("active", "myevent");
        model.addAttribute("title", "Payments");
        model.addAttribute("event", event);
        model.addAttribute("workhands", approved);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("viewName", "Payment/payment");
        return "base/base";
    }

    @GetMapping("/payment/success")
    public String paymentSuccess(@RequestParam("registration_id") Long registrationId,
                                 @RequestParam("rating") int rating,
                                 RedirectAttributes redirectAttrs) {
        Long eventId = registrationService.getRegistrationById(registrationId).getEvent().longValue();
        try {
            vendorService.processWorkhandPayment(registrationId, rating);
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Payment processing failed.");
        }
        return "redirect:/vendor/payment/" + eventId;
    }

    @GetMapping("/workhand-profile/{userId}")
    public String workhandProfile(@PathVariable Long userId, Model model) {
        Users workhand = vendorService.getWorkhandProfile(userId);
        model.addAttribute("active", "myevent");
        model.addAttribute("workhand", workhand);
        model.addAttribute("workhnadEvents", vendorService.getWorkhandHistory(workhand));
        return "User/workhand-profile";
    }

    @GetMapping("/event-history")
    public String eventHistory(@AuthenticationPrincipal UserDetails principal, Model model) {
        Users company = vendorService.getCompanyFromPrincipal(principal);
        model.addAttribute("active", "myevent");
        model.addAttribute("title", "Event History");
        model.addAttribute("rows", vendorService.getEventHistoryWithStats(company));
        model.addAttribute("viewName", "Event/event-history");
        return "base/base";
    }
}
