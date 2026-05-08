package com.Harmoni.Master.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/home")
    public String loadPage() {
        return "index";
    }

    @GetMapping("/login")
    public String showLoginPage(Model model) {
        // We tell base.jsp to include 'login.jsp' in the middle
        model.addAttribute("viewName", "login/login");
        return "base/base";
    }

    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        // We tell base.jsp to include 'register.jsp' in the middle
        model.addAttribute("viewName", "login/registration");
        return "base/base";
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
