package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class PageController {

    @Autowired
    private EventRepository eventRepo;

    @GetMapping("/")
    public String index(Model model) {
        loadHomeEvents(model);
        return "index";
    }

    @GetMapping("/home")
    public String loadPage(Model model) {
        loadHomeEvents(model);
        return "index";
    }

    private void loadHomeEvents(Model model) {
        List<Events> events = eventRepo.findActiveEvents(LocalDateTime.now(), PageRequest.of(0, 8));
        model.addAttribute("upcomingEvents", events);
    }

    @GetMapping("/about")
    public String showAboutPage(Model model) {
        model.addAttribute("title", "About Us");
        model.addAttribute("viewName", "description/aboutus");
        return "base/base";
    }

    @GetMapping("/contact")
    public String showContactPage(Model model) {
        model.addAttribute("title", "Contact Us");
        model.addAttribute("viewName", "description/contact");
        return "base/base";
    }

    @GetMapping("/faq")
    public String showFaqPage(Model model) {
        model.addAttribute("title", "FAQ");
        model.addAttribute("viewName", "description/faq");
        return "base/base";
    }
}
