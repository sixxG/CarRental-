package com.example.spring.security.controllers;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.services.RoleService;
import com.example.spring.security.services.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {

    private final UserService userService;
    private final RoleService roleService;

    public UserController(UserService userService, RoleService roleService) {
        this.userService = userService;
        this.roleService = roleService;
    }

    @GetMapping
    public String userList(Model model) {
        List<User> clients = userService.findAll();

        model.addAttribute("users", clients.stream().filter(user -> user.getRoles().contains(new Role(2, "USER"))).collect(Collectors.toList()));
        model.addAttribute("admins", clients.stream().filter(admin -> admin.getRoles().contains(new Role(1, "ADMIN"))).collect(Collectors.toList()));
        model.addAttribute("managers", clients.stream().filter(manager -> manager.getRoles().contains(new Role(3, "MANAGER"))).collect(Collectors.toList()));

        return "User/userList";
    }

    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", roleService.findAll());

        return "User/userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam Map<String, String> form,
            @RequestParam("userId") int userId, Model model) {

        boolean ifAdded = userService.editeUser(userId, form);

        if (ifAdded) {
            return "redirect:/user";
        } else {
            model.addAttribute("user", userService.findById(userId));
            model.addAttribute("roles", roleService.findAll());

            return "User/userEdit";
        }
    }

    @PostMapping("/delete")
    public String userDelete(@RequestParam int id) {
        userService.deleteUser(id);
        return "redirect:/user";
    }
}
