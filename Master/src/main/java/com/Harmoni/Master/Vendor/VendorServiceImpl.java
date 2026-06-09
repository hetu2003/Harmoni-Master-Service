package com.Harmoni.Master.Vendor;

import com.Harmoni.Master.Dto.WorkhnadRegistrationDto;
import com.Harmoni.Master.Entity.*;
import com.Harmoni.Master.EventRegistration.EventRegistrationService;
import com.Harmoni.Master.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class VendorServiceImpl implements VendorService {

    private final EventRepository eventRepo;
    private final EventRegistrationRepository registrationRepo;
    private final EventSubcategoryRepository eventSubcategoryRepo;
    private final UserRepository userRepo;
    private final EventWorkhnadRepository eventWorkhandRepo;
    private final EventRegistrationService registrationService;

    @Override
    public Users getCompanyFromPrincipal(UserDetails principal) {
        return userRepo.findByUsername(principal.getUsername())
                .orElseThrow(() -> new IllegalStateException("Company user not found"));
    }

    @Override
    public Events findEventById(Long eventId) {
        return eventRepo.findById(eventId)
                .orElseThrow(() -> new IllegalArgumentException("Event not found: " + eventId));
    }

    @Override
    public Page<Events> getMyEvents(Users company, int page, int pageSize) {
        Pageable pageable = PageRequest.of(page, pageSize);
        return eventRepo.findByCompanyOrderByStartDatetimeDesc(company, pageable);
    }

    @Override
    public List<Events> searchMyEvents(Users company, String search) {
        if ("all".equals(search)) return List.of();
        EventSubcategory sub = eventSubcategoryRepo.findById(Long.parseLong(search)).orElse(null);
        return (sub != null)
                ? eventRepo.findByCompanyAndEventSubcategoryOrderByStartDatetime(company, sub)
                : List.of();
    }

    @Override
    public List<WorkhnadRegistrationDto> getWorkhandRequestsForEvent(Events event) {
        return toDto(registrationRepo.findByEventOrderByRegistrationDateDesc(event.getId().intValue()));
    }

    @Override
    public List<WorkhnadRegistrationDto> getApprovedRequestsForEvent(Events event) {
        return toDto(registrationRepo.findByEventAndRegistrationStatusTrueOrderByEventWorkhandAsc(event.getId().intValue()));
    }

    @Override
    public List<WorkhnadRegistrationDto> getWorkhandsForPayment(Events event) {
        return toDto(registrationRepo.findByEventAndRegistrationStatusTrue(event.getId().intValue()));
    }

    @Override
    public int calculateTotalPrice(List<WorkhnadRegistrationDto> approvedWorkhands) {
        return approvedWorkhands.stream()
                .mapToInt(dto -> {
                    EventWorkhand ew = dto.getEventWorkhand();
                    return (ew != null && ew.getPrice() != null) ? ew.getPrice().intValue() : 0;
                })
                .sum();
    }

    @Override
    public void processWorkhandPayment(Long registrationId, int rating) {
        registrationService.processPayment(registrationId, rating);
        registrationRepo.findById(registrationId).ifPresent(reg -> {
            userRepo.findById(reg.getWorkhand().longValue())
                    .ifPresent(wh -> registrationService.sendPaymentEmail(wh.getEmail()));
        });
    }

    @Override
    public Users getWorkhandProfile(Long userId) {
        return userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));
    }

    @Override
    public List<WorkhnadRegistrationDto> getWorkhandHistory(Users workhand) {
        return toDto(registrationRepo.findByWorkhandAndRegistrationStatusTrue(workhand.getUserId().intValue()));
    }

    @Override
    public List<Map<String, Object>> getEventHistoryWithStats(Users company) {
        List<Events> allEvents = eventRepo.findByCompanyOrderByStartDatetimeDesc(company);
        List<Map<String, Object>> rows = new ArrayList<>();
        for (Events ev : allEvents) {
            long total    = registrationRepo.countByEvent(ev.getId().intValue());
            long approved = registrationRepo.countByEventAndRegistrationStatusTrue(ev.getId().intValue());
            long paid     = registrationRepo.countByEventAndPaymentStatusTrue(ev.getId().intValue());
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("event",    ev);
            row.put("total",    total);
            row.put("approved", approved);
            row.put("paid",     paid);
            rows.add(row);
        }
        return rows;
    }

    // ─── Helper ──────────────────────────────────────────────────────────────

    private List<WorkhnadRegistrationDto> toDto(List<EventRegistration> regs) {
        return regs.stream().map(reg -> {
            Users wh = reg.getWorkhand() != null
                    ? userRepo.findById(reg.getWorkhand().longValue()).orElse(null)
                    : null;
            EventWorkhand ew = reg.getEventWorkhand() != null
                    ? eventWorkhandRepo.findById(reg.getEventWorkhand().longValue()).orElse(null)
                    : null;
            Events ev = reg.getEvent() != null
                    ? eventRepo.findById(reg.getEvent().longValue()).orElse(null)
                    : null;
            return new WorkhnadRegistrationDto(
                    reg.getRegistrationId(), wh, ew, ev,
                    reg.getRegistrationDate(),
                    reg.isRegistrationStatus(),
                    reg.isPaymentStatus(),
                    reg.getRating());
        }).collect(Collectors.toList());
    }
}
