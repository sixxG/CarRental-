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
import org.springframework.mail.MailSendException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ContractRepository contractRepository;
    private final CarRepository carRepository;
    private final PasswordEncoder passwordEncoder;
    private final MailSender mailSender;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, ContractRepository contractRepository, CarRepository carRepository, PasswordEncoder passwordEncoder, MailSender mailSender) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.contractRepository = contractRepository;
        this.carRepository = carRepository;
        this.passwordEncoder = passwordEncoder;
        this.mailSender = mailSender;
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

    @Transactional(isolation = Isolation.READ_COMMITTED)
    public Map<String, Object> changeEmail(Map<String, String> form) {
        String oldEmail = form.get("oldEmail");
        String newEmail = form.get("newEmail");

        User user = userRepository.findById(Integer.parseInt(form.get("usersID")));
        Map<String, Object> response = new HashMap<>();

        boolean isEmailChanged = (newEmail != null && !newEmail.equals(oldEmail)) ||
                (oldEmail != null && !oldEmail.equals(newEmail));

        if (isEmailChanged) {
            user.setEmail(newEmail);

            if (!newEmail.equals("")) {
                user.setActivationCode(UUID.randomUUID().toString());
            }

            response.put("successEmail", "Почта была успешно изменена! Теперь вам необходимо её подтвердить!");
            response.put("oldEmail", newEmail);
            response.put("response", true);

            ExecutorService executorService = Executors.newFixedThreadPool(2);

            executorService.execute(() -> {
                userRepository.save(user);
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
                    try {
                        mailSender.send(user.getEmail(), "Код активации", message);
                    } catch (MailSendException exception) {
                        response.put("response", false);
                        response.put("error", "Opps! Что-то пошло не так! Попробуйте ещё раз.");
                    }
                }
            });

            executorService.shutdown();
        } else {
            response.put("response", false);
            response.put("error", "Opps! Что-то пошло не так! Попробуйте ещё раз.");
            response.put("oldEmail", oldEmail);
        }
        return response;
    }

    public double getAverageAge() {
        return userRepository.getAverageAge();
    }
}
