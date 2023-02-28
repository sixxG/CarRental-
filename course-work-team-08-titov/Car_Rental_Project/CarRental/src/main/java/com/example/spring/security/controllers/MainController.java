package com.example.spring.security.controllers;

import com.example.spring.security.models.User;
import com.example.spring.security.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Map;

@Controller
public class MainController {

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String homePage(Model model, Principal principal) {

        if(principal != null) {
            model.addAttribute("name", principal.getName());
        } else {
            model.addAttribute("name", "Somebody");
        }

        return "Home/Main";
    }

    @GetMapping("/Boot")
    public String testSpringBootPage(@RequestParam(name = "name", required = false, defaultValue = "World") String name, Map<String, Object> model) {
        model.put("name", name);

        return "Home/Main";
    }
//
//    @GetMapping("/authenticated")
//    public String pageForAuthenticatedUsers(Principal principal) {
//
//        User user = userService.findByUsername(principal.getName());
//        Authentication a = SecurityContextHolder.getContext().getAuthentication();
//
////        return "secured part of web service " + user.getUsername() + " " + user.toString();
//        return "Main";
//    }
}
