package com.example.spring.security.controllers;

import com.example.spring.security.models.*;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.repositories.UserRepository;
import com.example.spring.security.services.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Controller
//@RequestMapping("/car")
public class CarController {
    @Autowired
    private CarRepository carRepository;
    @Autowired
    private CarService carService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ContractRepository contractRepository;
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/car/all")
    public String carList(@RequestParam(required = false) int numberPage, Model model) {

        List<Car> cars = carRepository.findAll();
        Set<String> brandList =  cars.stream().map(Car::getBrand).collect(Collectors.toSet());

        model.addAttribute("countPage", cars.size()/10);
        model.addAttribute("cars", cars.stream().skip(10L *numberPage).limit(10).collect(Collectors.toList()));

        model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        return "Car/carList";
    }

    @GetMapping("/car")
    public String carListByClass(Model model) {
        List<Car> carList = carRepository.findAll();
        Set<String> brandList = carList.stream()
                .sorted(Comparator.comparing(Car::getBrand))
                .map(Car::getBrand)
                .collect(Collectors.toSet());

        model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        model.addAttribute("EconomyCar", carList.stream().filter(car -> car.getLevel().equals("Эконом")).limit(3).collect(Collectors.toList()));
        model.addAttribute("ComfortCar", carList.stream().filter(car -> car.getLevel().equals("Комфорт")).limit(3).collect(Collectors.toList()));
        model.addAttribute("BusinessCar", carList.stream().filter(car -> car.getLevel().equals("Бизнес")).limit(3).collect(Collectors.toList()));
        model.addAttribute("PremiumCar", carList.stream().filter(car -> car.getLevel().equals("Premium")).limit(3).collect(Collectors.toList()));
        model.addAttribute("SuvCar", carList.stream().filter(car -> car.getLevel().equals("Внедорожники")).limit(3).collect(Collectors.toList()));
        model.addAttribute("BusCar", carList.stream().filter(car -> car.getLevel().equals("Минивэны")).limit(3).collect(Collectors.toList()));
        model.addAttribute("UniqueCar", carList.stream().filter(car -> car.getLevel().equals("Уникальные авто")).limit(3).collect(Collectors.toList()));

        return "Car/carByClass";
    }
    @GetMapping("/addCar")
    public String addCarForm() {
        return "Car/carCreate";
    }

    @GetMapping("/car/delete")
    public String deleteCarPage(@RequestParam int id, Model model) {

        Car car = carRepository.findById(id);
        List<Contract> activeContract = contractRepository.findAll().stream()
                .filter(contract -> contract.getCar().getId() == id)
                .filter(contract1 -> !contract1.getStatus().equals(ContractCondition.COMPLETED.toString())
                        && !contract1.getStatus().equals(ContractCondition.CANCELED.toString())
                        && !contract1.getStatus().equals(ContractCondition.AWAITING_PAYMENT_FINE.toString())).collect(Collectors.toList());

        if (activeContract.size() != 0) {
            model.addAttribute("isHasActiveContract", true);
            model.addAttribute("contractId", activeContract.get(0).getId());
        }
        else {
            model.addAttribute("isHasActiveContract", false);
        }
        model.addAttribute("car", car);

        return "Car/carDelete";
    }

    @PostMapping("/car/delete")
    public String deleteCar(@RequestParam int id) {

        File fileToDelete = new File(uploadPath + "/" + carRepository.findById(id).getImage());


        if (fileToDelete.exists()) {
            fileToDelete.delete();
        }

        carRepository.deleteById(id);

        return "redirect:/car";
    }

    @GetMapping("/car/edit")
    public String editCarPage(@RequestParam int id, Model model) {

        model.addAttribute("carEdit", carRepository.findById(id));

        return "Car/carEdit";
    }

    @PostMapping("/car/edit")
    public String editCar(@Valid Car car, @RequestParam("newImage") MultipartFile file) throws IOException {

        if (file.getOriginalFilename().isEmpty()) {
            carRepository.save(car);
        } else {

            File fileToDelete = new File(uploadPath + "/" + carRepository.findById(car.getId()).getImage());

            if (fileToDelete.exists()) {
                fileToDelete.delete();
            }

            carService.addCar(car, file);
        }

        return "redirect:/car/details?id=" + car.getId();
    }

