package com.example.spring.security.controllers;

import com.example.spring.security.models.Car;
import com.example.spring.security.repositories.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
//@RequestMapping("/car")
public class CarController {
    @Autowired
    public CarRepository carRepository;

    @GetMapping("/car")
    public String carList(Model model) {
        model.addAttribute("cars", carRepository.findAll());
        return "Car/carList";
    }
    @GetMapping("/addCar")
    public String addCarForm() {
        return "Car/carCreate";
    }

    @PostMapping("/car")
    public String add(@RequestParam String WIN_Number, @RequestParam String brand,
                      @RequestParam String model, @RequestParam String body,
                      @RequestParam String level, @RequestParam int year,
                      @RequestParam int mileage, @RequestParam String color,
                      @RequestParam String transmission, @RequestParam String drive,
                      @RequestParam int power, @RequestParam int price,
                      @RequestParam String status, @RequestParam String description,
                      @RequestParam String image, Map<String, Object> modelWeb) {

        Car car = new Car(WIN_Number, brand, model, body, level, year, mileage, color, transmission,
                drive, power, price, status, image, description);

        System.out.println("all is good");
        carRepository.save(car);
        Iterable<Car> cars = carRepository.findAll();
        System.out.println("all is good");
        modelWeb.put("cars", car);

        return "redirect:/car";
    }
}
