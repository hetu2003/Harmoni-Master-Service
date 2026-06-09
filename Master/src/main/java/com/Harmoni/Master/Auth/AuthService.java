package com.Harmoni.Master.Auth;

import com.Harmoni.Master.Auth.dto.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.multipart.MultipartFile;

public interface AuthService {
    AuthResponse login(String username, String password, HttpSession session);
    AuthResponse loginWithGoogle(String idToken, HttpSession session);
    String register(RegistrationRequest registrationRequest, MultipartFile profilePhoto);
    String processForgotPassword(ForgotPasswordRequest request);
    String processResetPassword(ResetPasswordRequest request);
    String changePassword(ChangePasswordRequest request);
    String updateProfile(String token, UpdateProfileRequest request, MultipartFile profilePhoto);

    String sendEmailOtp(EmailOtpSendRequest request);

    AuthResponse verifyEmailOtp(EmailOtpVerifyRequest request, HttpSession session);
}
