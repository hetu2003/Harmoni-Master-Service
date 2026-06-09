package com.Harmoni.Master.Controller;

import com.Harmoni.Master.EventRegistration.EventRegistrationService;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final EventRegistrationService registrationService;

    @Value("${razorpay.key.id}")
    private String keyId;

    @Value("${razorpay.key.secret}")
    private String keySecret;

    @PreAuthorize("hasAnyRole('COMPANY', 'ADMIN')")
    @PostMapping("/create-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(
            @RequestParam("registrationId") Long registrationId,
            @RequestParam("amount") int amountPaise,
            @RequestParam("rating") int rating) {

        Map<String, Object> result = new HashMap<>();
        try {

            RazorpayClient client = new RazorpayClient(keyId, keySecret);
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "reg_" + registrationId);

            Order order = client.orders.create(orderRequest);

            result.put("success", true);
            result.put("orderId", order.get("id"));
            result.put("amount", amountPaise);
            result.put("currency", "INR");
            result.put("keyId", keyId);
            result.put("registrationId", registrationId);
            result.put("rating", rating);
        } catch (RazorpayException e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    @PreAuthorize("hasAnyRole('COMPANY', 'ADMIN')")
    @PostMapping("/verify")
    public String verifyPayment(
            @RequestParam("razorpay_order_id") String orderId,
            @RequestParam("razorpay_payment_id") String paymentId,
            @RequestParam("razorpay_signature") String signature,
            @RequestParam("registration_id") Long registrationId,
            @RequestParam("rating") int rating,
            RedirectAttributes ra) {

        try {
            String payload = orderId + "|" + paymentId;
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(keySecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            byte[] hash = mac.doFinal(payload.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) sb.append(String.format("%02x", b));
            String expected = sb.toString();

            if (!expected.equals(signature)) {
                ra.addFlashAttribute("errorMessage", "Payment verification failed. Please contact support.");
                return "redirect:/vendor/payment/" +
                        registrationService.getRegistrationById(registrationId).getEvent();
            }

            registrationService.processPayment(registrationId, rating);
            ra.addFlashAttribute("successMessage", "Payment processed successfully!");
        } catch (Exception e) {
            ra.addFlashAttribute("errorMessage", "Payment error: " + e.getMessage());
        }

        long eventId = registrationService.getRegistrationById(registrationId).getEvent().longValue();
        return "redirect:/vendor/payment/" + eventId;
    }

    @GetMapping("/failed")
    public String paymentFailed() {
        return "Payment/payment-failed";
    }
}
