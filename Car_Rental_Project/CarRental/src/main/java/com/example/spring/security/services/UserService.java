package com.example.spring.security.services;

import com.example.spring.security.models.Car;
import com.example.spring.security.models.Contract;
import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.repositories.RoleRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ContractRepository contractRepository;
    private final CarRepository carRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, ContractRepository contractRepository, CarRepository carRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.contractRepository = contractRepository;
        this.carRepository = carRepository;
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
        Pageable pageable = PageRequest.of(0, 1);
        return (User) userRepository.findOldestUser(pageable).getContent().get(0);
    }
    public User findYoungestUser() {
        Pageable pageable = PageRequest.of(0, 1);
        return (User) userRepository.findYoungestUser(pageable).getContent().get(0);
    }
    @Transactional
    public boolean editeUser(int userId, Map<String, String> rolesList) {

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
    @Transactional
    public void saveUser(User user) {
        userRepository.save(user);
    }
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void deleteUser(int userID) {
        if (userRepository.findById(userID) != null) {
            List<String> statuses = new ArrayList<>(Arrays.asList("Не подтверждён", "Подтверждён", "Действует", "Ожидает оплаты штрафа"));
            Contract contract = contractRepository.findByUserAndStatusIn(userRepository.findById(userID), statuses);
            if (contract != null) {
                contract.setStatus("Отменён");
                Car car = contract.getCar();
                car.setStatus("Свободна");
                carRepository.save(car);
                contractRepository.save(contract);
            }
            User deletedUser = userRepository.findById(6);
            User user = userRepository.findById(userID);
            contractRepository.setUserIfUserWasDeleted(deletedUser, user);
            userRepository.deleteById(userID);
        }
    }
    @Transactional
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
