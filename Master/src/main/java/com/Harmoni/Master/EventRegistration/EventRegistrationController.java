package com.Harmoni.Master.EventRegistration;

import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.EventWorkhnadRepository;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class EventRegistrationController {

    @Autowired private EventRepository eventRepo;
    @Autowired private EventWorkhnadRepository eventWorkhnadRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private EventRegistrationService registrationService;

    /** GET /event-register/{eventId} */
    @GetMapping("/event-register/{eventId}")
    public String showRegisterForm(@PathVariable Long eventId,
                                   @AuthenticationPrincipal UserDetails principal,
                                   HttpSession session,
                                   Model model) {

        Events event = findEvent(eventId);
        Users currentUser = resolveUser(principal, session);
        if (currentUser == null) return "redirect:/login";

        List<EventWorkhand> eventWorkhands = eventWorkhnadRepo.findByEvent(event.getId().intValue());

        model.addAttribute("event", event);
        model.addAttribute("eventWorkhands", eventWorkhands);
        model.addAttribute("workhand", currentUser);
        model.addAttribute("title", "Apply for Event");
        model.addAttribute("viewName", "Event/event-register");
        return "base/base";
    }

    /** POST /event-register/{eventId} */
    @PostMapping("/event-register/{eventId}")
    public String submitRegistration(@PathVariable Long eventId,
                                     @RequestParam("selected_category") Long selectedCategoryId,
                                     @AuthenticationPrincipal UserDetails principal,
                                     HttpSession session,
                                     RedirectAttributes redirectAttrs) {

        Events event = findEvent(eventId);
        Users workhand = resolveUser(principal, session);
        if (workhand == null) return "redirect:/login";

        EventWorkhand eventWorkhand = eventWorkhnadRepo.findById(selectedCategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category slot not found: " + selectedCategoryId));

        boolean registered = registrationService.registerWorkhand(event, workhand, eventWorkhand);

        if (!registered) {
            redirectAttrs.addFlashAttribute("errorMessage", "You have already applied for this event!");
            return "redirect:/event-details/" + eventId;
        }

        registrationService.sendRegistrationEmail(workhand.getEmail(), workhand.getName());
        redirectAttrs.addFlashAttribute("successMessage",
                "Application submitted! The company will review and get back to you.");
        return "redirect:/event-details/" + eventId;
    }

    /** GET /register-success */
    @GetMapping("/register-success")
    public String registerSuccess() {
        return "Event/register-success";
    }

    private Events findEvent(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }

    private Users resolveUser(UserDetails principal, HttpSession session) {
        if (principal != null) {
            return userRepo.findByUsername(principal.getUsername()).orElse(null);
        }
        Long sessionUserId = (Long) session.getAttribute("userId");
        if (sessionUserId != null) {
            return userRepo.findById(sessionUserId).orElse(null);
        }
        return null;
    }
}
