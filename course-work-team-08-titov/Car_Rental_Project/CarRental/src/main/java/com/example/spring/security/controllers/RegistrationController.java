package com.example.spring.security.controllers;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/registration")
    public String registration() {

        return "Account/Registration";
    }

    @PostMapping("/registration")
    public String addUser(User user, Map<String, Object> model) {
        User userFromDB = userRepository.findByUsername(user.getUsername());
        if (userFromDB != null) {
            model.put("message", "User exists!");
            return "Account/Registration";
        }

        if (userRepository.findByEmail(user.getEmail()) != null) {
            model.put("message", "Email is already used!");
            return "Account/Registration";
        }

//        String s = "USER";
        Collection<Role> roles = new ArrayList<>();
        roles.add(roleRepository.findByName("USER"));
//        roles.add(roleRepository.findByName("USER"));
        user.setRoles(roles);
        user.setPassword(String.valueOf(passwordEncoder.encode(user.getPassword())));

        userRepository.save(user);

        return "redirect:/login";
    }

}
