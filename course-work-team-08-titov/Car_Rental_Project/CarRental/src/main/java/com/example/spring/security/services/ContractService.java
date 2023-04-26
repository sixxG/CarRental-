package com.example.spring.security.services;

import com.example.spring.security.models.*;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.repositories.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ContractService {
    private final ContractRepository contractRepository;
    private final UserRepository userRepository;
    private final CarRepository carRepository;

    public ContractService(ContractRepository contractRepository, UserRepository userRepository,
                           CarRepository carRepository) {
        this.contractRepository = contractRepository;
        this.userRepository = userRepository;
        this.carRepository = carRepository;
    }

    public List<Object[]> findMostRentedCarWithCount() {
       return contractRepository.findMostRentedCarWithCount();
    }

    public long count() {
        return contractRepository.count();
    }
    public long countRentsByPower(int from, int to) {
        return contractRepository.countRentsByPower(from, to);
    }
    public List<Object[]> countByStatus() {
        return contractRepository.countByStatusWithStatus();
    }
    public List<Object[]> countByTypeReceipt() {
        return contractRepository.countByTypeReceipt();
    }
    public List<Object[]> countByTypeReturn() {
        return contractRepository.countByTypeReturn();
    }
    public List<String> countByAdditionalOptions() {
        return contractRepository.countByAdditionalOptions();
    }
    public int countRentWithPenaltyAndUserAgeInRange(int from, int to) {
        return contractRepository.countRentWithPenaltyAndUserAgeInRange(from, to);
    }
    public int countRentalsWithFine() {
        return contractRepository.countByNoteContaining("Штраф");
    }
    public double findMaxPrice() {
        return contractRepository.findMaxPrice();
    }
    public double findMinPrice() {
        return contractRepository.findMinPrice();
    }
    public Contract findByPrice(int maxPriceRental) {
        return contractRepository.findByPrice(maxPriceRental);
    }
    public Contract findById(int id) {
        return contractRepository.findById(id);
    }
    public List<Contract> findByDateStartBetweenAndDateEndBetween(LocalDateTime start, LocalDateTime end) {
        return contractRepository.findByDateStartBetweenAndDateEndBetween(start, end, start, end);
    }
    public List<Object[]> findManagerRentCountsAndTotalPriceByDateRange(LocalDateTime firstDayActualMonth, LocalDateTime nowDayActualMonth) {
        return contractRepository.findManagerRentCountsAndTotalPriceByDateRange(firstDayActualMonth, nowDayActualMonth);
    }
    public double getAveragePrice() {
        return contractRepository.getAveragePrice();
    }
    public void deleteById(int id) {
        contractRepository.deleteById(id);
    }
    public void save(Contract contractBeforeEdit) {
        contractRepository.save(contractBeforeEdit);
    }
    public Map<String, String> parseAdditionalOptions(String addOpt) {

        Map<String, String> mapAddOpt = new HashMap<>();

        if (addOpt.isEmpty()) {
            return mapAddOpt;
        }

        String[] additionalOptions = addOpt.split("; ");

        for (String o:
                additionalOptions) {
            String[] x = o.split(": ");
            mapAddOpt.put(x[0], x[1]);
        }

        return mapAddOpt;
    }

    public Map<String, Object> getDataForIndexContractListForClient(int page, int countItemOnPage, Principal user) {
        Map<String, Object> response = new HashMap<>();
        User client = userRepository.findByUsername(user.getName());

        long countRows = contractRepository.countByUser(client) == null ? 0 : contractRepository.countByUser(client);
        long countPages = (long) Math.ceil(countRows / (float) countItemOnPage);

        response.put("countPage", countPages);

        Page<Contract> contracts;

        if (page > countPages) {
            contracts = contractRepository.findByUser(client, PageRequest.of(0, countItemOnPage));
        } else {
            contracts = contractRepository.findByUser(client, PageRequest.of(page - 1, countItemOnPage));
        }

        if (countRows != 0) {
            List<String> conditions = Arrays.asList(
                    ContractCondition.NOT_CONFIRMED.toString(),
                    ContractCondition.CONFIRMED.toString(),
                    ContractCondition.WORKING.toString(),
                    ContractCondition.AWAITING_PAYMENT_FINE.toString()
            );
            Contract activeContract = contractRepository.findByUserAndStatusIn(client, conditions);

            if (activeContract != null) {
                LocalDateTime dateStart = activeContract.getDateStart();
                LocalDateTime dateEnd = activeContract.getDateEnd();
                Duration duration = Duration.between(dateStart, dateEnd);

                long rentalHours = duration.toHours();

                response.put("rentalHours", rentalHours);
                response.put("activeContract", activeContract);
            }

            response.put("client", client);
            response.put("contracts", contracts.toList());

            response.put("canceledContracts", contracts.stream()
                    .filter(contract -> contract.getStatus().equals(ContractCondition.CANCELED.toString()))
                    .collect(Collectors.toList()));
            response.put("finishedContracts", contracts.stream()
                    .filter(contract -> contract.getStatus().equals(ContractCondition.COMPLETED.toString()))
                    .collect(Collectors.toList()));
            response.put("finedContracts", contracts.stream()
                    .filter(contract -> contract.getStatus().equals(ContractCondition.AWAITING_PAYMENT_FINE.toString()))
                    .collect(Collectors.toList()));
        }
        return response;
    }

    public Map<String, Object> getDataListContracts(int page, int countItemOnPage, Principal systemUser) {
        Map<String, Object> response = new HashMap<>();
        User manager = userRepository.findByUsername(systemUser.getName());

        long countRows = contractRepository.count();
        long countPages = (long) Math.ceil(countRows / (float) countItemOnPage);

        response.put("countPage", countPages);

        Page<Contract> contracts;

        if (page > countPages) {
            contracts = contractRepository.findAll(PageRequest.of(0, countItemOnPage));
        } else {
            contracts = contractRepository.findAll(PageRequest.of(page - 1, countItemOnPage));

        }

        if (manager.getFio().isEmpty()) {
            response.put("emptyFIO", true);
        }

        List<String> usersFIO = userRepository.findAll().stream()
                .filter(user -> user.getRoles().contains(new Role(2, "USER")))
                .map(User::getFio)
                .collect(Collectors.toList());

        Set<String> carsBrand = carRepository.getCarsBrand();

        response.put("users", usersFIO);
        response.put("cars", carsBrand);
        response.put("contracts", contracts.toList());

        return response;
    }
    public Map<String, Object> getDataListContractsByStatus(int page, int countItemOnPage, String status, Principal systemUser) {
        Map<String, Object> response = new HashMap<>();
        User manager = userRepository.findByUsername(systemUser.getName());

        long countRows = contractRepository.countByStatus(status);
        long countPages = (long) Math.ceil(countRows / (float) countItemOnPage);

        response.put("countPage", countPages);

        Page<Contract> contracts;

        if (page > countPages) {
            contracts = contractRepository.findByStatus(status, PageRequest.of(0, countItemOnPage));
        } else {
            contracts = contractRepository.findByStatus(status, PageRequest.of(page - 1, countItemOnPage));
        }

        if (manager.getFio().isEmpty()) {
            response.put("emptyFIO", true);
        }

        List<String> usersFIO = userRepository.findAll().stream()
                .filter(user -> user.getRoles().contains(new Role(2, "USER")))
                .map(User::getFio)
                .collect(Collectors.toList());

        Set<String> carsBrand = carRepository.getCarsBrand();

        response.put("users", usersFIO);
        response.put("cars", carsBrand);
        response.put("contracts", contracts.toList());

        return response;
    }

    public Map<String, Object> searchContract(Map<String, String> form) {
        Map<String, Object> response = new HashMap<>();

        String client = !Objects.equals(form.get("Client"), "") ? form.get("Client") : null;
        String carBrand = !Objects.equals(form.get("CarBrand"), "") ? form.get("CarBrand") : null;
        LocalDateTime dateStart = !Objects.equals(form.get("DateStart"), "") ? LocalDateTime.parse(form.get("DateStart")+"T00:00") : null;
        LocalDateTime dateEnd = !Objects.equals(form.get("DateEnd"), "") ? LocalDateTime.parse(form.get("DateEnd")+"T00:00") : null;

        List<Contract> contracts = contractRepository.findAll();

        List<Contract> searchedContract = contracts.stream()
                .filter(contract -> client == null || contract.getUser().getFio().equals(client))
                .filter(contract -> carBrand == null || contract.getCar().getBrand().equals(carBrand))
                .filter(contract -> dateStart == null || contract.getDateStart().isAfter(dateStart) || contract.getDateStart().isEqual(dateStart))
                .filter(contract -> dateEnd == null || contract.getDateEnd().isBefore(dateEnd) || contract.getDateEnd().isEqual(dateEnd))
                .collect(Collectors.toList());

        List<String> usersFIO = userRepository.findAll().stream()
                .filter(user -> user.getRoles().contains(new Role(2, "USER")))
                .map(User::getFio)
                .collect(Collectors.toList());

        Set<String> carsBrand = carRepository.getCarsBrand();

        response.put("contracts", searchedContract);
        response.put("users", usersFIO);
        response.put("cars", carsBrand);

        return response;
    }

    public Map<String, Object> createContract(Map<String, String> form) {
        Map<String, Object> response = new HashMap<>();

        User user = userRepository.findByUsername(form.get("userName"));
        Car car = carRepository.findById(Integer.parseInt(form.get("car_id")));

        user.setFio(form.get("FIO_Customer"));
        user.setEmail(form.get("email"));
        user.setPhone(form.get("phone"));
        user.setAddress(form.get("address"));
        user.setDriverLicense(form.get("driverLicense"));

        String dateStartStr = form.get("Date_Start");
        String dateEndStr = form.get("Date_End");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        StringBuilder Start= new StringBuilder(dateStartStr.substring(0, 10));
        Start.append(" ");
        Start.append(dateStartStr.substring(11, 16));

        StringBuilder End= new StringBuilder(dateEndStr.substring(0, 10));
        End.append(" ");
        End.append(dateEndStr.substring(11, 16));

        LocalDateTime dateStart = LocalDateTime.parse(Start, formatter);
        LocalDateTime dateEnd = LocalDateTime.parse(End, formatter);

        Duration duration = Duration.between(dateStart, dateEnd);

        int registrator = form.get("Registrator") != null ? Integer.parseInt(form.get("Registrator")) : 0;
        int AutoBox = form.get("AutoBox") != null ? Integer.parseInt(form.get("AutoBox")) : 0;
        int interest = form.get("interest") != null ? Integer.parseInt(form.get("interest")) : 0;

        int deliveryPrice = form.get("DeliveryPrice") != null ? Integer.parseInt(form.get("DeliveryPrice")) : 0;

        double dateRental = Math.round(Duration.between(dateStart, dateEnd).toHours() / 24f*10.0)/10.0;;

        double priceRental = car.getPrice() * dateRental
                + registrator * dateRental
                + AutoBox * dateRental
                + interest * 100 * dateRental
                + deliveryPrice;
        double price = Double.parseDouble(form.get("Price"));

        if (duration.toDays() < 1 || priceRental > price+100) {
            // Разница между датами меньше одного дня
            response.put("car", car);
            response.put("client", user);
            response.put("dateStart", dateStart);
            response.put("dateEnd", dateEnd);

            response.put("errorDate", "Вы можете арендовать автомобиль на срок ОТ 1 дня!");
            if (priceRental < price)
                response.put("priceRental", "Произошла ошибка при расчёте цены аренда!!");
            return response;
        }

        Start.delete(0, Start.length());

        if (registrator != 0)
            Start.append("Видеорегистратор: 1; ");
        else Start.append(registrator);

        if (AutoBox != 0)
            Start.append("Авто бокс: 1; ");
        else Start.append(AutoBox);

        if (interest != 0)
            Start.append("Детское кресло: ").append(interest).append("; ");

        String placeReceipt;
        if (form.get("placeReceipt").equals("Свой вариант")) {
            placeReceipt = form.get("placeReceiptYourselfOption");
        } else {
            placeReceipt = form.get("placeReceipt");
        }

        String placeReturn;
        if (form.get("placeReturn").equals("Свой вариант")) {
            placeReturn = form.get("placeReturnYourselfOption");
        } else {
            placeReturn = form.get("placeReturn");
        }

        Contract contract = new Contract(null, Start.toString(), dateStart, placeReceipt, dateEnd,
                placeReturn, price, ContractCondition.valueOf("NOT_CONFIRMED").toString(),
                form.get("Notes"), car, user);

        car.setStatus("Забронирована");

        carRepository.save(car);
        contractRepository.save(contract);
        userRepository.save(user);

        return response;
    }

}
