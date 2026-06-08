package com.Harmoni.Master.Auth.client;

import com.Harmoni.Master.Auth.dto.*;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

@FeignClient(name = "auth-service", path = "/auth", configuration = FeignSupportConfig.class)
public interface AuthClient {

    @PostMapping("/login/local")
    AuthResponse loginLocal(@RequestBody LoginRequest loginRequest);

    @PostMapping("/login/google")
    AuthResponse loginGoogle(@RequestBody GoogleLoginRequest googleLoginRequest);

    @PostMapping(value = "/register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    String registerUser(@RequestPart("registerDto") RegistrationRequest registrationRequest,
                        @RequestPart("profilePhoto") MultipartFile profilePhoto);

    @PostMapping("/forgot-password")
    String forgotPassword(@RequestBody ForgotPasswordRequest forgotPasswordRequest);

    @PostMapping("/reset-password")
    String resetPassword(@RequestBody ResetPasswordRequest resetPasswordRequest);

    @PostMapping("/change-password")
    String changePassword(@RequestBody ChangePasswordRequest changePasswordRequest);
}
