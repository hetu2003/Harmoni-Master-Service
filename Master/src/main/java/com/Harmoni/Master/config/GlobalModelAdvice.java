package com.Harmoni.Master.config;

import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalModelAdvice {

    private final UserRepository userRepository;

    @ModelAttribute
    public void addUserToModel(HttpSession session, Model model) {
        Object raw = session.getAttribute("userId");
        if (raw instanceof Long userId) {
            userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        }
    }
}
