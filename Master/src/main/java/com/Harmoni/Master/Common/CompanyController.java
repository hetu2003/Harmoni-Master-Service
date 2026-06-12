package com.Harmoni.Master.Common;

import com.Harmoni.Master.Company.CompanyService;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Entity.Users;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class CompanyController {

    private final CompanyService companyService;

    @GetMapping("/company")
    public String companyList(@RequestParam(value = "search", required = false) String search,
                              Model model) {

        List<Users> companies;
        if (search != null && !search.isBlank()) {
            companies = companyService.searchCompanies(search);
            model.addAttribute("search", search);
        } else {
            companies = companyService.getAllCompanies();
        }

        model.addAttribute("companies",  companies);
        model.addAttribute("totalCount", companies.size());
        model.addAttribute("active", "company");
        model.addAttribute("viewName", "User/company-list");
        return "base/base";
    }

    @GetMapping("/company/{userId}")
    public String companyProfile(@PathVariable Long userId, Model model) {

        Users company = companyService.getCompanyById(userId);
        List<Events> allEvents = companyService.getAllEventsForCompany(company);

        model.addAttribute("company",         company);
        model.addAttribute("upcomingEvents", allEvents);
        model.addAttribute("totalEvents",    allEvents.size());
        model.addAttribute("active", "company");
        model.addAttribute("viewName", "User/company-profile");
        return "base/base";
    }
}
