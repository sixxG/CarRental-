package com.example.spring.security.controllers;

import com.example.spring.security.models.User;
import com.example.spring.security.services.RegistrationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class RegistrationController {

    private final RegistrationService registrationService;

    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @GetMapping("/registration")
    public String registration() {
        return "Account/Registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, Map<String, Object> model) {
        Map<String, Object> response = registrationService.addUser(user);
        model.put("message", response.get("message"));
        if ((boolean)response.get("response")) {
            return "redirect:/login";
        } else {
            return "Account/Registration";
        }
    }

}
