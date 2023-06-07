package com.example.spring.security.controllers;

import com.example.spring.security.models.User;
import com.example.spring.security.services.FeedbackService;
import com.example.spring.security.services.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.time.LocalDate;
import java.util.Map;

@Controller
@RequestMapping("/account")
@PreAuthorize("isAuthenticated()")
public class AccountController {

    public final UserService userService;
    public final FeedbackService feedbackService;

    public AccountController(UserService userService, FeedbackService feedbackService) {
        this.userService = userService;
        this.feedbackService = feedbackService;
    }

    @GetMapping
    public String userAccount (@RequestParam String name, Model model) {
        model.addAttribute("usersFeedback", feedbackService.findByAuthor(name));
        model.addAttribute("client", userService.findByUsername(name));

        return "User/userAccount";
    }

    @PostMapping
    public String saveAccount (@RequestParam Map<String, String> form,
                               @RequestParam("userId") User user, Model model) {
        user.setFio(form.get("fio"));
        user.setBirthDate(LocalDate.parse(form.get("birthDate")));
        user.setAddress(form.get("address"));
        user.setPhone(form.get("phone"));
        user.setDriverLicense(form.get("driverLicense"));

        userService.saveUser(user);
        model.addAttribute("client", userService.findById(user.getId()));

        return "redirect:/account?name=" + user.getUsername();
    }

    @GetMapping("/change_password")
    public String userChangePasswordForm(Model model) {

        model.addAttribute("errorPassword", null);

        return "User/userChangePassword";
    }

    @PostMapping("/change_password")
    public String userChangePassword(@RequestParam Map<String, String> form, Principal client, Model model) {

        User user = userService.findByUsername(client.getName());

        Map<String, Object> response = userService.changePassword(form, user);

        if ((boolean) response.get("response")) {
            model.addAttribute("successPassword", response.get("successPassword"));
        } else {
            model.addAttribute("error", response.get("error"));
        }
        return "User/userChangePassword";
    }

    @GetMapping("/change_email")
    public String getChangeEmailForm(Model model, Principal principal) {

        User user = userService.findByUsername(principal.getName());

        model.addAttribute("usersID", user.getId());
        model.addAttribute("userEmail", user.getEmail());

        return "User/userChangeEmail";
    }

    @PostMapping("/change_email")
    public String changeUsersEmail(@RequestParam Map<String, String> form, Model model) {

        Map<String, Object> response = userService.changeEmail(form);

        model.addAttribute("usersID", form.get("usersID"));
        model.addAttribute("userEmail", form.get("newEmail"));

        if ((boolean) response.get("response")) {
            model.addAttribute("successEmail", response.get("successEmail"));
        } else {
            model.addAttribute("error", response.get("error"));
        }
        return "User/userChangeEmail";
    }
}
