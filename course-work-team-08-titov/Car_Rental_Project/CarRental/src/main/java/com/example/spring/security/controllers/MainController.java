package com.example.spring.security.controllers;

import com.example.spring.security.services.MainService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@Controller
public class MainController {
    private final MainService mainService;

    public MainController(MainService mainService) {
        this.mainService = mainService;
    }

    @GetMapping("/")
    public String homePage(Model model) {
       Map<String, Object> response = mainService.getDataForHomePage();

       model.addAttribute("cars", response.get("cars"));
       model.addAttribute("carsBrand", response.get("carsBrand"));
       return "Home/Main";
    }

    @GetMapping("/about")
    public String aboutPage() {
        return "Home/About";
    }

    @GetMapping("/contacts")
    public String contactsPage() {
        return "Home/Contacts";
    }
}
