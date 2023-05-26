package com.example.spring.security.services;

import com.example.spring.security.models.Car;
import com.example.spring.security.models.Contract;
import com.example.spring.security.models.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class ReportsService {
    private final ContractService contractService;
    private final CarService carService;
    private final UserService userService;

    public ReportsService(ContractService contractService, CarService carService, UserService userService) {
        this.contractService = contractService;
        this.carService = carService;
        this.userService = userService;
    }

    @Transactional
    public Map<String, Object> reportsByCars() {
        Map<String, Object> response = new HashMap<>();

        List<Object[]> mostRentalCar = contractService.findMostRentedCarWithCount();
        List<Object[]> leastRentalCar = carService.findNotRentalCars();

        if (leastRentalCar.size() == 0) {
            leastRentalCar = mostRentalCar.subList(mostRentalCar.size() - 3, mostRentalCar.size());
        } else {
            leastRentalCar = leastRentalCar.subList(0, 3);
        }
        if (mostRentalCar.size() >= 3) {
            mostRentalCar = mostRentalCar.subList(0, 3);
        }

        int countCars = (int) carService.count();
        int countFreeCars = carService.countByStatus("Свободна");
        int countBusyCars = carService.countByStatus("Забронирована");
        List<Object[]> countByCarTransmission = carService.countByCarTransmission();
        List<Object[]> countByCarDrive = carService.countByCarDrive();
        List<Object[]> countByCarBody = carService.countByCarBody();

        int averagePrice = carService.getAveragePrice();
        int averageYear = Year.now().getValue() - carService.getAverageYear();
        int averageMileage = carService.getAverageMileage();

        Car car = carService.findOldestCar();
        int maxYearCar = Year.now().getValue() - car.getYear();
        response.put("oldestCarId", car.getId());
        response.put("maxYearCar", maxYearCar);

        car = carService.findYoungestCar();
        int minYearCar = Year.now().getValue() -  car.getYear();
        response.put("youngestCarId", car.getId());
        response.put("minYearCar", minYearCar);

        car = carService.findCarByMaxPrice();
        int maxPrice = car.getPrice();
        response.put("maxPriceCarId", car.getId());
        response.put("maxPrice", maxPrice);

        car = carService.findCarByMinPrice();
        int minPrice = car.getPrice();
        response.put("minPriceCarId", car.getId());
        response.put("minPrice", minPrice);

        car = carService.findCarByMaxMileage();
        int maxMileage = car.getMileage();
        response.put("maxMileageCarId", car.getId());
        response.put("maxMileage", maxMileage);

        car = carService.findCarByMinMileage();
        int minMileage = car.getMileage();
        response.put("minMileageCarId", car.getId());
        response.put("minMileage", minMileage);

        List<Object[]> countCarsByLevel = carService.countByCarLevel();

        long countRentCarByPowerFirstGroup = contractService.countRentsByPower(0, 120);
        long countRentCarByPowerSecondGroup = contractService.countRentsByPower(120, 250);
        long countRentCarByPowerThirdGroup = contractService.countRentsByPower(250, 2500);

        List<Object[]> countRentCarByPower = Arrays.asList(
                new Object[] {"от 0 до 120", countRentCarByPowerFirstGroup},
                new Object[] {"от 120 до 250", countRentCarByPowerSecondGroup},
                new Object[] {"от 250 до 2500", countRentCarByPowerThirdGroup});

        response.put("countRentCarByPower", countRentCarByPower);

        response.put("averagePrice", averagePrice);
        response.put("averageYear", averageYear);
        response.put("averageMileage", averageMileage);

        response.put("carCounts", countCarsByLevel);

        response.put("countCars", countCars);
        response.put("countFreeCars", countFreeCars);
        response.put("countBusyCars", countBusyCars);
        response.put("countByCarTransmission", countByCarTransmission);
        response.put("countByCarDrive", countByCarDrive);
        response.put("countByCarBody", countByCarBody);

        response.put("bestCars", mostRentalCar);
        response.put("leastCars", leastRentalCar);

        return response;
    }
    @Transactional
    public Map<String, Object> reportsByContracts(Map<String, String> form) {
        Map<String, Object> response = new HashMap<>();

        int maxPriceRental = (int) Math.ceil(contractService.findMaxPrice());
        int idMaxPriceRental = contractService.findByPrice(maxPriceRental).getId();
        int minPriceRental = (int) Math.ceil(contractService.findMinPrice());
        int idMinPriceRental = contractService.findByPrice(minPriceRental).getId();
        int avgPriceRental = (int) Math.ceil(contractService.getAveragePrice());

        int countContracts = (int) contractService.count();
        List<Object[]> countContractsByStatus = contractService.countByStatus();
        List<Object[]> countByTypeReceipt = contractService.countByTypeReceipt();
        List<Object[]> countByTypeReturn = contractService.countByTypeReturn();
        List<String> additionalOptions = contractService.countByAdditionalOptions();
        long countOptional = 0;
        double percentVideoReg = 0;
        double percentAutoBox = 0;
        double percentKidsChair = 0;

        Map<String, Integer> counts = new HashMap<>();

        for (String option : additionalOptions) {
            String onlyOption = option.substring(0, option.length()-1);
            String[] parts = onlyOption.split(";");
            countOptional += parts.length;
            for (String part : parts) {
                part = part.trim();
                if (part.isEmpty()) {
                    continue;
                }
                String[] keyValue = part.split(":");
                String key = keyValue[0].trim();
                int value = Integer.parseInt(keyValue[1].trim());
                counts.put(key, counts.getOrDefault(key, 0) + value);
            }
        }

        List<Object[]> countByAdditionalOptions = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            Object[] row = new Object[]{entry.getKey(), entry.getValue()};
            countByAdditionalOptions.add(row);

            switch (entry.getKey()) {
                case "Видеорегистратор": {
                    percentVideoReg = Math.floor((double)(entry.getValue() * 100) / countOptional);
                    break;
                }
                case "Авто бокс": {
                    percentAutoBox = Math.floor((double)(entry.getValue() * 100) / countOptional);
                    break;
                }
                case "Детское кресло": {
                    percentKidsChair = Math.floor((double)(entry.getValue() * 100) / countOptional);
                    break;
                }
            }
        }

        response.put("countOptional", countOptional);
        response.put("percentVideoReg", percentVideoReg);
        response.put("percentAutoBox", percentAutoBox);
        response.put("percentKidsChair", percentKidsChair);

        if (countByTypeReceipt.size() >= 5) {
            countByTypeReceipt = countByTypeReceipt.subList(0, 5);
        }
        if (countByTypeReturn.size() >= 5) {
            countByTypeReturn = countByTypeReturn.subList(0, 5);
        }

        String dateStart = form.get("inputStart") != null && !form.get("inputStart").equals("") ? form.get("inputStart") : null;
        String dateEnd = form.get("inputEnd") != null && !form.get("inputEnd").equals("") ? form.get("inputEnd") : null;

        if (dateStart != null && dateEnd != null) {
            LocalDateTime start = LocalDateTime.parse(dateStart + "T00:00:00Z", DateTimeFormatter.ISO_DATE_TIME);
            LocalDateTime end = LocalDateTime.parse(dateEnd + "T00:00:00Z", DateTimeFormatter.ISO_DATE_TIME);
            List<Contract> contractsForPeriod = contractService.findByDateStartBetweenAndDateEndBetween(start, end);
            long resultPrice = (long) contractsForPeriod.stream()
                    .mapToDouble(Contract::getPrice)
                    .sum();
            response.put("contractsForPeriod", contractsForPeriod);
            response.put("resultPrice", resultPrice);
        }

        Calendar calendar = Calendar.getInstance();
        LocalDateTime firstDayActualMonth = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1, 1, 0, 0);
        LocalDateTime nowDayActualMonth = LocalDateTime.of(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH)+1, 28, 12, 0);
        int countRentalForActualMonth = contractService.findByDateStartBetweenAndDateEndBetween(firstDayActualMonth, nowDayActualMonth).size();

        List<Object[]> countContractsByFioManager = contractService.findManagerRentCountsAndTotalPriceByDateRange(firstDayActualMonth, nowDayActualMonth);

        String startPeriodForManagerRental = form.get("startPeriod") != null && !form.get("startPeriod").equals("") ? form.get("startPeriod") : null;
        String endPeriodForManagerRental = form.get("endPeriod") != null && !form.get("endPeriod").equals("") ? form.get("endPeriod") : null;

        if (startPeriodForManagerRental != null && endPeriodForManagerRental != null) {
            LocalDateTime start = LocalDateTime.parse(startPeriodForManagerRental + "T00:00:00Z", DateTimeFormatter.ISO_DATE_TIME);
            LocalDateTime end = LocalDateTime.parse(endPeriodForManagerRental + "T00:00:00Z", DateTimeFormatter.ISO_DATE_TIME);
            countContractsByFioManager = contractService.findManagerRentCountsAndTotalPriceByDateRange(start, end);
        }

        int countRentalsWithFine = contractService.countRentalsWithFine();

        response.put("countRentalsWithFine", countRentalsWithFine);
        response.put("firstDayActualMonth", firstDayActualMonth);
        response.put("nowDayActualMonth", nowDayActualMonth);

        response.put("maxPriceRental", maxPriceRental);
        response.put("idMaxPriceRental", idMaxPriceRental);
        response.put("minPriceRental", minPriceRental);
        response.put("idMinPriceRental", idMinPriceRental);
        response.put("avgPriceRental", avgPriceRental);

        response.put("countContracts", countContracts);
        response.put("countRentalForActualMonth", countRentalForActualMonth);
        response.put("countContractsByStatus", countContractsByStatus);
        response.put("countByTypeReceipt", countByTypeReceipt);
        response.put("countByTypeReturn", countByTypeReturn);
        response.put("countByAdditionalOptions", countByAdditionalOptions);
        response.put("countContractsByFioManager", countContractsByFioManager);

        return response;
    }
    @Transactional
    public Map<String, Object> reportsByClients(Map<String, String> form) {
        Map<String, Object> response = new HashMap<>();

        long countUsers = userService.count();
        long countClients = userService.countByRoleName("USER");
        long countManagers = userService.countByRoleName("MANAGER");
        long countAdmins = userService.countByRoleName("ADMIN");

        User user = userService.findOldestUser();
        long maxAgeClients = Year.now().getValue() - user.getBirthDate().getYear();

        response.put("oldestUser", user.getId());
        response.put("maxAgeClients", maxAgeClients);

        user = userService.findYoungestUser();
        long minAgeClients = Year.now().getValue() - user.getBirthDate().getYear();

        response.put("youngestUser", user.getId());
        response.put("minAgeClients", minAgeClients);

        long countRentWithFineFirstGroup = contractService.countRentWithPenaltyAndUserAgeInRange(20, 35);
        long countRentWithFineSecondGroup = contractService.countRentWithPenaltyAndUserAgeInRange(35, 50);
        long countRentWithFineThirdGroup = contractService.countRentWithPenaltyAndUserAgeInRange(50, 80);
        response.put("countRentWithFineFirstGroup", countRentWithFineFirstGroup);
        response.put("countRentWithFineSecondGroup", countRentWithFineSecondGroup);
        response.put("countRentWithFineThirdGroup", countRentWithFineThirdGroup);

        response.put("averageAge", userService.getAverageAge());
        response.put("countUsers", countUsers);
        response.put("countClients", countClients);
        response.put("countManagers", countManagers);
        response.put("countAdmins", countAdmins);

        return response;
    }
}
