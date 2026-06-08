package com.Harmoni.Master.EventRegistration;

import jakarta.transaction.Transactional;

public class EventRegistrationService {
    private final EventRegistrationRepository registrationRepo;
    private final UserRepository userRepo;
    private final JavaMailSender mailSender;

    /**
     * Register a workhand (User with WORKHAND role) for an event.
     * Returns false if already registered.
     */
    @Transactional
    public boolean registerWorkhand(Event event, User workhand, EventWorkhand eventWorkhand) {
        List<EventRegistration> existing = registrationRepo.findByWorkhandAndEvent(workhand, event);
        if (!existing.isEmpty()) return false;

        EventRegistration reg = EventRegistration.builder()
                .event(event)
                .workhand(workhand)
                .company(event.getCompany())
                .eventWorkhand(eventWorkhand)
                .registrationDate(LocalDate.now())
                .registrationStatus(false)
                .paymentStatus(false)
                .build();

        // Set audit fields (createdBy = workhand's user_id)
        reg.setCreatedBy(workhand.getUserId().intValue());
        reg.setModifiedBy(workhand.getUserId().intValue());
        reg.setIsActive(1);

        registrationRepo.save(reg);
        return true;
    }

    /**
     * Approve a workhand request — checks seat capacity first.
     * Returns null on success, error message on failure.
     */
    @Transactional
    public String approveRegistration(Long registrationId) {
        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found: " + registrationId));

        long approved = registrationRepo.countByEventWorkhandAndRegistrationStatusTrue(reg.getEventWorkhand());
        int capacity = reg.getEventWorkhand().getNumberOfWorkhand();

        if ((capacity - 1) >= (int) approved) {
            reg.setRegistrationStatus(true);
            reg.setModifiedBy(reg.getCompany().getUserId().intValue());
            registrationRepo.save(reg);
            return null;
        }
        return "Seat limit reached: only " + capacity + " workhands needed for category ID "
                + reg.getEventWorkhand().getWorkhnadCategoryId();
    }

    /**
     * Mark payment done, record rating, recalculate workhand's average rating.
     */
    @Transactional
    public void processPayment(Long registrationId, int rating) {
        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found: " + registrationId));

        reg.setPaymentStatus(true);
        reg.setRating(rating);
        reg.setPaymentDate(LocalDate.now());
        reg.setModifiedBy(reg.getCompany().getUserId().intValue());
        registrationRepo.save(reg);

        // Recalculate and persist workhand's average rating
        Double avg = registrationRepo.findAverageRatingByWorkhand(reg.getWorkhand());
        if (avg != null) {
            User workhand = reg.getWorkhand();
            workhand.setAvgRating(avg.intValue());
            workhand.setModifiedBy(reg.getCompany().getUserId().intValue());
            userRepo.save(workhand);
        }
    }

    /**
     * Revoke approval (set registration_status = false, payment_status = false).
     */
    @Transactional
    public void revokeApproval(Long registrationId) {
        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found: " + registrationId));
        reg.setRegistrationStatus(false);
        reg.setPaymentStatus(false);
        registrationRepo.save(reg);
    }

    /** Send HTML confirmation email — failure is non-fatal. */
    public void sendRegistrationEmail(String toEmail, String displayName) {
        sendEmail(toEmail, "Event Registration Successful!!",
                "<p>Dear <strong>" + displayName + "</strong>,</p>" +
                        "<p>Your event registration has been submitted. " +
                        "The company will review and approve your request shortly.</p>" +
                        "<p>Thank you for joining <strong>Harmoni Event Management</strong>!</p>");
    }

    /** Send payment success email — failure is non-fatal. */
    public void sendPaymentEmail(String toEmail) {
        sendEmail(toEmail, "Payment Successful",
                "<p>Your payment has been successfully processed.</p>" +
                        "<p>Thank you for participating in the event. Have a great day!</p>");
    }

    private void sendEmail(String to, String subject, String htmlBody) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true);
            mailSender.send(message);
        } catch (MessagingException e) {
            System.err.println("Email send failed to " + to + ": " + e.getMessage());
        }
    }
}
