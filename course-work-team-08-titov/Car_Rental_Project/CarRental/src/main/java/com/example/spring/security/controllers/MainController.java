package com.example.spring.security.controllers;

import com.example.spring.security.models.Car;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.UserRepository;
import com.example.spring.security.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class MainController {

    private final CarRepository carRepository;

    public MainController(CarRepository carRepository) {
        this.carRepository = carRepository;
    }
    @GetMapping("/")
    public String homePage(Model model) {

        List<Car> cars = carRepository.findAll();
        Set<Car> popularCars = new HashSet<>();

        if (cars.size() != 0) {
            Random random = new Random();
            for (int i = 0; i < 3; i++) {
                popularCars.add(cars.get(random.nextInt(cars.size())));
            }
        }

        model.addAttribute("cars", popularCars);

        Set<String> brandList =  cars.stream().map(Car::getBrand).collect(Collectors.toSet());

        model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        return "Home/Main";
    }

    @GetMapping("/about")
    public String aboutPage(Model model,Principal principal) {

        return "Home/About";
    }

    @GetMapping("/contacts")
    public String contactsPage() {

        return "Home/Contacts";
    }
//
//    @GetMapping("/authenticated")
//    public String pageForAuthenticatedUsers(Principal principal) {
//
//        User user = userService.findByUsername(principal.getName());
//        Authentication a = SecurityContextHolder.getContext().getAuthentication();
//
////        return "secured part of web service " + user.getUsername() + " " + user.toString();
//        return "Main";
//    }
}
