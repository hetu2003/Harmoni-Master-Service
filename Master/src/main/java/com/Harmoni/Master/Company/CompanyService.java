package com.Harmoni.Master.Company;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import java.util.List;

public interface CompanyService {
    List<Users> searchCompanies(String search);
    List<Users> getAllCompanies();
    Users getCompanyById(Long userId);
//    List<Events> getUpcomingEventsForCompany(Users company);
    List<Events> getAllEventsForCompany(Users company);
}