    @PostMapping("/car")
    public String add(@RequestParam("newImage") MultipartFile file,
                      @Valid Car carValid, BindingResult bindingResult, Model model) throws IOException {

//        if (bindingResult.hasErrors()) {
//            Map<String, String> errorMap = bindingResult.getFieldErrors().stream().collect(Collectors.toMap(
//                    fieldError -> fieldError.getField() + "Error",
//                    FieldError::getDefaultMessage
//            ));
//
//            model.addAttribute("map", errorMap);
//            model.addAttribute("car", carValid);
//
//            return "Car/carCreate";
//        } else {
            boolean ifAdded = carService.addCar(carValid, file);

            List<Car> cars = carRepository.findAll();

            Set<String> brandList =  cars.stream().map(Car::getBrand).collect(Collectors.toSet());

            model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));
            model.addAttribute("cars", cars);

            if (ifAdded) {
                return "redirect:/car";
            } else {
                return "redirect:/addCar";
            }
//        }
    }

    @GetMapping("/car/details")
    public String carDetails(@RequestParam int id, Model model, Principal user) {

        if (user != null) {
            User client = userRepository.findByUsername(user.getName());

            List<Contract> activeContract = contractRepository.findAll().stream()
                    .filter(contract -> contract.getUser().getId() == client.getId())
                    .filter(contract1 -> !contract1.getStatus().equals(ContractCondition.COMPLETED.toString())
                            && !contract1.getStatus().equals(ContractCondition.CANCELED.toString())
                            && !contract1.getStatus().equals(ContractCondition.AWAITING_PAYMENT_FINE.toString())).collect(Collectors.toList());

            if (activeContract.size() != 0) {
                model.addAttribute("isHasActiveContract", true);
            }
            else {
                model.addAttribute("isHasActiveContract", false);
            }
        }

        model.addAttribute("car", carRepository.findById(id));

        return "Car/carDetails";
    }

    @GetMapping("/findCar")
    public String findCar(@RequestParam(name = "PriceOT", required = false, defaultValue = "0") int PriceOT,
                          @RequestParam(name = "PriceDO", required = false, defaultValue = "0") int PriceDO,
                          @RequestParam(name = "ListBrand", required = false) String Brand,
                          @RequestParam(name = "ListTypeTransmition", required = false) String Transmition,
                          Model model) {
        boolean isPriceOt = PriceOT != 0;
        boolean isPriceDo = PriceDO != 0;

        List<Car> cars = carRepository.findAll();
        List<Car> carsByParam = new ArrayList<>();

        int PriceOt = isPriceOt ? PriceOT:0;
        int PriceDo = isPriceDo ? PriceDO:Integer.MAX_VALUE;


        if (!Brand.equals("") && !Transmition.equals("")) {
            carsByParam = cars.stream().filter(car ->
                            car.getBrand().equals(Brand) && car.getTransmission().equals(Transmition)
                            && car.getPrice() >= PriceOt && car.getPrice() <= PriceDo)
                    .collect(Collectors.toList());
            model.addAttribute("cars", carsByParam);
        } else if (!Brand.equals("")) {
            carsByParam = cars.stream().filter(car ->
                            car.getBrand().equals(Brand)
                                    && car.getPrice() >= PriceOt && car.getPrice() <= PriceDo)
                    .collect(Collectors.toList());
            model.addAttribute("cars", carsByParam);
        } else if (!Transmition.equals("")){
            carsByParam = cars.stream().filter(car ->
                            car.getTransmission().equals(Transmition)
                                    && car.getPrice() >= PriceOt && car.getPrice() <= PriceDo)
                    .collect(Collectors.toList());
            model.addAttribute("cars", carsByParam);
        } else {
            carsByParam = cars.stream().filter(car -> car.getPrice() >= PriceOt && car.getPrice() <= PriceDo).collect(Collectors.toList());
            model.addAttribute("cars", carsByParam);
        }
        Set<String> brandList =  cars.stream()
                .map(Car::getBrand)
                .collect(Collectors.toSet());

        model.addAttribute("countPage", 0);
        model.addAttribute("cars", carsByParam);


        model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        return "Car/carList";
    }

    @GetMapping("/carbyclass")
    public String carByClass(@RequestParam String carClass, @RequestParam int numberPage,  Model model) {

        List<Car> cars = carRepository.findAll().stream().filter(car -> car.getLevel().equals(carClass)).collect(Collectors.toList());

        model.addAttribute("countPage", cars.size()/10);
        model.addAttribute("cars", cars.stream().skip(10L *numberPage).limit(10).collect(Collectors.toList()));

        Set<String> brandList =  cars.stream().map(Car::getBrand).collect(Collectors.toSet());

        model.addAttribute("carsBrand", brandList.stream().sorted().collect(Collectors.toList()));

        return "Car/carList";
    }
}
