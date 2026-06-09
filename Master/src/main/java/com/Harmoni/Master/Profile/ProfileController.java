package com.Harmoni.Master.Profile;

import com.Harmoni.Master.Auth.AuthService;
import com.Harmoni.Master.Auth.dto.UpdateProfileRequest;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.user.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final AuthService authService;
    private final UserService userService;

    @GetMapping
    public String showProfile(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        Users user = userService.findById(userId);
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        
        if (user.getRoleId() != null && user.getRoleId() == 2) { // Assuming 2 is Company
            model.addAttribute("viewName", "profile/company-profile-edit");
        } else {
            model.addAttribute("viewName", "profile/workhand-profile-edit");
        }
        return "base/base";
    }

    @PostMapping("/update")
    public String updateProfile(@ModelAttribute UpdateProfileRequest request,
                                @RequestParam(value = "profilePhoto", required = false) MultipartFile profilePhoto,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        String token = (String) session.getAttribute("userToken");
        if (token == null) {
            return "redirect:/login";
        }

        String result = authService.updateProfile(token, request, profilePhoto);

        if (result != null && result.contains("successfully")) {
            redirectAttributes.addFlashAttribute("success", result);
        } else {
            redirectAttributes.addFlashAttribute("error", result);
        }
        return "redirect:/profile";
    }
}
