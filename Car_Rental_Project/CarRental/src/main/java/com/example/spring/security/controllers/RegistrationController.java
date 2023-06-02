package com.example.spring.security.controllers;

import com.example.spring.security.models.User;
import com.example.spring.security.services.RegistrationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.HashMap;
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
        Map<String, Object> response;
        try {
            response = registrationService.addUser(user);
            model.put("message", response.get("message"));
            if ((boolean)response.get("response")) {
                model.put("MailNotConfirmError", true);
                return "Account/ConfirmAccount";
            } else {
                return "Account/Registration";
            }
        } catch (Exception e) {
            model.put("message", "Opps! Что-то пошло не так! Пожалуйста, повторите попытку позже.");
            return "Account/Registration";
        }
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = registrationService.activateUser(code);

        if (isActivated) {
            model.addAttribute("message", "Почта подтверждена!");
        } else {
            model.addAttribute("message", "Почта уже подтверждена!!");
        }

        return "Account/Login";
    }
}
