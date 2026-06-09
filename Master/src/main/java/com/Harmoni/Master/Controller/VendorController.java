package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.EventRegistration.EventRegistrationService;
import com.Harmoni.Master.Vendor.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/vendor")
@RequiredArgsConstructor
public class VendorController {

    private final VendorService vendorService;
    private final EventRegistrationService registrationService;

    private static final int PAGE_SIZE = 2;

    @GetMapping("/my-events")
    public String myEvents(@RequestParam(value = "page", defaultValue = "0") int page,
                           @AuthenticationPrincipal UserDetails principal,
                           Model model) {
        Users company = vendorService.getCompanyFromPrincipal(principal);
        Page<Events> eventPage = vendorService.getMyEvents(company, page, PAGE_SIZE);
        List<Integer> pageNumbers = IntStream.rangeClosed(1, eventPage.getTotalPages()).boxed().collect(Collectors.toList());

        model.addAttribute("active", "myevent");
        model.addAttribute("events", eventPage);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage", eventPage.getNumber() + 1);
        model.addAttribute("eventCount", eventPage.getTotalElements());
        return "vendor/company-events";
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
        model.addAttribute("eventCount", events.size());
        return "vendor/company-events";
    }

    @GetMapping("/workhand-requests/{eventId}")
    public String workhandRequests(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        model.addAttribute("active", "myevent");
        model.addAttribute("event", event);
        model.addAttribute("workhandRequests", vendorService.getWorkhandRequestsForEvent(event));
        return "vendor/request-approve";
    }

    @GetMapping("/request-approve")
    public String approveRequest(@RequestParam("registrationId") Long registrationId,
                                 RedirectAttributes redirectAttrs) {
        String error = registrationService.approveRegistration(registrationId);
        if (error != null) redirectAttrs.addFlashAttribute("errorMessage", error);
        
        EventRegistration reg = registrationService.getRegistrationById(registrationId);
        // reg.getEvent() now returns an Integer ID
        return "redirect:/vendor/workhand-requests/" + reg.getEvent();
    }

    @GetMapping("/approved-requests/{eventId}")
    public String approvedRequests(@PathVariable Long eventId, Model model) {
        Events event = vendorService.findEventById(eventId);
        model.addAttribute("active", "myevent");
        model.addAttribute("event", event);
        model.addAttribute("approvedRequests", vendorService.getApprovedRequestsForEvent(event));
        return "vendor/approved-requests";
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
        List<EventRegistration> approved = vendorService.getWorkhandsForPayment(event);
        int totalPrice = vendorService.calculateTotalPrice(approved);

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
        EventRegistration reg = registrationService.getRegistrationById(registrationId);
        Integer eventId = reg.getEvent();

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
        model.addAttribute("workhandEvents", vendorService.getWorkhandHistory(workhand));
        return "vendor/workhand-profile";
    }

    @GetMapping("/event-history")
    public String eventHistory(@AuthenticationPrincipal UserDetails principal, Model model) {
        Users company = vendorService.getCompanyFromPrincipal(principal);
        model.addAttribute("active", "myevent");
        model.addAttribute("rows", vendorService.getEventHistoryWithStats(company));
        return "vendor/event-history";
    }
}
