package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Dto.WorkhnadRegistrationDto;
import com.Harmoni.Master.Entity.*;
import com.Harmoni.Master.Repository.EventRegistrationRepository;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.EventWorkhnadRepository;
import com.Harmoni.Master.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.*;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequiredArgsConstructor
public class HistoryController {

    private final EventRegistrationRepository registrationRepo;
    private final EventRepository             eventRepo;
    private final EventWorkhnadRepository     eventWorkhnadRepo;
    private final UserRepository              userRepo;

    private static final int PAGE_SIZE = 6;

    @GetMapping("/history")
    @PreAuthorize("hasRole('WORKHAND')")
    public String history(@RequestParam(value = "page", defaultValue = "0") int page,
                          @AuthenticationPrincipal UserDetails principal,
                          Model model) {

        Users currentUser = userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("User not found"));

        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        Page<EventRegistration> regPage =
                registrationRepo.findByWorkhand(currentUser.getUserId().intValue(), pageable);

        // Map each EventRegistration → WorkhnadRegistrationDto for JSP EL navigation
        List<WorkhnadRegistrationDto> dtos = regPage.getContent().stream().map(reg -> {
            Events ev = reg.getEvent() != null
                    ? eventRepo.findById(reg.getEvent().longValue()).orElse(null)
                    : null;
            EventWorkhand ew = reg.getEventWorkhand() != null
                    ? eventWorkhnadRepo.findById(reg.getEventWorkhand().longValue()).orElse(null)
                    : null;
            return new WorkhnadRegistrationDto(
                    reg.getRegistrationId(), null, ew, ev,
                    reg.getRegistrationDate(),
                    reg.isRegistrationStatus(),
                    reg.isPaymentStatus(),
                    reg.getRating());
        }).collect(Collectors.toList());

        Page<WorkhnadRegistrationDto> dtoPage =
                new PageImpl<>(dtos, pageable, regPage.getTotalElements());

        List<Integer> pageNumbers = IntStream.rangeClosed(1, dtoPage.getTotalPages())
                .boxed().collect(Collectors.toList());

        model.addAttribute("active", "history");
        model.addAttribute("registrations", dtoPage);
        model.addAttribute("totalPageList", pageNumbers);
        model.addAttribute("currentPage", dtoPage.getNumber() + 1);

        return "history";
    }
}
