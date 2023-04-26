package com.example.spring.security.services;

import com.example.spring.security.models.Car;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class MainService {
    private final CarService carService;

    public MainService(CarService carService) {
        this.carService = carService;
    }

    public Map<String, Object> getDataForHomePage() {
        Map<String, Object> response = new HashMap<>();

        List<Car> cars = carService.findAll();
        Set<Car> popularCars = new HashSet<>();

        if (cars.size() != 0) {
            Random random = new Random();
            while (popularCars.size() < 3) {
                popularCars.add(cars.get(random.nextInt(cars.size())));
            }
        }

        response.put("cars", popularCars);

        Set<String> brandList =  cars.stream().map(Car::getBrand).collect(Collectors.toSet());

        response.put("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        return response;
    }
}
