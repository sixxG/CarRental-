package com.example.spring.security.controllers;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import com.example.spring.security.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
//only for admins
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {

    @Autowired
    public UserService userService;
    @Autowired
    public UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    @GetMapping
    public String userList(Model model, Principal principal) {

        List<User> clients = userRepository.findAll();

        model.addAttribute("users", clients.stream().filter(user -> user.getRoles().contains(new Role(2, "USER"))).collect(Collectors.toList()));
        model.addAttribute("admins", clients.stream().filter(admin -> admin.getRoles().contains(new Role(1, "ADMIN"))).collect(Collectors.toList()));
        model.addAttribute("managers", clients.stream().filter(manager -> manager.getRoles().contains(new Role(3, "MANAGER"))).collect(Collectors.toList()));

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
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user, Model model) {

        user.setUsername(form.get("userName"));

        boolean ifAdded = userService.addUser(user, form);

        if (ifAdded) {
            return "redirect:/user";
        } else {
            model.addAttribute("user", user);
            model.addAttribute("roles", roleRepository.findAll());

            return "User/userEdit";
        }
    }

}
