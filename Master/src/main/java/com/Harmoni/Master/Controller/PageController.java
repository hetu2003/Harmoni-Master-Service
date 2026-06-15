package com.Harmoni.Master.Controller;

import com.Harmoni.Master.Auth.client.AuthClient;
import com.Harmoni.Master.Auth.dto.EmailRequest;
import com.Harmoni.Master.Entity.Events;
import com.Harmoni.Master.Repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class PageController {

    @Autowired
    private EventRepository eventRepo;

    @Autowired
    private AuthClient authClient;

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

    @PostMapping("/contact-submit")
    public String submitContact(@RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String country,
                                @RequestParam String phone,
                                @RequestParam String message,
                                Model model) {
        try {
            String body = "Name: " + name + "\n"
                    + "Email: " + email + "\n"
                    + "Country: " + country + "\n"
                    + "Phone: " + phone + "\n\n"
                    + "Message:\n" + message;
            authClient.sendEmail(new EmailRequest("info@harmoni.com", "Contact Us: " + name, body));
            model.addAttribute("contactSuccess", true);
        } catch (Exception e) {
            model.addAttribute("contactError", true);
        }
        model.addAttribute("title", "Contact Us");
        model.addAttribute("viewName", "description/contact");
        return "base/base";
    }
}
