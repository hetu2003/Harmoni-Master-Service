package com.Harmoni.Master.EventRegistration;

import com.Harmoni.Master.Auth.client.AuthClient;
import com.Harmoni.Master.Auth.dto.EmailRequest;
import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Notification.NotificationService;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventWorkhnadRepository;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventRegistrationService {

    private final EventRegistrationRepository registrationRepo;
    private final UserRepository userRepo;
    private final EventWorkhnadRepository eventWorkhnadRepo;
    private final AuthClient authClient;
    private final NotificationService notificationService;

    public EventRegistration getRegistrationById(Long registrationId) {
        return registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found: " + registrationId));
    }

    @Transactional
    public boolean registerWorkhand(Events event, Users workhand, EventWorkhand eventWorkhand) {
        List<EventRegistration> existing = registrationRepo.findByWorkhandAndEvent(
                workhand.getUserId().intValue(), event.getId().intValue());
        if (!existing.isEmpty()) return false;

        EventRegistration reg = EventRegistration.builder()
                .event(event.getId().intValue())
                .workhand(workhand.getUserId().intValue())
                .company(event.getCompany().getUserId().intValue())
                .eventWorkhand(eventWorkhand.getEventWorkhnadId().intValue())
                .registrationDate(LocalDate.now())
                .registrationStatus(false)
                .paymentStatus(false)
                .build();
        reg.setCreatedBy(workhand.getUserId().intValue());
        reg.setModifiedBy(workhand.getUserId().intValue());
        reg.setIsActive(1);
        registrationRepo.save(reg);

        // Notify the company
        notificationService.notify(
                event.getCompany().getUserId(),
                workhand.getName() + " applied for your event: " + event.getEventName(),
                "REGISTRATION",
                event.getId()
        );
        return true;
    }

    @Transactional
    public String approveRegistration(Long registrationId) {
        EventRegistration reg = getRegistrationById(registrationId);

        // Capacity check — count already-approved for this slot and compare to slot size
        EventWorkhand slot = eventWorkhnadRepo.findById(reg.getEventWorkhand().longValue()).orElse(null);
        if (slot != null) {
            long approved = registrationRepo.countByEventWorkhandAndRegistrationStatusTrue(reg.getEventWorkhand());
            if (approved >= slot.getNumberOfWorkhand()) {
                return "Slot is already full (" + slot.getNumberOfWorkhand() + " approved). Cannot approve more.";
            }
        }

        reg.setRegistrationStatus(true);
        reg.setModifiedBy(reg.getCompany());
        registrationRepo.save(reg);

        // Notify the workhand
        notificationService.notify(
                reg.getWorkhand().longValue(),
                "Your registration has been approved! Check your event details.",
                "APPROVAL",
                reg.getEvent().longValue()
        );

        // Send approval email
        userRepo.findById(reg.getWorkhand().longValue()).ifPresent(wh ->
                sendApprovalEmail(wh.getEmail(), wh.getName()));

        return null;
    }

    @Transactional
    public void processPayment(Long registrationId, int rating) {
        EventRegistration reg = getRegistrationById(registrationId);
        reg.setPaymentStatus(true);
        reg.setRating(rating);
        reg.setPaymentDate(LocalDate.now());
        reg.setModifiedBy(reg.getCompany());
        registrationRepo.save(reg);

        Double avg = registrationRepo.findAverageRatingByWorkhand(reg.getWorkhand());
        if (avg != null) {
            userRepo.findById(reg.getWorkhand().longValue()).ifPresent(wh -> {
                wh.setAvgRating(avg.intValue());
                wh.setModifiedBy(reg.getCompany());
                userRepo.save(wh);
            });
        }

        // Notify workhand
        notificationService.notify(
                reg.getWorkhand().longValue(),
                "Payment received for your participation. Rating: " + rating + "/5",
                "PAYMENT",
                reg.getEvent().longValue()
        );

        userRepo.findById(reg.getWorkhand().longValue())
                .ifPresent(wh -> sendPaymentEmail(wh.getEmail()));
    }

    @Transactional
    public void revokeApproval(Long registrationId) {
        EventRegistration reg = getRegistrationById(registrationId);
        reg.setRegistrationStatus(false);
        reg.setPaymentStatus(false);
        registrationRepo.save(reg);

        notificationService.notify(
                reg.getWorkhand().longValue(),
                "Your registration approval was revoked.",
                "REJECTION",
                reg.getEvent().longValue()
        );
    }

    // ── Emails ──────────────────────────────────────────────────────────────

    public void sendRegistrationEmail(String toEmail, String displayName) {
        String subject = "Event Registration Submitted - Harmoni";
        String body = "<p>Dear <strong>" + displayName + "</strong>,</p>"
                + "<p>Your event registration has been submitted successfully.</p>"
                + "<p>The company will review and approve your request shortly.</p>"
                + "<p>Thank you for joining <strong>Harmoni Event Management</strong>!</p>";
        sendEmail(toEmail, subject, body);
    }

    public void sendApprovalEmail(String toEmail, String displayName) {
        String subject = "Registration Approved - Harmoni";
        String body = "<p>Dear <strong>" + displayName + "</strong>,</p>"
                + "<p>Great news! Your event registration has been <strong>approved</strong>.</p>"
                + "<p>Please log in to Harmoni to view your event details.</p>"
                + "<p>Thank you, <strong>Harmoni Event Management</strong></p>";
        sendEmail(toEmail, subject, body);
    }

    public void sendPaymentEmail(String toEmail) {
        String subject = "Payment Successful - Harmoni";
        String body = "<p>Your payment has been successfully processed.</p>"
                + "<p>Thank you for participating in the event. Have a great day!</p>"
                + "<p><strong>Harmoni Event Management</strong></p>";
        sendEmail(toEmail, subject, body);
    }

    private void sendEmail(String to, String subject, String htmlBody) {
        try {
            authClient.sendEmail(new EmailRequest(to, subject, htmlBody));
        } catch (Exception e) {
            System.err.println("Email delegation failed: " + e.getMessage());
        }
    }
}
