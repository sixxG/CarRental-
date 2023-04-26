package com.example.spring.security.services;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public long count() {
        return userRepository.count();
    }
    public long countByRoleName(String roleName) {
        return userRepository.countByRoleName(roleName);
    }
    public List<User> findAll() {
        return userRepository.findAll();
    }
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    public User findById(int id) {
        return userRepository.findById(id);
    }
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public User findOldestUser() {
        return userRepository.findOldestUser();
    }
    public User findYoungestUser() {
        return userRepository.findYoungestUser();
    }
    public boolean addUser(int userId, Map<String, String> rolesList) {

        User user = userRepository.findById(userId);
        if (rolesList.get("userName") == null) {
            return false;
        }
        user.setUsername(rolesList.get("userName"));

        Set<String> roles = roleRepository.findAll().stream()
                .map(Role::getName)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key: rolesList.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(roleRepository.findByName(key));
            }
        }
        userRepository.save(user);

        if (userRepository.findByUsername(user.getUsername()) == null) {
            return false;
        }

        return true;
    }
    public void saveUser(User user) {
        userRepository.save(user);
    }
    public Map<String, Object> changePassword(Map<String, String> form, User user) {
        String oldPassword = form.get("oldPassword");
        String newPassword = form.get("newPassword");
        String confirmPassword = form.get("confirmPassword");

        Map<String, Object> response = new HashMap<>();

        boolean result = passwordEncoder.matches(oldPassword, user.getPassword());

        if (!result) {
            response.put("error", "Неправильный старый пароль!");
            response.put("response", false);
        } else if (newPassword.equals(confirmPassword)){
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(user);

            response.put("successPassword", "Пароль бы изменён!");
            response.put("response", true);
        } else {
            response.put("error", "Новый пароль и подтверждение пароля не совпадают!");
            response.put("response", false);
        }
        return response;
    }
    public double getAverageAge() {
        return userRepository.getAverageAge();
    }
}
