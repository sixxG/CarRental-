package com.example.spring.security.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @RequestMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error, Model model) {

        if (error != null) {
            model.addAttribute("errorMessage", "В процессе авторизации произошла ошибка! \n Проверьте введённые данные, а также убедитесь, что почта подтверждена! ");
        }

        return "Account/Login";
    }
}
