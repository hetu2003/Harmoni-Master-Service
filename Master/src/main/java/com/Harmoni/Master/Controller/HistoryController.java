package com.Harmoni.Master.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;


@Controller
@RequiredArgsConstructor
public class HistoryController {

    private final EventRegistrationRepository registrationRepo;
    private final FeedbackRepository feedbackRepo;
    private final UserRepository userRepo;

    private static final int PAGE_SIZE = 3;

    @GetMapping("/history")
    public String history(@RequestParam(value = "page", defaultValue = "0") int page,
                          @AuthenticationPrincipal UserDetails principal,
                          Model model) {

        User currentUser = userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found"));

        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        Page<EventRegistration> regPage = registrationRepo.findByWorkhand(currentUser, pageable);

        List<Feedback> feedbacks = feedbackRepo.findByWorkhand(currentUser);

        List<Integer> pageNumbers = IntStream.rangeClosed(1, regPage.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("active", "history");
        model.addAttribute("registrations", regPage);
        model.addAttribute("feedbacks", feedbacks);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage", regPage.getNumber() + 1);

        return "user/history";
    }
}
