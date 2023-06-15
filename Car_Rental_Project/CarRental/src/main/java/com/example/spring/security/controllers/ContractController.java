package com.example.spring.security.controllers;

import com.example.spring.security.models.*;
import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.services.CarService;
import com.example.spring.security.services.ContractService;

import com.example.spring.security.services.MailSender;
import com.example.spring.security.services.UserService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Controller
@RequestMapping("/contract")
@PreAuthorize("isAuthenticated()")
public class ContractController {
    private final ContractService contractService;
    private final CarService carService;
    private final UserService userService;
    private final ContractRepository contractRepository;
    private final MailSender mailSender;

    public ContractController(ContractService contractService, CarService carService, UserService userService,
                              ContractRepository contractRepository, MailSender mailSender) {
        this.contractService = contractService;
        this.carService = carService;
        this.userService = userService;
        this.contractRepository = contractRepository;
        this.mailSender = mailSender;
    }

    @GetMapping("")
    public String indexContractListForClient(@RequestParam int page, Model model, Principal user) {
        Map<String, Object> response = contractService.getDataForIndexContractListForClient(page, 5, user);

        model.addAttribute("countPage", response.get("countPage"));

        model.addAttribute("rentalHours", response.get("rentalHours") != null ? response.get("rentalHours").toString() : null);
        model.addAttribute("activeContract", response.get("activeContract"));

        model.addAttribute("client", response.get("client"));
        model.addAttribute("contracts", response.get("contracts"));

        model.addAttribute("canceledContracts", response.get("canceledContracts"));
        model.addAttribute("finishedContracts", response.get("finishedContracts"));
        model.addAttribute("finedContracts", response.get("finedContracts"));

        return "Contract/indexForClient";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @GetMapping("/list/all")
    public String listContracts(@RequestParam(defaultValue = "1") int page, @RequestParam(required = false) String status, Model model, Principal systemUser) {
        Map<String, Object> response;
        if (status == null) {
            response = contractService.getDataListContracts(page, 5, systemUser);
        } else {
            response = contractService.getDataListContractsByStatus(page, 5, status, systemUser);
        }

        model.addAttribute("countPage", response.get("countPage"));

        model.addAttribute("emptyFIO", response.get("emptyFIO"));

        model.addAttribute("users", response.get("users"));
        model.addAttribute("cars", response.get("cars"));
        model.addAttribute("contracts", response.get("contracts"));

        return "Contract/listContracts";
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/search")
    public String searchContract(@RequestParam Map<String, String> form, Model model) {
        Map<String, Object> response = contractService.searchContract(form);

        model.addAttribute("brand", form.get("CarBrand"));
        model.addAttribute("client", form.get("Client"));
        model.addAttribute("dateStart", form.get("DateStart"));
        model.addAttribute("dateEnd", form.get("DateEnd"));

        model.addAttribute("contracts", response.get("contracts"));
        model.addAttribute("users", response.get("users"));
        model.addAttribute("cars", response.get("cars"));

        return "Contract/listContracts";
    }

    @PostMapping("/create")
    public String createContractForm(@RequestParam Map<String, String> form, Model model, Principal user) {
        Car car = carService.findById(Integer.parseInt(form.get("car_id")));
        User client = userService.findByUsername(user.getName());
        model.addAttribute("car", car);
        model.addAttribute("client", client);
        model.addAttribute("dateStart", form.get("dateStart"));
        model.addAttribute("dateEnd", form.get("dateEnd"));

        return "Contract/contractCreate";
    }

    @PostMapping("/save")
    //@Transactional
    public String createContracts(@RequestParam Map<String, String> form, Model model) {
        Map<String, Object> response = contractService.createContract(form);

        if (response.get("errorDate") != null) {
            // Разница между датами меньше одного дня
            model.addAttribute("car", response.get("car"));
            model.addAttribute("client", response.get("client"));
            model.addAttribute("dateStart", response.get("dateStart"));
            model.addAttribute("dateEnd", response.get("dateEnd"));

            model.addAttribute("errorDate", response.get("errorDate"));
            model.addAttribute("priceRental", response.get("priceRental"));
            return "Contract/contractCreate";
        }

        return "redirect:/contract?page=1";
    }

    @GetMapping("/details")
    public String detailsContract(@RequestParam int id, Model model) {

        Contract contract = contractService.findById(id);

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

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/delete")
    public String deleteContract(@RequestParam int id, HttpServletRequest request) {
        contractService.deleteById(id);
        return "redirect:" + request.getHeader("referer");
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @GetMapping("/edit")
    public String editContractForm(@RequestParam int id, Model model) {

        Contract contract = contractService.findById(id);
        if (contract == null)
            return "redirect:/contract/list/all";

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

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/edit")
    public String editContract(@Valid Contract contract, BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return "redirect:details?id=" + contract.getId();
        }
        Contract contractBeforeEdit = contractService.findById(contract.getId());

        contractBeforeEdit.setNote(contract.getNote());
        contractBeforeEdit.setFioManager(contract.getFioManager());

        contractService.save(contractBeforeEdit);

        return "redirect:details?id=" + contract.getId();
    }

    @PostMapping("/confirm")
    public String confirmContract(@RequestParam int id, Principal user) {
        if (contractService.findById(id) == null)
            return "redirect:list/all?page=1";

        User manager = userService.findByUsername(user.getName());
        Contract contract = contractService.findById(id);

        // Создание ExecutorService с двумя потоками
        ExecutorService executorService = Executors.newFixedThreadPool(2);

        // Первый поток для отправки письма
        executorService.execute(() -> {
            String message = String.format(
                    "Уважаемый клиент, %s! \n" +
                            "Ваша заявка на аренду автомобиля %s на период с %s по %s подтверждена! \n" +
                            "Теперь вам необходимо оплатить аренду при получении автомобиля. \n" +
                            "%s \n" +
                            "Насладитесь поездкой!",
                    contract.getUser().getFio(),
                    contract.getCar().getBrand() + " " + contract.getCar().getModel(),
                    contract.getDateStart().toString(),
                    contract.getDateEnd().toString(),
                    " http://localhost:8079/"
            );
            mailSender.send(contract.getUser().getEmail(), "Заявка на аренду подтверждена", message);
        });

        // Второй поток для обновления контракта
        executorService.execute(() -> {
            contract.setFioManager(manager.getFio());
            contract.setStatus(ContractCondition.CONFIRMED.toString());
            contractService.save(contract);
        });

        // Завершение работы ExecutorService
        executorService.shutdown();

        return "redirect:list/all?page=1";
    }

    @PostMapping("/cancel")
    public String cancelContract(@RequestParam int id, @RequestParam Map<String, String> form, Principal user) {
        if (contractService.findById(id) == null || contractService.findById(id).getStatus().equals("Отменён"))
            return "redirect:/";
        String reasonCancel = form.get("otherReasonCancel") == null || form.get("otherReasonCancel").equals("")
                ? form.get("reasonCancel") : form.get("otherReasonCancel");

        Contract contract = contractService.findById(id);
        User client = userService.findByUsername(user.getName());

        contract.getCar().setStatus("Свободна");
        carService.saveCar(contract.getCar());

        contract.setStatus(ContractCondition.CANCELED.toString());

        if (contract.getNote() == null) {
            contract.setNote(reasonCancel);
        } else {
            contract.setNote(reasonCancel + "   |--Отмена--|    " + contract.getNote());
        }

        if (client.getRoles().contains(new Role(2, "USER"))) {
            contractService.save(contract);
            return "redirect:/contract?page=1";
        } else {
            ExecutorService executorService = Executors.newFixedThreadPool(2);

            executorService.execute(() -> {
                String message = String.format(
                        "Уважаемый клиент, %s! \n" +
                                "Ваша заявка на аренду автомобиля %s на период с %s по %s отменена! \n" +
                                "Проверьте корректность указанных данных и оставьте заявку повторно. \n" +
                                "%s",
                        contract.getUser().getFio(),
                        contract.getCar().getBrand() + " " + contract.getCar().getModel(),
                        contract.getDateStart().toString(),
                        contract.getDateEnd().toString(),
                        " http://localhost:8079/"
                );
                mailSender.send(contract.getUser().getEmail(), "Заявка на аренду отменена", message);
            });

            executorService.execute(() -> {
                contract.setFioManager(client.getFio());
                contractService.save(contract);
            });

            executorService.shutdown();

            return "redirect:list/all?page=1";
        }
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/start")
    public String startContract(@RequestParam int id, Principal user) {
        if (contractRepository.findById(id) == null)
            return "redirect:list/all?page=1";

        User manager = userService.findByUsername(user.getName());
        Contract contract = contractService.findById(id);

        contract.setFioManager(manager.getFio());
        contract.setStatus(ContractCondition.WORKING.toString());

        contractService.save(contract);

        return "redirect:list/all?page=1";
    }

    @PostMapping("/finish")
    public String finishContract(@RequestParam int id, Principal user) {
        if (contractService.findById(id) == null)
            return "redirect:/";

        User client = userService.findByUsername(user.getName());
        Contract contract = contractService.findById(id);

        contract.getCar().setStatus("Свободна");
        carService.saveCar(contract.getCar());

        if (client.getRoles().contains(new Role(2, "USER"))) {
            contract.setStatus(ContractCondition.COMPLETED.toString());
            contractService.save(contract);
            return "redirect:/contract?page=1";
        } else {
            ExecutorService executorService = Executors.newFixedThreadPool(2);

            executorService.execute(() -> {
                String message = String.format(
                        "Уважаемый клиент, %s! \n" +
                                "Ваша аренда автомобиля %s на период с %s по %s завершена! \n" +
                                "Вы можете оставить отзыв о наше компании! И конечно же мы ждём вас снова!\n" +
                                "%s",
                        contract.getUser().getFio(),
                        contract.getCar().getBrand() + " " + contract.getCar().getModel(),
                        contract.getDateStart().toString(),
                        contract.getDateEnd().toString(),
                        " http://localhost:8079/"
                );
                mailSender.send(contract.getUser().getEmail(), "Аренда завершена", message);
            });

            executorService.execute(() -> {
                contract.setFioManager(client.getFio());
                contract.setStatus(ContractCondition.COMPLETED.toString());
                contractService.save(contract);
            });

            executorService.shutdown();

            return "redirect:list/all?page=1";
        }
    }

    @PreAuthorize("hasAnyAuthority('ADMIN', 'MANAGER')")
    @PostMapping("/fine")
    public String fineContract(@RequestParam int id, @RequestParam Map<String, String> form, Principal user) {
        if (contractService.findById(id) == null)
            return "redirect:list/all?page=1";
        String reasonCancel = form.get("otherReasonCancel") == null || form.get("otherReasonCancel").equals("")
                ? form.get("reasonCancel") : form.get("otherReasonCancel");

        User manager = userService.findByUsername(user.getName());
        Contract contract = contractService.findById(id);

        if (contract.getNote() == null || contract.getNote().equals("")) {
            contract.setNote(reasonCancel);
        } else {
            contract.setNote(reasonCancel + "   |--Назначен штраф--|    " + contract.getNote());
        }

        ExecutorService executorService = Executors.newFixedThreadPool(2);

        executorService.execute(() -> {
            String message = String.format(
                    "Уважаемый клиент, %s! \n" +
                            "На вашу аренду автомобиля %s на период с %s по %s назначен штраф! \n" +
                            "Для получения подробной информации, посетите страницу \"Мои аренды\". \n" +
                            "Вам необходимо оплатить штраф не позднее чем через 10 дней после его установления! \n" +
                            "%s",
                    contract.getUser().getFio(),
                    contract.getCar().getBrand() + " " + contract.getCar().getModel(),
                    contract.getDateStart().toString(),
                    contract.getDateEnd().toString(),
                    " http://localhost:8079/"
            );
            mailSender.send(contract.getUser().getEmail(), "Назначен штраф на аренду", message);
        });

        executorService.execute(() -> {
            contract.setFioManager(manager.getFio());
            contract.setStatus(ContractCondition.AWAITING_PAYMENT_FINE.toString());
            contractService.save(contract);
        });

        executorService.shutdown();

        return "redirect:list/all?page=1";
    }
}
