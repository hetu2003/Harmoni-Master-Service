package com.Harmoni.Master.Profile;

import com.Harmoni.Master.Auth.AuthService;
import com.Harmoni.Master.Auth.dto.UpdateProfileRequest;
import com.Harmoni.Master.Dto.AjaxResponse;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.CityRepository;
import com.Harmoni.Master.Repository.StateRepository;
import com.Harmoni.Master.user.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final AuthService authService;
    private final UserService userService;
    private final StateRepository stateRepository;
    private final CityRepository cityRepository;

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
        model.addAttribute("states", stateRepository.findAllByOrderByStateNameDesc());
        if (user.getStateId() != null) {
            model.addAttribute("cities", cityRepository.findByStateRawIdOrderByCityNameAsc(user.getStateId()));
        }

        if (user.getRoleId() != null && user.getRoleId() == 2) {
            model.addAttribute("viewName", "profile/company-profile-edit");
        } else {
            model.addAttribute("viewName", "profile/workhand-profile-edit");
        }
        return "base/base";
    }

    @PostMapping(value = "/update", produces = "application/json")
    @ResponseBody
    public ResponseEntity<AjaxResponse> updateProfile(
            @ModelAttribute UpdateProfileRequest request,
            @RequestParam(value = "profilePhoto", required = false) MultipartFile profilePhoto,
            HttpSession session) {

        String token = (String) session.getAttribute("userToken");
        if (token == null) {
            return ResponseEntity.ok(new AjaxResponse(false, "Session expired. Please log in again.", "/login"));
        }

        String result = authService.updateProfile(token, request, profilePhoto);

        if (result != null && result.contains("successfully")) {
            // Refresh the user in session — reload from DB via userId
            return ResponseEntity.ok(new AjaxResponse(true, result, null));
        }
        return ResponseEntity.ok(new AjaxResponse(false, result != null ? result : "Update failed.", null));
    }
}
