package com.Harmoni.Master.EventRegistration;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Repository.EventRepository;
import com.harmoni.entity.*;
import com.harmoni.repository.*;
import com.harmoni.service.EventRegistrationService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
@RestController
public class EventRegistrationController {

    private final EventRepository eventRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final UserRepository userRepo;
    private final EventRegistrationService registrationService;

    /** GET /event-register/{eventId} */
    @GetMapping("/event-register/{eventId}")
    public String showRegisterForm(@PathVariable Long eventId,
                                   @AuthenticationPrincipal UserDetails principal,
                                   Model model) {

        Event event = findEvent(eventId);
        User currentUser = findUser(principal);

        List<EventWorkhand> eventWorkhands = eventWorkhnadRepo.findByEvent(event);

        model.addAttribute("event", event);
        model.addAttribute("eventWorkhands", eventWorkhands);
        model.addAttribute("workhand", currentUser);
        return "user/event-register";
    }

    /** POST /event-register/{eventId} */
    @PostMapping("/event-register/{eventId}")
    public String submitRegistration(@PathVariable Long eventId,
                                     @RequestParam("selected_category") Long selectedCategoryId,
                                     @AuthenticationPrincipal UserDetails principal,
                                     RedirectAttributes redirectAttrs) {

        Event event = findEvent(eventId);
        User workhand = findUser(principal);

        EventWorkhand eventWorkhand = eventWorkhnadRepo.findById(selectedCategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category slot not found: " + selectedCategoryId));

        boolean registered = registrationService.registerWorkhand(event, workhand, eventWorkhand);

        if (!registered) {
            redirectAttrs.addFlashAttribute("errorMessage",
                    "You are already registered for this event!");
            return "redirect:/event";
        }

        registrationService.sendRegistrationEmail(workhand.getEmail(), workhand.getName());
        return "redirect:/register-success";
    }

    /** GET /register-success */
    @GetMapping("/register-success")
    public String registerSuccess() {
        return "user/register-success";
    }

    // ─── Helpers ──────────────────────────────────────────────────────────────

    private Event findEvent(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }

    private User findUser(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found: " + principal.getUsername()));
    }

}
