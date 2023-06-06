package com.example.spring.security.services;

import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Service
public class RegistrationService {
    private final UserService userService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;
    private final MailSender mailSender;
    private final UserRepository userRepository;

    public RegistrationService(UserService userService, RoleService roleService, PasswordEncoder passwordEncoder, MailSender mailSender,
                               UserRepository userRepository) {
        this.userService = userService;
        this.roleService = roleService;
        this.passwordEncoder = passwordEncoder;
        this.mailSender = mailSender;
        this.userRepository = userRepository;
    }

    @Transactional
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
        user.setActivationCode(UUID.randomUUID().toString());

        ExecutorService executorService = Executors.newFixedThreadPool(2);

        executorService.execute(() -> {
            userService.saveUser(user);
        });

        executorService.execute(() -> {
            if (user.getEmail() != null && !user.getEmail().equals("")) {
                String message = String.format(
                        "Приветствую, %s! \n" +
                                "Добро пожаловать в приложения CarFY! Пожалуйста, для активации вашего аккаунта, перейдите по следующей ссылке" +
                                " http://localhost:8079/activate/%s",
                        user.getUsername(),
                        user.getActivationCode()
                );
                mailSender.send(user.getEmail(), "Код активации", message);
            }
        });

        return response;
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);

        if (user == null) {
            return false;
        }

        user.setActivationCode(null);
        userRepository.save(user);

        return true;
    }
}
