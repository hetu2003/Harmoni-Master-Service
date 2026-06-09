package com.Harmoni.Master.Vendor;

import com.Harmoni.Master.Dto.WorkhnadRegistrationDto;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import org.springframework.data.domain.Page;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;
import java.util.Map;

public interface VendorService {
    Users getCompanyFromPrincipal(UserDetails principal);
    Events findEventById(Long eventId);
    Page<Events> getMyEvents(Users company, int page, int pageSize);
    List<Events> searchMyEvents(Users company, String search);
    List<WorkhnadRegistrationDto> getWorkhandRequestsForEvent(Events event);
    List<WorkhnadRegistrationDto> getApprovedRequestsForEvent(Events event);
    List<WorkhnadRegistrationDto> getWorkhandsForPayment(Events event);
    int calculateTotalPrice(List<WorkhnadRegistrationDto> approvedWorkhands);
    void processWorkhandPayment(Long registrationId, int rating);
    Users getWorkhandProfile(Long userId);
    List<WorkhnadRegistrationDto> getWorkhandHistory(Users workhand);
    List<Map<String, Object>> getEventHistoryWithStats(Users company);
}
