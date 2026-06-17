package com.Harmoni.Master.Auth;


import com.Harmoni.Master.Auth.dto.*;
import com.Harmoni.Master.Dto.AjaxResponse;
import com.Harmoni.Master.Entity.UserWorkhnadCategory;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.StateRepository;
import com.Harmoni.Master.Repository.UserRepository;
import com.Harmoni.Master.Repository.UserWorkhnadCategoryRepository;
import com.Harmoni.Master.Repository.WorkhandCategoryRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StateRepository stateRepository;

    @Autowired
    private WorkhandCategoryRepository workhnadCategoryRepo;

    @Autowired
    private UserWorkhnadCategoryRepository userWorkhnadCategoryRepo;

    // Show the login page
    @GetMapping("/login")
    public String showLoginPage(HttpServletRequest request,
                                @RequestParam(value = "expired", required = false) String expired,
                                Model model) {
        HttpSession session = request.getSession(false);
        boolean hasSession = session != null && session.getAttribute("userId") != null;

        if (hasSession) {
            if ("true".equals(expired)) {
                // JWT expired — clear the stale session so the user gets a fresh login
                session.invalidate();
                // sessionExpired goes on the request attribute (model), not the old session
                model.addAttribute("sessionExpired", true);
            } else {
                // User navigated here manually while still logged in — send them home
                return "redirect:/home";
            }
        } else if ("true".equals(expired)) {
            // Session already gone (e.g. already invalidated) but expired param present
            model.addAttribute("sessionExpired", true);
        }

        model.addAttribute("title", "Login");
        model.addAttribute("viewName", "login/login");
        return "base/base";
    }

    // Show the registration page
    @GetMapping("/register")
    public String showRegisterPage(HttpSession session, Model model) {
        if (session.getAttribute("userId") != null) {
            // Already logged in — redirect to home with no confusing blank transition
            return "redirect:/home";
        }
        model.addAttribute("states", stateRepository.findAllByOrderByStateNameDesc());
        model.addAttribute("workhnadCategories", workhnadCategoryRepo.findAll());
        model.addAttribute("title", "Register");
        model.addAttribute("viewName", "login/registration");
        return "base/base";
    }

    // --- AJAX Registration Handler ---
    @PostMapping(value = "/register", consumes = "multipart/form-data", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> processAjaxRegistration(@ModelAttribute RegistrationRequest registrationRequest,
                                                                @RequestParam("profilePhoto") MultipartFile profilePhoto,
                                                                HttpServletRequest request) {

        String result = authService.register(registrationRequest, profilePhoto);

        if (result != null && result.contains("successful")) {
            // Persist workhand skill categories for WORKHAND registrations
            if (Integer.valueOf(1).equals(registrationRequest.getRoleId())
                    && registrationRequest.getWorkhnadCategoryIds() != null
                    && !registrationRequest.getWorkhnadCategoryIds().isEmpty()) {
                try {
                    Users user = userRepository.findByUsername(registrationRequest.getUsername()).orElse(null);
                    if (user != null) {
                        for (Integer catId : registrationRequest.getWorkhnadCategoryIds()) {
                            userWorkhnadCategoryRepo.save(
                                    new UserWorkhnadCategory(null, user.getUserId(), catId, null));
                        }
                    }
                } catch (Exception ignored) {}
            }
            String loginUrl = request.getContextPath() + "/login";
            return ResponseEntity.ok(new AjaxResponse(true, result, loginUrl));
        } else {
            return ResponseEntity.ok(new AjaxResponse(false, result, null));
        }
    }
    
    // --- Login Endpoints ---

    @PostMapping(value = "/login", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> processAjaxLogin(@RequestBody LoginRequest loginRequest,
                                                          HttpServletRequest request,
                                                          HttpServletResponse httpResponse,
                                                          HttpSession session) {
        AuthResponse response = authService.login(loginRequest.getUsername(), loginRequest.getPassword(), session);

        if (response != null) {
            setJwtCookie(httpResponse, response.getToken());
            String redirectUrl = request.getContextPath() + "/home";
            try {
                Long userId = Long.parseLong(response.getUserId());
                Users u = userRepository.findById(userId).orElse(null);
                if (u != null && Integer.valueOf(3).equals(u.getRoleId())) {
                    redirectUrl = request.getContextPath() + "/admin/dashboard";
                }
            } catch (Exception ignored) {}
            return ResponseEntity.ok(new AjaxResponse(true, "Login successful", redirectUrl));
        } else {
            return ResponseEntity.ok(new AjaxResponse(false, "Invalid username or password", null));
        }
    }

    @PostMapping(value = "/login", consumes = "application/x-www-form-urlencoded")
    public String processFormLogin(@RequestParam("username") String username,
                                   @RequestParam("password") String password,
                                   HttpSession session, HttpServletResponse httpResponse, Model model) {
        AuthResponse response = authService.login(username, password, session);

        if (response != null) {
            setJwtCookie(httpResponse, response.getToken());
            try {
                Long userId = Long.parseLong(response.getUserId());
                Users u = userRepository.findById(userId).orElse(null);
                if (u != null && Integer.valueOf(3).equals(u.getRoleId())) {
                    return "redirect:/admin/dashboard";
                }
            } catch (Exception ignored) {}
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid username or password");
            model.addAttribute("title", "Login");
            model.addAttribute("viewName", "login/login");
            return "base/base";
        }
    }

    @PostMapping(value = "/login/google", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> processGoogleLogin(@RequestBody GoogleLoginRequest googleLoginRequest,
                                                             HttpServletRequest request,
                                                             HttpServletResponse httpResponse,
                                                             HttpSession session) {
        AuthResponse response = authService.loginWithGoogle(googleLoginRequest.getIdToken(), session);

        if (response != null) {
            setJwtCookie(httpResponse, response.getToken());
            return ResponseEntity.ok(new AjaxResponse(true, "Google Sign-In successful", request.getContextPath() + "/home"));
        } else {
            return ResponseEntity.ok(new AjaxResponse(false, "Google Sign-In failed. Please try again.", null));
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse httpResponse) {
        session.invalidate();
        clearJwtCookie(httpResponse);
        return "redirect:/login";
    }

    // --- Change Password ---

    @GetMapping("/change-password")
    public String showChangePasswordPage(HttpSession session, Model model) {
        if (session.getAttribute("userToken") == null) {
            return "redirect:/login";
        }
        model.addAttribute("title", "Change Password");
        model.addAttribute("viewName", "login/change-password");
        return "base/base";
    }

    @PostMapping(value = "/change-password", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> processChangePassword(@RequestBody ChangePasswordRequest request,
                                                               HttpSession session) {
        if (session.getAttribute("userToken") == null) {
            return ResponseEntity.ok(new AjaxResponse(false, "Session expired. Please log in again.", null));
        }
        String result = authService.changePassword(request);
        if (result != null && result.contains("successfully")) {
            userRepository.findByUsername(request.getUsername())
                    .ifPresent(u -> authService.sendPasswordChangeEmail(u.getEmail()));
            return ResponseEntity.ok(new AjaxResponse(true, result, "/home"));
        }
        return ResponseEntity.ok(new AjaxResponse(false, result, null));
    }

    // --- Email OTP Login Endpoints ---

    @PostMapping(value = "/login/email/send-otp", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> sendEmailOtp(@RequestBody EmailOtpSendRequest otpRequest) {
        String result = authService.sendEmailOtp(otpRequest);
        return ResponseEntity.ok(new AjaxResponse(true, result, null));
    }

    @PostMapping(value = "/login/email/verify-otp", consumes = "application/json", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> verifyEmailOtp(@RequestBody EmailOtpVerifyRequest otpRequest,
                                                        HttpServletRequest request,
                                                        HttpServletResponse httpResponse,
                                                        HttpSession session) {
        AuthResponse response = authService.verifyEmailOtp(otpRequest, session);
        if (response != null) {
            setJwtCookie(httpResponse, response.getToken());
            return ResponseEntity.ok(new AjaxResponse(true, "Login successful", request.getContextPath() + "/home"));
        } else {
            return ResponseEntity.ok(new AjaxResponse(false, "Invalid or expired OTP. Please try again.", null));
        }
    }

    // --- Forgot / Reset Password Endpoints ---
    @GetMapping("/forgot-password")
    public String showForgotPasswordPage(Model model) {
        model.addAttribute("title", "Forgot Password");
        model.addAttribute("viewName", "login/forgot-password");
        return "base/base";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@ModelAttribute ForgotPasswordRequest request, RedirectAttributes redirectAttributes) {
        String result = authService.processForgotPassword(request);
        redirectAttributes.addFlashAttribute("success", result);
        return "redirect:/forgot-password";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordPage(@RequestParam("token") String token, Model model) {
        model.addAttribute("token", token);
        model.addAttribute("title", "Reset Password");
        model.addAttribute("viewName", "login/reset-password");
        return "base/base";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@ModelAttribute ResetPasswordRequest request, RedirectAttributes redirectAttributes) {
        String result = authService.processResetPassword(request);
        if (result.contains("successfully")) {
            redirectAttributes.addFlashAttribute("success", result);
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", result);
            return "redirect:/reset-password?token=" + request.getToken();
        }
    }

    private void setJwtCookie(HttpServletResponse response, String token) {
        Cookie cookie = new Cookie("jwt_token", token);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(24 * 60 * 60); // 24 hours — matches JWT validity
        response.addCookie(cookie);
    }

    private void clearJwtCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie("jwt_token", "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
