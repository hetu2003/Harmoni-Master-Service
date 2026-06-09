package com.Harmoni.Master.Payment;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.EventRegistration.EventRegistrationService;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventWorkhnadRepository;
import com.Harmoni.Master.Repository.UserRepository;
import com.razorpay.Order;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final RazorpayService razorpayService;
    private final EventRegistrationRepository registrationRepo;
    private final EventRegistrationService registrationService;
    private final UserRepository userRepo;
    private final EventWorkhnadRepository eventWorkhandRepo;

    @PostMapping("/create-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(
            @RequestParam Long registrationId,
            @RequestParam int rating) {

        EventRegistration reg = registrationRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found"));

        // Fetch related entities using the IDs
        Users workhand = userRepo.findById(reg.getWorkhand().longValue()).orElse(null);
        EventWorkhand eventWorkhand = eventWorkhandRepo.findById(reg.getEventWorkhand().longValue()).orElse(null);

        if (workhand == null || eventWorkhand == null) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Associated workhand or event workhand not found.");
            return ResponseEntity.badRequest().body(errorResponse);
        }

        Map<String, Object> response = new HashMap<>();
        try {
            Order order = razorpayService.createOrder(
                    eventWorkhand.getPrice(),
                    "reg_" + registrationId
            );

            response.put("success",    true);
            response.put("orderId",    order.get("id"));
            response.put("amount",     order.get("amount"));
            response.put("currency",   order.get("currency"));
            response.put("keyId",      razorpayService.getKeyId());
            response.put("workhangName",  workhand.getName());
            response.put("workhangEmail", workhand.getEmail());
            response.put("workhangPhone", workhand.getContactNumber());
            response.put("registrationId", registrationId);
            response.put("rating",     rating);

        } catch (Exception e) {
            response.put("success", false);
            response.put("error",   e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/verify")
    public String verifyAndComplete(
            @RequestParam("razorpay_order_id")   String orderId,
            @RequestParam("razorpay_payment_id")  String paymentId,
            @RequestParam("razorpay_signature")   String signature,
            @RequestParam("registration_id")      Long registrationId,
            @RequestParam("rating")               int rating,
            RedirectAttributes redirectAttrs) {

        boolean valid = razorpayService.verifySignature(orderId, paymentId, signature);

        if (!valid) {
            redirectAttrs.addFlashAttribute("errorMessage",
                    "Payment signature verification failed. Contact support.");
            return "redirect:/vendor/payment/failed";
        }

        registrationService.processPayment(registrationId, rating);

        redirectAttrs.addFlashAttribute("successMessage", "Payment successful!");
        redirectAttrs.addFlashAttribute("paymentId", paymentId);
        return "redirect:/vendor/payment/success?registration_id=" + registrationId + "&rating=" + rating;
    }
}
