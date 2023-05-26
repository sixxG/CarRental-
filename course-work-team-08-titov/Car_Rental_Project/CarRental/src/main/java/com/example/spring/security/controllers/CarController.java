package com.example.spring.security.controllers;

import com.example.spring.security.models.Car;
import com.example.spring.security.services.CarService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.security.Principal;
import java.util.Map;

@Controller
public class CarController {
    private final CarService carService;

    public CarController(CarService carService) {
        this.carService = carService;
    }

    @GetMapping("/car/all")
    public String getCarList(@RequestParam(required = false, defaultValue = "0") int numberPage,
                          @RequestParam(required = false,defaultValue = "") String status, Model model) {

        if (status.equals("")) {
            Map<String, Object> response = carService.getCarList(numberPage, 10);

            model.addAttribute("countPage", response.get("countPage"));
            model.addAttribute("cars", response.get("cars"));

            model.addAttribute("carsBrand", response.get("carsBrand"));
        } else {
            Map<String, Object> response = carService.getCarListByStatus(status);

            model.addAttribute("cars", response.get("cars"));
            model.addAttribute("carsBrand", response.get("carsBrand"));
            model.addAttribute("countPage", 0);
        }

        return "Car/carList";
    }

    @GetMapping("/car")
    public String carListByClass(Model model) {
        Map<String, Object> response = carService.getCarsByClasses();

        model.addAttribute("carsBrand", response.get("carsBrand"));

        model.addAttribute("EconomyCar", response.get("EconomyCar"));
        model.addAttribute("ComfortCar", response.get("ComfortCar"));
        model.addAttribute("BusinessCar", response.get("BusinessCar"));
        model.addAttribute("PremiumCar", response.get("PremiumCar"));
        model.addAttribute("SuvCar", response.get("SuvCar"));
        model.addAttribute("BusCar", response.get("BusCar"));
        model.addAttribute("UniqueCar", response.get("UniqueCar"));

        return "Car/carByClass";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @GetMapping("/addCar")
    public String addCarForm() {
        return "Car/carCreate";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @GetMapping("/car/delete")
    public String deleteCarPage(@RequestParam int id, Model model) {
        Map<String, Object> response = carService.getDataForDeleteCarPage(id);

        model.addAttribute("contractId", response.get("contractId"));
        model.addAttribute("isHasActiveContract", response.get("isHasActiveContract"));
        model.addAttribute("car", response.get("car"));

        return "Car/carDelete";
    }

    //@Transactional
    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/car/delete")
    public String deleteCar(@RequestParam int id) {
        carService.deleteCar(id);
        return "redirect:/car";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @GetMapping("/car/edit")
    public String editCarPage(@RequestParam int id, Model model) {
        model.addAttribute("carEdit", carService.findById(id));

        return "Car/carEdit";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/car/edit")
    public String editCar(@Valid Car car, BindingResult bindingResult, @RequestParam(value = "newImage", required = false) MultipartFile file) throws IOException {
        if (bindingResult.hasErrors()) {
            return "redirect:/car/edit?id=" + car.getId();
        }
        carService.editeCar(car, file);

        return "redirect:/car/details?id=" + car.getId();
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/car")
    public String add(@Valid Car car, BindingResult bindingResult,
                      @RequestParam("newImage") MultipartFile file, Model model) throws IOException {
        Map<String, Object> response = carService.addCar(car, bindingResult, file);
        if ((boolean) response.get("ifError")) {
            model.addAttribute("map", response.get("errorMap"));
            return "Car/carCreate";
        }
        else {
            model.addAttribute("carsBrand", response.get("carsBrand"));
            model.addAttribute("cars", response.get("cars"));

            if ((boolean)response.get("ifAdded")) {

                return "redirect:/car";
            } else {
                return "redirect:/addCar";
            }
        }
    }

    @GetMapping("/car/details")
    public String carDetails(@RequestParam int id, Model model, Principal user) {
        Map<String, Object> response = carService.getDataForDetailsCarPage(id, user);

        model.addAttribute("isHasActiveContract", response.get("isHasActiveContract"));

        model.addAttribute("car", response.get("car"));
        model.addAttribute("activeContract", response.get("activeContract"));

        model.addAttribute("dateEnd", response.get("carRentingForDate"));

        return "Car/carDetails";
    }

    @GetMapping("/findCar")
    public String findCar(@RequestParam Map<String, String> form, Model model) {
        Map<String, Object> response = carService.findCar(form);

        model.addAttribute("countPage", response.get("countPage"));
        model.addAttribute("cars", response.get("cars"));
        model.addAttribute("carsBrand", response.get("carsBrand"));

        return "Car/carList";
    }

    @GetMapping("/carbyclass")
    public String carByClass(@RequestParam String carClass, @RequestParam(defaultValue = "0") int numberPage,  Model model) {
        Map<String, Object> response = carService.findCarsByClass(carClass, numberPage, 10);
        model.addAttribute("cars", response.get("cars"));

        model.addAttribute("countPage", response.get("countPage"));
        model.addAttribute("carsBrand", response.get("carsBrand"));

        return "Car/carList";
    }

}
