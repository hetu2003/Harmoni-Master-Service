package com.Harmoni.Master.EventRegistration;

import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.EventWorkhnadRepository;
import com.Harmoni.Master.Repository.UserRepository;
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
                                   Model model) {

        Events event = findEvent(eventId);
        Users currentUser = findUser(principal);
        List<EventWorkhand> eventWorkhands = eventWorkhnadRepo.findByEvent(event.getId().intValue());

        model.addAttribute("event", event);
        model.addAttribute("eventWorkhands", eventWorkhands);
        model.addAttribute("workhand", currentUser);
        return "Event/event-register";
    }

    /** POST /event-register/{eventId} */
    @PostMapping("/event-register/{eventId}")
    public String submitRegistration(@PathVariable Long eventId,
                                     @RequestParam("selected_category") Long selectedCategoryId,
                                     @AuthenticationPrincipal UserDetails principal,
                                     RedirectAttributes redirectAttrs) {

        Events event = findEvent(eventId);
        Users workhand = findUser(principal);

        EventWorkhand eventWorkhand = eventWorkhnadRepo.findById(selectedCategoryId)
                .orElseThrow(() -> new IllegalArgumentException("Category slot not found: " + selectedCategoryId));

        boolean registered = registrationService.registerWorkhand(event, workhand, eventWorkhand);

        if (!registered) {
            redirectAttrs.addFlashAttribute("errorMessage", "You are already registered for this event!");
            return "redirect:/event";
        }

        registrationService.sendRegistrationEmail(workhand.getEmail(), workhand.getName());
        return "redirect:/register-success";
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

    private Users findUser(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found: " + principal.getUsername()));
    }
}
