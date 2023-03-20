package com.example.spring.security.controllers;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.FeedbackRepository;
import com.example.spring.security.repositories.UserRepository;
import com.example.spring.security.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/account")
public class AccountController {
    @Autowired
    public UserService userService;
    @Autowired
    public UserRepository userRepository;
    @Autowired
    public FeedbackRepository feedbackRepository;

    @GetMapping
    public String userAccount (@RequestParam String name, Model model) {


        if (feedbackRepository.findByAuthor(name) != null) {
            Feedback usersFeedback = feedbackRepository.findByAuthor(name);
            model.addAttribute("usersFeedback", usersFeedback);
        }

        model.addAttribute("client", userRepository.findByUsername(name));

        return "User/userAccount";
    }

    @PostMapping
    public String saveAccount (@RequestParam Map<String, String> form,
                               @RequestParam("userId") User user, Model model) {

        user.setFio(form.get("fio"));
        user.setBirthDate(LocalDate.parse(form.get("birthDate")));
        user.setEmail(form.get("email"));
        user.setAddress(form.get("address"));
        user.setPhone(form.get("phone"));
        user.setDriverLicense(form.get("driverLicense"));

        userRepository.save(user);
        model.addAttribute("client", userRepository.findById(user.getId()));

        return "redirect:/account?name=" + user.getUsername();
    }
}
