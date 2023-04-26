package com.example.spring.security.services;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@Service
public class RegistrationService {
    private final UserService userService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;

    public RegistrationService(UserService userService, RoleService roleService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.roleService = roleService;
        this.passwordEncoder = passwordEncoder;
    }

    public Map<String, Object> addUser(User user) {
        Map<String, Object> response = new HashMap<>();
        response.put("response", true);

        User userFromDB = userService.findByUsername(user.getUsername());
        if (userFromDB != null) {
            response.put("message", "User exists!");
            response.put("response", false);
            return response;
        }

        if (userService.findByEmail(user.getEmail()) != null) {
            response.put("message", "Email is already used!");
            response.put("response", false);
            return response;
        }

        Collection<Role> roles = new ArrayList<>();
        roles.add(roleService.findByName("USER"));

        user.setRoles(roles);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userService.saveUser(user);

        return response;
    }
}
