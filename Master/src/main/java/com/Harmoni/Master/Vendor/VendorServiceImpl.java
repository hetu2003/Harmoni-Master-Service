package com.Harmoni.Master.Vendor;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.EventRegistration;
import com.Harmoni.Master.Entity.EventSubcategory;
import com.Harmoni.Master.Entity.EventWorkhand;
import com.Harmoni.Master.Entity.Users;
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
        Users user = userRepo.findByUsername(principal.getUsername());
        if (user == null) {
            throw new IllegalStateException("Company user not found");
        }
        return user;
    }

    @Override
    public Events findEventById(Long eventId) {
        Events event = eventRepo.findById(eventId).orElse(null);
        if (event == null) {
            throw new IllegalArgumentException("Event not found: " + eventId);
        }
        return event;
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
    public List<EventRegistration> getWorkhandRequestsForEvent(Events event) {
        return registrationRepo.findByEventOrderByEventWorkhnadIdDesc(event.getEventId());
    }

    @Override
    public List<EventRegistration> getApprovedRequestsForEvent(Events event) {
        return registrationRepo.findByEventAndRegistrationStatusTrueOrderByEventWorkhandEventWorkhnadIdAsc(event.getEventId());
    }

    @Override
    public List<EventRegistration> getWorkhandsForPayment(Events event) {
        return registrationRepo.findByEventAndRegistrationStatusTrue(event.getEventId());
    }

    @Override
    public int calculateTotalPrice(List<EventRegistration> approvedWorkhands) {
        return approvedWorkhands.stream()
                .mapToInt(r -> {
                    EventWorkhand ew = eventWorkhandRepo.findById(r.getEventWorkhand().longValue()).orElse(null);
                    return (ew != null && ew.getPrice() != null) ? ew.getPrice().intValue() : 0;
                })
                .sum();
    }

    @Override
    public void processWorkhandPayment(Long registrationId, int rating) {
        registrationService.processPayment(registrationId, rating);
        EventRegistration reg = registrationRepo.findById(registrationId).orElse(null);
        if (reg == null) {
            throw new IllegalArgumentException("Registration not found");
        }
        Users workhand = userRepo.findById(reg.getWorkhand().longValue()).orElse(null);
        if (workhand != null) {
            registrationService.sendPaymentEmail(workhand.getEmail());
        }
    }

    @Override
    public Users getWorkhandProfile(Long userId) {
        Users user = userRepo.findById(userId).orElse(null);
        if (user == null) {
            throw new IllegalArgumentException("User not found: " + userId);
        }
        return user;
    }

    @Override
    public List<EventRegistration> getWorkhandHistory(Users workhand) {
        return registrationRepo.findByWorkhandAndRegistrationStatusTrue(workhand.getUserId().intValue());
    }

    @Override
    public List<Map<String, Object>> getEventHistoryWithStats(Users company) {
        List<Events> allEvents = eventRepo.findByCompanyOrderByStartDatetimeDesc(company);
        List<Map<String, Object>> rows = new ArrayList<>();
        
        for (Events ev : allEvents) {
            long total    = registrationRepo.countByEvent(ev.getEventId());
            long approved = registrationRepo.countByEventAndRegistrationStatusTrue(ev.getEventId());
            long paid     = registrationRepo.countByEventAndPaymentStatusTrue(ev.getEventId());
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("event",    ev);
            row.put("total",    total);
            row.put("approved", approved);
            row.put("paid",     paid);
            rows.add(row);
        }
        return rows;
    }
}
