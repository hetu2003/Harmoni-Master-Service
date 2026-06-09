package com.Harmoni.Master.Auth.client;

import com.Harmoni.Master.Auth.dto.*;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@FeignClient(name = "auth-service", path = "/auth", configuration = FeignSupportConfig.class)
public interface AuthClient {

    @PostMapping("/login/local")
    AuthResponse loginLocal(@RequestBody LoginRequest loginRequest);

    @PostMapping("/login/google")
    AuthResponse loginGoogle(@RequestBody GoogleLoginRequest googleLoginRequest);

    @PostMapping(value = "/register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    String registerUser(@RequestPart("registerDto") RegistrationRequest registrationRequest,
                        @RequestPart(value = "profilePhoto", required = false) MultipartFile profilePhoto);

    @PostMapping("/forgot-password")
    String forgotPassword(@RequestBody ForgotPasswordRequest forgotPasswordRequest);

    @PostMapping("/reset-password")
    String resetPassword(@RequestBody ResetPasswordRequest resetPasswordRequest);

    @PostMapping("/change-password")
    String changePassword(@RequestBody ChangePasswordRequest changePasswordRequest);

    @PostMapping(value = "/update-profile", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    String updateProfile(@RequestHeader("Authorization") String authorizationHeader,
                         @RequestPart("name") String name,
                         @RequestPart("contactNumber") String contactNumber,
                         @RequestPart("streetAddress") String streetAddress,
                         @RequestPart("cityId") Integer cityId,
                         @RequestPart("stateId") Integer stateId,
                         @RequestPart(value = "companyDescription", required = false) String companyDescription,
                         @RequestPart(value = "profilePhoto", required = false) MultipartFile profilePhoto);

    @PostMapping("/login/email/send-otp")
    String sendEmailOtp(@RequestBody EmailOtpSendRequest request);

    @PostMapping("/login/email/verify-otp")
    AuthResponse verifyEmailOtp(@RequestBody EmailOtpVerifyRequest request);

    @PostMapping("/send-email")
    void sendEmail(@RequestBody EmailRequest emailRequest);
}
