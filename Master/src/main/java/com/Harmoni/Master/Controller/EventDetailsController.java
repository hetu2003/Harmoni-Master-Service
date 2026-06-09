package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Feedback;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.FeedbackRepository;
import com.Harmoni.Master.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

/**
 * Event details page + feedback submission.
 * Routes use event_id (no slug column in schema).
 * Mirrors Django's event_details() and feedback() views.
 */
@Controller
@RequiredArgsConstructor
public class EventDetailsController {

    private final EventRepository eventRepo;
    private final EventRegistrationRepository registrationRepo;
    private final FeedbackRepository feedbackRepo;
    private final UserRepository userRepo;

    /** GET /event-details/{eventId} */
    @GetMapping("/event-details/{eventId}")
    public String showEventDetails(@PathVariable Long eventId,
                                   @AuthenticationPrincipal UserDetails principal,
                                   Model model) {

        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));

        List<Feedback> feedbacks = feedbackRepo.findByEvent(event);
        List<EventRegistration> registrationInfo = registrationRepo.findByEvent(event);

        model.addAttribute("event", event);
        model.addAttribute("workhnadFeedbacks", feedbacks);
        model.addAttribute("registrationInfo", registrationInfo);

        if (principal != null) {
            Users currentUser = userRepo.findByUsername(principal.getUsername()).orElse(null);
            if (currentUser != null) {
                boolean isCompany = currentUser.getRoleId().equals(2);
                model.addAttribute("isCompany", isCompany);

                if (!isCompany) {
                    // Workhand-specific model attributes
                    List<EventRegistration> alreadyRegistered =
                            registrationRepo.findByWorkhandAndEvent(currentUser, event);
                    List<Feedback> alreadyFeedback =
                            feedbackRepo.findByEventAndWorkhand(event, currentUser);
                    List<EventRegistration> approvedForFeedback =
                            registrationRepo.findByWorkhandAndRegistrationStatusTrueAndEvent(currentUser, event);

                    model.addAttribute("currentUser", currentUser);
                    model.addAttribute("alreadyRegistered", alreadyRegistered);
                    model.addAttribute("alreadyFeedback", alreadyFeedback);
                    model.addAttribute("approvedForFeedback", approvedForFeedback);
                }
            }
        }

        return "user/event-details";
    }

    /** POST /feedback */
    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam("workhand_id") Long workhnadId,
                                 @RequestParam("event_id") Long eventId,
                                 @RequestParam("feedback") String feedbackText,
                                 RedirectAttributes redirectAttrs) {

        Integer event = eventRepo.findById(eventId);
        Users workhand = userRepo.findById(workhnadId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + workhnadId));

        Feedback feedback = Feedback.builder()
                .feedback(feedbackText)
                .feedbackDate(LocalDate.now())
                .event(event)
                .workhand(workhand)
                .build();
        feedback.setCreatedBy(workhand.getUserId().intValue());
        feedback.setModifiedBy(workhand.getUserId().intValue());
        feedback.setIsActive(1);
        feedbackRepo.save(feedback);

        redirectAttrs.addFlashAttribute("successMessage", "Thank You For Your Feedback!");
        return "redirect:/event-details/" + eventId;
    }
}
