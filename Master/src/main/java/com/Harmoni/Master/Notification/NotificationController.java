package com.Harmoni.Master.Notification;

import com.Harmoni.Master.Entity.Notification;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;
    private final UserRepository userRepository;

    @GetMapping
    public String listNotifications(@AuthenticationPrincipal UserDetails principal, Model model) {
        Users user = getUser(principal);
        List<Notification> all = notificationService.getAll(user.getUserId());
        long unread = notificationService.countUnread(user.getUserId());
        model.addAttribute("notifications", all);
        model.addAttribute("unreadCount", unread);
        return "notification/notifications";
    }

    @PostMapping("/{id}/read")
    public String markRead(@PathVariable Long id,
                           @AuthenticationPrincipal UserDetails principal) {
        notificationService.markRead(id);
        return "redirect:/notifications";
    }

    @PostMapping("/read-all")
    @Transactional
    public String markAllRead(@AuthenticationPrincipal UserDetails principal) {
        Users user = getUser(principal);
        notificationService.markAllRead(user.getUserId());
        return "redirect:/notifications";
    }

    /** REST endpoint — badge count for navbar AJAX polling */
    @GetMapping("/count")
    @ResponseBody
    public long unreadCount(@AuthenticationPrincipal UserDetails principal) {
        Users user = getUser(principal);
        return notificationService.countUnread(user.getUserId());
    }

    private Users getUser(UserDetails principal) {
        return userRepository.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found"));
    }
}
