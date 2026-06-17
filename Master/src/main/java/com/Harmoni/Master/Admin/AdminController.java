package com.Harmoni.Master.Admin;

import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final UserRepository userRepo;
    private final EventRepository eventRepo;
    private final EventRegistrationRepository registrationRepo;

    private static final int USER_PAGE_SIZE = 10;

    private boolean isAdmin(HttpSession session) {
        Object raw = session.getAttribute("userId");
        if (!(raw instanceof Long)) return false;
        Users u = userRepo.findById((Long) raw).orElse(null);
        return u != null && Integer.valueOf(3).equals(u.getRoleId());
    }

    // ── Dashboard ─────────────────────────────────────────────────────────────

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

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
        model.addAttribute("title", "Admin Dashboard");
        model.addAttribute("viewName", "admin/dashboard");
        return "base/base";
    }

    // ── User Management ───────────────────────────────────────────────────────

    @GetMapping("/users")
    public String userList(HttpSession session,
                           @RequestParam(defaultValue = "0") int page,
                           @RequestParam(value = "role", defaultValue = "ALL") String role,
                           @RequestParam(value = "search", required = false) String search,
                           Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        Pageable pageable = PageRequest.of(page, USER_PAGE_SIZE, Sort.by("createdAt").descending());
        Page<Users> users;

        boolean hasSearch = search != null && !search.isBlank();
        boolean allRoles  = "ALL".equals(role);

        if (hasSearch && allRoles) {
            users = userRepo.findByNameContainingIgnoreCase(search, pageable);
        } else if (hasSearch) {
            users = userRepo.findByRoleRoleNameAndNameContainingIgnoreCase(role, search, pageable);
        } else if (allRoles) {
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
        model.addAttribute("title", "User Management");
        model.addAttribute("viewName", "admin/users");
        return "base/base";
    }

    // ── Toggle user active / inactive ─────────────────────────────────────────

    @PostMapping("/users/{userId}/toggle")
    public String toggleUser(HttpSession session, @PathVariable Long userId, RedirectAttributes redirectAttrs) {
        if (!isAdmin(session)) return "redirect:/login";
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

    // ── Events list ───────────────────────────────────────────────────────────

    @GetMapping("/events")
    public String eventList(HttpSession session,
                            @RequestParam(defaultValue = "0") int page,
                            @RequestParam(value = "search", required = false) String search,
                            @RequestParam(value = "featured", defaultValue = "ALL") String featured,
                            Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        String  kw   = (search != null && !search.isBlank()) ? search : null;
        Boolean feat = "YES".equals(featured) ? Boolean.TRUE : "NO".equals(featured) ? Boolean.FALSE : null;
        Pageable pageable = PageRequest.of(page, 15, Sort.by("createdAt").descending());

        Page<Events> events;
        if (kw != null && feat != null) {
            events = eventRepo.findByEventNameContainingIgnoreCaseAndFeatured(kw, feat, pageable);
        } else if (kw != null) {
            events = eventRepo.findByEventNameContainingIgnoreCase(kw, pageable);
        } else if (feat != null) {
            events = eventRepo.findByFeatured(feat, pageable);
        } else {
            events = eventRepo.findAll(pageable);
        }

        List<Integer> pageNumbers = IntStream.rangeClosed(1, events.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("events",          events);
        model.addAttribute("totalPageList",    pageNumbers);
        model.addAttribute("currentPage",      events.getNumber() + 1);
        model.addAttribute("search",           search);
        model.addAttribute("selectedFeatured", featured);
        model.addAttribute("active", "events");
        model.addAttribute("title", "Event Management");
        model.addAttribute("viewName", "admin/events");
        return "base/base";
    }

    // ── Toggle event featured ─────────────────────────────────────────────────

    @PostMapping("/events/{eventId}/toggle-featured")
    public String toggleFeatured(HttpSession session, @PathVariable Long eventId,
                                 @RequestParam(value = "from", defaultValue = "dashboard") String from,
                                 RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        eventRepo.findById(eventId).ifPresent(e -> {
            e.setFeatured(e.getFeatured() == null || !e.getFeatured());
            eventRepo.save(e);
        });
        ra.addFlashAttribute("successMessage", "Featured status updated.");
        return "events".equals(from) ? "redirect:/admin/events" : "redirect:/admin/dashboard";
    }

    // ── Force-delete an event (admin override) ────────────────────────────────

    @PostMapping("/events/{eventId}/delete")
    public String deleteEvent(HttpSession session, @PathVariable Long eventId,
                              @RequestParam(value = "from", defaultValue = "events") String from,
                              RedirectAttributes redirectAttrs) {
        if (!isAdmin(session)) return "redirect:/login";
        try {
            eventRepo.deleteById(eventId);
            redirectAttrs.addFlashAttribute("successMessage", "Event deleted.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", "Delete failed: " + e.getMessage());
        }
        return "dashboard".equals(from) ? "redirect:/admin/dashboard" : "redirect:/admin/events";
    }
}
