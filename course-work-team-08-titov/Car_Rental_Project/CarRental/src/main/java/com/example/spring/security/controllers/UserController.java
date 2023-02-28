package com.example.spring.security.controllers;

import com.example.spring.security.models.User;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
//only for admins
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {
    @Autowired
    public UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "User/userList";
    }

    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", roleRepository.findAll());

        return "User/userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam String userName,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {
        user.setUsername(userName);
        Set<String> roles = roleRepository.findAll().stream()
                .map(role -> role.getName())
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key: form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(roleRepository.findByName(key));
            }
        }

        userRepository.save(user);

        return "redirect:/user";
    }
}
