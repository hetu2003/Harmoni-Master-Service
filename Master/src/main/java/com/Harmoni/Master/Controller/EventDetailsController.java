package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Feedback;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.FeedbackRepository;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

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
                                   HttpSession session,
                                   Model model) {

        Events event = eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));

        List<Feedback> feedbacks = feedbackRepo.findByEvent(event.getId().intValue());

        model.addAttribute("event", event);
        model.addAttribute("workhnadFeedbacks", feedbacks);

        // Resolve current user: prefer Spring Security principal, fall back to session
        Users currentUser = null;
        if (principal != null) {
            currentUser = userRepo.findByUsername(principal.getUsername()).orElse(null);
        }
        if (currentUser == null) {
            Long sessionUserId = (Long) session.getAttribute("userId");
            if (sessionUserId != null) {
                currentUser = userRepo.findById(sessionUserId).orElse(null);
            }
        }

        if (currentUser != null) {
            boolean isCompany = currentUser.getRoleId() != null && currentUser.getRoleId() == 2;
            boolean isAdmin   = currentUser.getRoleId() != null && currentUser.getRoleId() == 3;
            model.addAttribute("isCompany", isCompany || isAdmin);

            if (!isCompany && !isAdmin) {
                var existing = registrationRepo.findByWorkhandAndEvent(
                        currentUser.getUserId().intValue(), event.getId().intValue());
                List<Feedback> alreadyFeedback = feedbackRepo.findByEventAndWorkhnadId(
                        event.getId().intValue(), currentUser.getUserId().intValue());
                var approvedForFeedback = registrationRepo.findApprovedByWorkhandAndEvent(
                        currentUser.getUserId().intValue(), event.getId().intValue());

                model.addAttribute("currentUser", currentUser);
                model.addAttribute("alreadyRegistered", !existing.isEmpty());
                model.addAttribute("myApplicationStatus",
                        existing.isEmpty() ? null : existing.get(0).getApplicationStatus());
                model.addAttribute("alreadyFeedback", alreadyFeedback);
                model.addAttribute("approvedForFeedback", approvedForFeedback);
            }
        }

        model.addAttribute("viewName", "Event/eventdetails");
        return "base/base";
    }

    /** POST /feedback */
    @PostMapping("/feedback")
    public String submitFeedback(@RequestParam("workhand_id") Long workhnadId,
                                 @RequestParam("event_id") Long eventId,
                                 @RequestParam("feedback") String feedbackText,
                                 RedirectAttributes redirectAttrs) {

        Feedback feedback = Feedback.builder()
                .feedback(feedbackText)
                .feedbackDate(LocalDate.now())
                .event(eventId.intValue())
                .workhnadId(workhnadId.intValue())
                .build();
        feedback.setCreatedBy(workhnadId.intValue());
        feedback.setModifiedBy(workhnadId.intValue());
        feedback.setIsActive(1);
        feedbackRepo.save(feedback);

        redirectAttrs.addFlashAttribute("successMessage", "Thank You For Your Feedback!");
        return "redirect:/event-details/" + eventId;
    }
}
