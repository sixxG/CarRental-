package com.example.spring.security.controllers;

import com.example.spring.security.models.*;
import com.example.spring.security.repositories.CarRepository;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.repositories.UserRepository;
import com.example.spring.security.services.ContractService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/contract")
@PreAuthorize("isAuthenticated()")
public class ContractController {

    @Autowired
    private ContractRepository contractRepository;
    @Autowired
    private CarRepository carRepository;
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ContractService contractService;

    @GetMapping("")
    public String indexContractListForClient(Model model, Principal user) {

        User client = userRepository.findByUsername(user.getName());
        List<Contract> contracts = contractRepository.findAll()
                .stream().filter(contract -> contract.getUser().getId() == client.getId()).collect(Collectors.toList());

        if (contracts.size() != 0) {
            List<Contract> activeContract = contracts.stream()
                    .filter(contract1 -> !contract1.getStatus().equals(ContractCondition.COMPLETED.toString())
                            && !contract1.getStatus().equals(ContractCondition.CANCELED.toString())
                            && !contract1.getStatus().equals(ContractCondition.AWAITING_PAYMENT_FINE.toString())).collect(Collectors.toList());

            Car car = activeContract != null ? carRepository.findById(activeContract.get(0).getCar().getId()) : null;

            LocalDateTime dateStart = activeContract.get(0).getDateStart();
            LocalDateTime dateEnd = activeContract.get(0).getDateEnd();
            Duration duration = Duration.between(dateStart, dateEnd);

            long rentalHours = duration.toHours();

            model.addAttribute("rentalHours", rentalHours);
            model.addAttribute("car", car);
            model.addAttribute("activeContract", activeContract.get(0));
        } else {
            model.addAttribute("car", null);
            model.addAttribute("activeContract", null);
        }

        model.addAttribute("client", client);
        model.addAttribute("contracts", contracts);

        return "Contract/indexForClient";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/list")
    public String listContracts(Model model) {

        List<String> usersFIO = userRepository.findAll().stream()
                .filter(user -> user.getRoles().contains(new Role(2, "USER")))
                .map(User::getFio)
                .collect(Collectors.toList());

        Set<String> carsBrand = carRepository.findAll().stream()
                .map(Car::getBrand).collect(Collectors.toSet());

        List<Contract> contracts = contractRepository.findAll();

        model.addAttribute("users", usersFIO);
        model.addAttribute("cars", carsBrand);
        model.addAttribute("contracts", contracts);

        return "Contract/listContracts";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/search")
    public String searchContract(@RequestParam Map<String, String> form, Model model) {

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

        Set<String> carsBrand = carRepository.findAll().stream()
                .map(Car::getBrand).collect(Collectors.toSet());

        model.addAttribute("contracts", searchedContract);
        model.addAttribute("users", usersFIO);
        model.addAttribute("cars", carsBrand);

        return "Contract/listContracts";
    }

    @PostMapping("/create")
    public String createContractForm(@RequestParam Map<String, String> form, Model model, Principal user) {

        Car car = carRepository.findById(Integer.parseInt(form.get("car_id")));
        User client = userRepository.findByUsername(user.getName());
        model.addAttribute("car", car);
        model.addAttribute("client", client);
        model.addAttribute("dateStart", form.get("dateStart"));
        model.addAttribute("dateEnd", form.get("dateEnd"));

        return "Contract/contractCreate";
    }

    @PostMapping("/save")
    public String createContracts(@RequestParam Map<String, String> form, Model model) {

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

        String registrator = form.get("Registrator") != null ? form.get("Registrator") : "";
        String AutoBox = form.get("AutoBox") != null ? form.get("AutoBox") : "";
        String interest = form.get("interest") != null ? form.get("interest") : "";

        Start.delete(0, Start.length());

        if (!registrator.equals(""))
            Start.append("Видеорегистратор: 1; ");
        else Start.append(registrator);

        if (!AutoBox.equals(""))
            Start.append("Авто бокс: 1; ");
        else Start.append(AutoBox);

        if (!interest.equals("0"))
            Start.append("Детское кресло: ").append(interest).append("; ");

        double price = Double.parseDouble(form.get("Price"));

        Contract contract = new Contract(null, Start.toString(), dateStart, form.get("placeReceipt"), dateEnd,
                form.get("placeReturn"),price, ContractCondition.valueOf("NOT_CONFIRMED").toString(),
                form.get("Notes"), car, user);

        contractRepository.save(contract);
        userRepository.save(user);

        return "redirect:/contract";
    }

    @GetMapping("/details")
    public String detailsContract(@RequestParam int id, Model model) {

        Contract contract = contractRepository.findById(id);

        LocalDateTime dateStart = contract.getDateStart();
        LocalDateTime dateEnd = contract.getDateEnd();
        Duration duration = Duration.between(dateStart, dateEnd);

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd MMMM");

        Map<String, String> mapAddOpt = contractService.parseAdditionalOptions(contract.getAdditionalOptions());

        String countVideoReg = mapAddOpt.get("Видеорегистратор") != null ? mapAddOpt.get("Видеорегистратор") : "0";
        String countCarBox = mapAddOpt.get("Авто бокс") != null ? mapAddOpt.get("Авто бокс") : "0";
        String countKidChes = mapAddOpt.get("Детское кресло") != null ? mapAddOpt.get("Детское кресло") : "0";

        model.addAttribute("countVideoReg", countVideoReg);
        model.addAttribute("countCarBox", countCarBox);
        model.addAttribute("countKidChes", countKidChes);

        model.addAttribute("contract", contract);

        model.addAttribute("dayStart", dateStart.format(outputFormatter));
        model.addAttribute("dayEnd", dateEnd.format(outputFormatter));
        model.addAttribute("timeRent", duration.toDays());

        return "Contract/contractDetails";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/delete")
    public String deleteContract(@RequestParam int id, HttpServletRequest request) {

        contractRepository.deleteById(id);

        return "redirect:" + request.getHeader("referer");
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/edit")
    public String editContractForm(@RequestParam int id, Model model) {

        Contract contract = contractRepository.findById(id);

        LocalDateTime dateStart = contract.getDateStart();
        LocalDateTime dateEnd = contract.getDateEnd();
        Duration duration = Duration.between(dateStart, dateEnd);

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("dd MMMM");

        model.addAttribute("contract", contract);

        model.addAttribute("dayStart", dateStart.format(outputFormatter));
        model.addAttribute("dayEnd", dateEnd.format(outputFormatter));
        model.addAttribute("timeRent", duration.toDays());

        return "Contract/contractEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/edit")
    public String editContract(@Valid Contract contract) {

        Contract contractBeforeEdit = contractRepository.findById(contract.getId());

        contractBeforeEdit.setNote(contract.getNote());
        contractBeforeEdit.setFioManager(contract.getFioManager());

        contractRepository.save(contractBeforeEdit);

        return "redirect:details?id=" + contract.getId();
    }
}
