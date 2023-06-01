package com.example.spring.security.services;

import com.example.spring.security.models.Car;
import com.example.spring.security.models.Contract;
import com.example.spring.security.models.ContractCondition;
import com.example.spring.security.models.User;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CarService {

    @Value("${upload.path}")
    private String uploadPath;
    private final CarRepository carRepository;
    private final ContractRepository contractRepository;
    private final UserRepository userRepository;

    public CarService(CarRepository carRepository, ContractRepository contractRepository, UserRepository userRepository) {
        this.carRepository = carRepository;
        this.contractRepository = contractRepository;
        this.userRepository = userRepository;
    }

    public long count() {
        return carRepository.count();
    }
    public int countByStatus(String status) {
       return carRepository.countByStatus(status);
    }
    public List<Object[]> countByCarTransmission() {
        return carRepository.countByCarTransmission();
    }
    public List<Object[]> countByCarDrive() {
        return carRepository.countByCarDrive();
    }
    public List<Object[]> countByCarBody() {
        return carRepository.countByCarBody();
    }
    public List<Object[]> countByCarLevel() {
        return carRepository.countByCarLevel();
    }
    public int getAveragePrice() {
        return (int) Math.ceil(carRepository.getAveragePrice());
    }
    public int getAverageYear() {
        return carRepository.getAverageYear();
    }
    public int getAverageMileage() {
        return carRepository.getAverageMileage();
    }
    @Transactional
    public boolean saveCar(Car car, MultipartFile file) throws IOException {

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFileName));

            car.setImage(resultFileName);
        }

        carRepository.save(car);

        if (carRepository.findById(car.getId()) == null) {
            return false;
        }
        return true;
    }
    @Transactional
    public void saveCar(Car car) {
        carRepository.save(car);
    }
    public List<Object[]> findNotRentalCars() {
        return carRepository.findNotRentalCars();
    }
    public Car findById(int id) {
        return carRepository.findById(id);
    }
    public Car findOldestCar() {
        return carRepository.findFirstByOrderByYearAsc();
    }
    public Car findYoungestCar() {
        return carRepository.findFirstByOrderByYearDesc();
    }
    public Car findCarByMaxPrice() {
        return carRepository.findFirstByOrderByPriceDesc();
    }
    public Car findCarByMinPrice() {
        return carRepository.findFirstByOrderByPriceAsc();
    }
    public Car findCarByMaxMileage() {
        return carRepository.findFirstByOrderByMileageDesc();
    }
    public Car findCarByMinMileage() {
        return carRepository.findFirstByOrderByMileageAsc();
    }

    public List<Car> findAll() {
        return carRepository.findAll();
    }

    public Map<String, Object> getCarList(int numberPage, int countItemOnPage) {
        Map<String, Object> response = new HashMap<>();
        List<Car> cars = carRepository.findAll(PageRequest.of(numberPage, countItemOnPage)).stream().toList();
        Set<String> brandList =  carRepository.getCarsBrand();

        response.put("countPage", Math.ceil((double) carRepository.count()/countItemOnPage));
        response.put("cars", cars);
        response.put("carsBrand", brandList);

        return response;
    }
    public Map<String, Object> getCarListByStatus(String status) {
        Map<String, Object> response = new HashMap<>();
        List<Car> cars = carRepository.findAllByStatus(status);
        Set<String> brandList =  carRepository.getCarsBrand();

        response.put("cars", cars);
        response.put("carsBrand", brandList);

        return response;
    }

    public Map<String, Object> getCarsByClasses() {
        Map<String, Object> response = new HashMap<>();

        response.put("carsBrand", carRepository.getCarsBrand());

        response.put("EconomyCar", carRepository.findByLevel("Эконом",PageRequest.of(0, 3)).stream().toList());
        response.put("ComfortCar", carRepository.findByLevel("Комфорт",PageRequest.of(0, 3)).stream().toList());
        response.put("BusinessCar", carRepository.findByLevel("Бизнес",PageRequest.of(0, 3)).stream().toList());
        response.put("PremiumCar", carRepository.findByLevel("Premium",PageRequest.of(0, 3)).stream().toList());
        response.put("SuvCar", carRepository.findByLevel("Внедорожники",PageRequest.of(0, 3)).stream().toList());
        response.put("BusCar", carRepository.findByLevel("Минивэны",PageRequest.of(0, 3)).stream().toList());
        response.put("UniqueCar", carRepository.findByLevel("Уникальные авто",PageRequest.of(0, 3)).stream().toList());

        return response;
    }

    public Map<String, Object> getDataForDeleteCarPage(int id) {
        Map<String, Object> response = new HashMap<>();
        Car car = carRepository.findById(id);
        List<Contract> activeContract = contractRepository.findByCar(car).stream()
                .filter(contract1 -> !contract1.getStatus().equals(ContractCondition.COMPLETED.toString())
                        && !contract1.getStatus().equals(ContractCondition.CANCELED.toString())
                        && !contract1.getStatus().equals(ContractCondition.AWAITING_PAYMENT_FINE.toString())).toList();

        response.put("car", car);
        if (activeContract.size() != 0) {
            response.put("isHasActiveContract", true);
            response.put("contractId", activeContract.get(0).getId());
        }
        else {
            response.put("isHasActiveContract", false);
        }

        return response;
    }
    public Map<String, Object> getDataForDetailsCarPage(int id, Principal user) {
        Map<String, Object> response = new HashMap<>();
        if (user != null) {
            User client = userRepository.findByUsername(user.getName());

            List<Contract> activeContract = contractRepository.findByUser(client).stream()
                    .filter(contract1 -> !contract1.getStatus().equals(ContractCondition.COMPLETED.toString())
                            && !contract1.getStatus().equals(ContractCondition.CANCELED.toString())).toList();

            response.put("isHasActiveContract", (activeContract.size() != 0));
        }

        Contract contract = contractRepository.findByCarAndStatusNotAndStatusNot(carRepository.findById(id), "Завершён", "Отменён");

        response.put("car", findById(id));
        response.put("activeContract", contract);

        if (contract != null) {
            response.put("carRentingForDate", contract.getDateEnd());
        }

        return response;
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW, isolation = Isolation.READ_UNCOMMITTED)
    public synchronized void deleteCar(int id) {
        if (carRepository.findById(id) == null) {
            return;
        }
        Car carToDelete = carRepository.findById(id);
        File fileToDelete = new File(uploadPath + "/" + carToDelete.getImage());

        if (fileToDelete.exists()) {
            try {
                fileToDelete.delete();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }

        carRepository.deleteById(id);
    }

    @Transactional
    public void editeCar(Car car, MultipartFile file) throws IOException {
        if (file.getOriginalFilename().isEmpty()) {
            carRepository.save(car);
        }
        else {
            File fileToDelete = new File(uploadPath + "/" + carRepository.findById(car.getId()).getImage());

            if (fileToDelete.exists()) {
                fileToDelete.delete();
            }

            saveCar(car, file);
        }
    }

    public Map<String, Object> addCar(Car car, BindingResult bindingResult, MultipartFile file) throws IOException {
        Map<String, Object> response = new HashMap<>();
        if (bindingResult.hasErrors()) {
            Map<String, List<String>> errorMap = bindingResult.getFieldErrors()
                    .stream()
                    .collect(Collectors.groupingBy(
                            FieldError::getField,
                            Collectors.mapping(FieldError::getDefaultMessage, Collectors.toList())
                    ));
            response.put("ifError", true);
            response.put("map", errorMap);
            response.put("car", car);

        }
        else {
            boolean ifAdded = saveCar(car, file);

            response.put("ifAdded", ifAdded);
            response.put("ifError", false);

        }
        return response;
    }

    public Map<String, Object> findCar(Map<String, String> form) {
        Map<String, Object> response = new HashMap<>();
        int priceOT = form.get("PriceOT") == null || form.get("PriceOT").equals("") ? -1 : Integer.parseInt(form.get("PriceOT"));
        int priceDO = form.get("PriceDO") == null || form.get("PriceDO").equals("")  ? -1 : Integer.parseInt(form.get("PriceDO"));

        String brand = form.get("ListBrand");
        String transmission = form.get("ListTypeTransmition");

        String drive = form.get("typeDrive");
        String body = form.get("typeBody");

        int power = form.get("power") == null || form.get("power").equals("") ? -1 : Integer.parseInt(form.get("power"));
        int year = form.get("year") == null || form.get("year").equals("") ? -1 : Integer.parseInt(form.get("year"));
        int mileage = form.get("mileage") == null || form.get("mileage").equals("") ? -1 : Integer.parseInt(form.get("mileage"));

        List<Car> cars = findAll();
        List<Car> carsByParam = cars;

        if (priceOT > 0) {
            carsByParam = carsByParam.stream().filter(car -> car.getPrice() >= priceOT).collect(Collectors.toList());
        }
        if (priceDO > 0) {
            carsByParam = carsByParam.stream().filter(car -> car.getPrice() <= priceDO).collect(Collectors.toList());
        }
        if (power > 0) {
            carsByParam = carsByParam.stream().filter(car -> car.getPower() >= power).collect(Collectors.toList());
        }
        if (year > 0) {
            carsByParam = carsByParam.stream().filter(car -> car.getYear() >= year).collect(Collectors.toList());
        }
        if (mileage > 0) {
            carsByParam = carsByParam.stream().filter(car -> car.getMileage() <= mileage).collect(Collectors.toList());
        }
        if (brand != null && !brand.equals("")) {
            carsByParam = carsByParam.stream().filter(car -> car.getBrand().equals(brand)).collect(Collectors.toList());
        }
        if (transmission != null && !transmission.equals("")) {
            carsByParam = carsByParam.stream().filter(car -> car.getTransmission().equals(transmission)).collect(Collectors.toList());
        }
        if (drive != null && !drive.equals("")) {
            carsByParam = carsByParam.stream().filter(car -> car.getDrive().equals(drive)).collect(Collectors.toList());
        }
        if (body != null && !body.equals("")) {
            carsByParam = carsByParam.stream().filter(car -> car.getBody().equals(body)).collect(Collectors.toList());
        }

        response.put("countPage", Math.ceil((double) carsByParam.size()/10));
        response.put("cars", carsByParam);
        response.put("carsBrand", carRepository.getCarsBrand().stream().sorted().collect(Collectors.toList()));

        return response;
    }

    public Map<String, Object> findCarsByClass(String carClass, int numberPage, int countItemOnPage) {
        Map<String, Object> response = new HashMap<>();
        List<Car> cars = carRepository.findByLevel(carClass, PageRequest.of(numberPage, 10)).stream().toList();
        response.put("cars", cars);

        response.put("countPage", Math.ceil((double) carRepository.count()/countItemOnPage));
        response.put("carsBrand", carRepository.getCarsBrand());

        return response;
    }
}
