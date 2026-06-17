package com.Harmoni.Master.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.boot.webmvc.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        int code = 0;
        if (status != null) {
            code = Integer.parseInt(status.toString());
        }
        model.addAttribute("errorCode", code);
        model.addAttribute("title", "Page Not Found");
        model.addAttribute("viewName", "error/404");
        return "base/base";
    }
}
