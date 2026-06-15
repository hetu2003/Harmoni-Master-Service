package com.Harmoni.Master.Payment;


import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class RazorpayService {

    @Value("${razorpay.key.id}")
    private String keyId;

    @Value("${razorpay.key.secret}")
    private String keySecret;

    /**
     * Creates a Razorpay order.
     * @param amountInRupees  BigDecimal rupee amount (e.g. 500.00)
     * @param receipt         Unique string — use "reg_<registrationId>"
     */
    public Order createOrder(BigDecimal amountInRupees, String receipt) throws RazorpayException {
        RazorpayClient client = new RazorpayClient(keyId.trim(), keySecret.trim());

        // Razorpay requires amount in paise (1 INR = 100 paise)
        int amountInPaise = amountInRupees.multiply(BigDecimal.valueOf(100)).intValue();

        JSONObject req = new JSONObject();
        req.put("amount",   amountInPaise);
        req.put("currency", "INR");
        req.put("receipt",  receipt);

        return client.orders.create(req);
    }

    /**
     * Verifies the HMAC-SHA256 signature sent by Razorpay after payment.
     * Returns true only when the signature is valid.
     */
    public boolean verifySignature(String razorpayOrderId,
                                   String razorpayPaymentId,
                                   String razorpaySignature) {
        try {
            JSONObject attrs = new JSONObject();
            attrs.put("razorpay_order_id",   razorpayOrderId);
            attrs.put("razorpay_payment_id",  razorpayPaymentId);
            attrs.put("razorpay_signature",   razorpaySignature);
            Utils.verifyPaymentSignature(attrs, keySecret);
            return true;
        } catch (RazorpayException e) {
            return false;
        }
    }

    public String getKeyId() { return keyId; }
}
