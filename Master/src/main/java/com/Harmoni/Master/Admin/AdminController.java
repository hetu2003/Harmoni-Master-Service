package com.Harmoni.Master.Admin;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 *  Admin Dashboard.
 *
 *  GET  /admin/dashboard              → stats + recent activity
 *  GET  /admin/users                  → paginated user list with toggle
 *  POST /admin/users/{id}/toggle      → activate / deactivate a user
 *  POST /admin/events/{id}/delete     → hard-delete an event (admin only)
 */
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final UserRepository userRepo;
    private final EventRepository eventRepo;
    private final EventRegistrationRepository registrationRepo;

    private static final int USER_PAGE_SIZE = 10;

    // ── Dashboard ─────────────────────────────────────────────────────────────

    @GetMapping("/dashboard")
    public String dashboard(Model model) {

        // Stats
        long totalWorkhands   = userRepo.countByRoleRoleName("WORKHAND");
        long totalCompanies   = userRepo.countByRoleRoleName("COMPANY");
        long totalEvents      = eventRepo.count();
        long totalRegs        = registrationRepo.count();
        long approvedRegs     = registrationRepo.countByRegistrationStatusTrue();
        long paidRegs         = registrationRepo.countByPaymentStatusTrue();

        // Recent 10 registrations
        Page<EventRegistration> recentRegs = registrationRepo.findAll(
                PageRequest.of(0, 10, Sort.by("createdAt").descending()));

        // Recent 8 events
        Page<Events> recentEvents = eventRepo.findAll(
                PageRequest.of(0, 8, Sort.by("createdAt").descending()));

        model.addAttribute("totalWorkhands", totalWorkhands);
        model.addAttribute("totalCompanies", totalCompanies);
        model.addAttribute("totalEvents",    totalEvents);
        model.addAttribute("totalRegs",      totalRegs);
        model.addAttribute("approvedRegs",   approvedRegs);
        model.addAttribute("paidRegs",       paidRegs);
        model.addAttribute("recentRegs",     recentRegs.getContent());
        model.addAttribute("recentEvents",   recentEvents.getContent());
        model.addAttribute("active", "dashboard");
        return "admin/dashboard";
    }

    // ── User Management ───────────────────────────────────────────────────────

    @GetMapping("/users")
    public String userList(@RequestParam(defaultValue = "0") int page,
                           @RequestParam(value = "role", defaultValue = "ALL") String role,
                           @RequestParam(value = "search", required = false) String search,
                           Model model) {

        Pageable pageable = PageRequest.of(page, USER_PAGE_SIZE, Sort.by("createdAt").descending());
        Page<Users> users;

        if (search != null && !search.isBlank()) {
            // Simple: fetch all matching and paginate manually — fine for admin volume
            List<Users> matched = "ALL".equals(role)
                    ? userRepo.findAll().stream()
                    .filter(u -> u.getName() != null
                            && u.getName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList())
                    : userRepo.findByRoleRoleNameAndNameContainingIgnoreCase(role, search);
            int start = (int) pageable.getOffset();
            int end   = Math.min(start + USER_PAGE_SIZE, matched.size());
            users = new PageImpl<>(
                    start <= matched.size() ? matched.subList(start, end) : List.of(),
                    pageable, matched.size());
        } else if ("ALL".equals(role)) {
            users = userRepo.findAllByOrderByCreatedAtDesc(pageable);
        } else {
            users = userRepo.findByRoleRoleName(role, pageable);
        }

        List<Integer> pageNumbers = IntStream.rangeClosed(1, users.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("users",         users);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage",   users.getNumber() + 1);
        model.addAttribute("selectedRole",  role);
        model.addAttribute("search",        search);
        model.addAttribute("active", "users");
        return "admin/users";
    }

    // ── Toggle user active / inactive ─────────────────────────────────────────

    @PostMapping("/users/{userId}/toggle")
    public String toggleUser(@PathVariable Long userId, RedirectAttributes redirectAttrs) {
        Users user = userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));

        int newStatus = (user.getIsActive() != null && user.getIsActive() == 1) ? 0 : 1;
        user.setIsActive(newStatus);
        userRepo.save(user);

        String action = newStatus == 1 ? "activated" : "deactivated";
        redirectAttrs.addFlashAttribute("successMessage",
                "User '" + user.getName() + "' has been " + action + ".");
        return "redirect:/admin/users";
    }

    // ── Force-delete an event (admin override) ────────────────────────────────

    @PostMapping("/events/{eventId}/delete")
    public String deleteEvent(@PathVariable Long eventId, RedirectAttributes redirectAttrs) {
        try {
            eventRepo.deleteById(eventId);
            redirectAttrs.addFlashAttribute("successMessage", "Event deleted.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Delete failed: " + e.getMessage());
        }
        return "redirect:/admin/dashboard";
    }
}
