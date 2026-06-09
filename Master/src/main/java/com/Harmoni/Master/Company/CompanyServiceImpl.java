package com.Harmoni.Master.Company;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import com.Harmoni.Master.Repository.EventRepository;
import com.Harmoni.Master.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CompanyServiceImpl implements CompanyService {

    private final UserRepository userRepo;
    private final EventRepository eventRepo;

    @Override
    public List<Users> searchCompanies(String search) {
        // Assuming there is a Role entity and a relationship in Users, 
        // the previous code was userRepo.findByRoleRoleNameAndNameContainingIgnoreCase(...)
        // I will use a placeholder or adapt based on the repository structure. 
        // Since I can't see UserRepository right now, I'll assume it exists as written previously.
        return userRepo.findByRoleRoleNameAndNameContainingIgnoreCase("COMPANY", search.trim());
    }

    @Override
    public List<Users> getAllCompanies() {
        return userRepo.findByRoleRoleName("COMPANY");
    }

    @Override
    public Users getCompanyById(Long userId) {
        return userRepo.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Company not found: " + userId));
    }

    @Override
    public List<Events> getUpcomingEventsForCompany(Users company) {
        return eventRepo.findByCompanyAndStartDatetimeAfterOrderByStartDatetime(company, LocalDateTime.now());
    }

    @Override
    public List<Events> getAllEventsForCompany(Users company) {
        return eventRepo.findByCompanyOrderByStartDatetimeDesc(company);
    }
}
