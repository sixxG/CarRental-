package com.example.spring.security.controllers;

import com.example.spring.security.repositories.ContractRepository;
import com.example.spring.security.services.ReportsService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reports")
@PreAuthorize("hasAuthority('ADMIN')")
public class ReportsController {

    private final ReportsService reportsService;
    private final ContractRepository contractRepository;

    public ReportsController(ReportsService reportsService,
                             ContractRepository contractRepository) {
        this.reportsService = reportsService;
        this.contractRepository = contractRepository;
    }

    @GetMapping("/cars")
    public String reportsByCars(Model model) {
        Map<String, Object> response = reportsService.reportsByCars();

        model.addAttribute("oldestCarId", response.get("oldestCarId"));
        model.addAttribute("maxYearCar", response.get("maxYearCar"));

        model.addAttribute("youngestCarId", response.get("youngestCarId"));
        model.addAttribute("minYearCar", response.get("minYearCar"));

        model.addAttribute("maxPriceCarId", response.get("maxPriceCarId"));
        model.addAttribute("maxPrice", response.get("maxPrice"));

        model.addAttribute("minPriceCarId", response.get("minPriceCarId"));
        model.addAttribute("minPrice", response.get("minPrice"));

        model.addAttribute("maxMileageCarId", response.get("maxMileageCarId"));
        model.addAttribute("maxMileage", response.get("maxMileage"));

        model.addAttribute("minMileageCarId", response.get("minMileageCarId"));
        model.addAttribute("minMileage", response.get("minMileage"));

        model.addAttribute("countRentCarByPower", response.get("countRentCarByPower"));

        model.addAttribute("averagePrice", response.get("averagePrice"));
        model.addAttribute("averageYear", response.get("averageYear"));
        model.addAttribute("averageMileage", response.get("averageMileage"));

        model.addAttribute("countCars", response.get("countCars"));
        model.addAttribute("countFreeCars", response.get("countFreeCars"));
        model.addAttribute("countBusyCars", response.get("countBusyCars"));

        //model.addAttribute("countByCarLevel", response.get("carCounts"));
        List<Object[]> countCarBy= (List<Object[]>) response.get("carCounts");
        List<Long> values = new ArrayList<>();
        for (Object[] o: countCarBy) {
            values.add((Long) o[1]);
        }

        model.addAttribute("countByCarLevelValues", values);

        //model.addAttribute("countByCarTransmission", response.get("countByCarTransmission"));

        countCarBy= (List<Object[]>) response.get("countByCarTransmission");
        List<String> keySet  = new ArrayList<>();
        values = new ArrayList<>();
        for (Object[] o: countCarBy) {
            keySet.add((String) o[0]);
        }
        for (Object[] o: countCarBy) {
            values.add((Long) o[1]);
        }

        model.addAttribute("countByCarTransmissionKeySet", keySet);
        model.addAttribute("countByCarTransmissionValues", values);

        //model.addAttribute("countByCarDrive", response.get("countByCarDrive"));
        countCarBy= (List<Object[]>) response.get("countByCarDrive");
        keySet = new ArrayList<>();
        values = new ArrayList<>();
        for (Object[] o: countCarBy) {
            keySet.add((String) o[0]);
        }
        for (Object[] o: countCarBy) {
            values.add((Long) o[1]);
        }

        model.addAttribute("countByCarDriveKeySet", keySet);
        model.addAttribute("countByCarDriveValues", values);

        countCarBy = (List<Object[]>) response.get("countByCarBody");

        keySet = new ArrayList<>();
        values = new ArrayList<>();
        for (Object[] o: countCarBy) {
            keySet.add((String) o[0]);
        }
        for (Object[] o: countCarBy) {
            values.add((Long) o[1]);
        }

        model.addAttribute("countByCarBodyKeySet", keySet);
        model.addAttribute("countByCarBodyValues", values);

        //model.addAttribute("countByCarBody", response.get("countByCarBody"));

        model.addAttribute("bestCars", response.get("bestCars"));
        model.addAttribute("leastCars", response.get("leastCars"));
        return "reports/carsReport";
    }

    @GetMapping("/contracts")
    public String reportsByContracts(@RequestParam Map<String, String> form,
                                     Model model) {
        Map<String, Object> response = reportsService.reportsByContracts(form);

        model.addAttribute("countOptional", response.get("countOptional"));
        model.addAttribute("percentVideoReg", response.get("percentVideoReg"));
        model.addAttribute("percentAutoBox", response.get("percentAutoBox"));
        model.addAttribute("percentKidsChair", response.get("percentKidsChair"));

        model.addAttribute("contractsForPeriod", response.get("contractsForPeriod"));
        model.addAttribute("resultPrice", response.get("resultPrice"));

        model.addAttribute("firstDayActualMonth", response.get("firstDayActualMonth"));
        model.addAttribute("nowDayActualMonth", response.get("nowDayActualMonth"));

        model.addAttribute("maxPriceRental", response.get("maxPriceRental"));
        model.addAttribute("idMaxPriceRental", response.get("idMaxPriceRental"));
        model.addAttribute("minPriceRental", response.get("minPriceRental"));
        model.addAttribute("idMinPriceRental", response.get("idMinPriceRental"));
        model.addAttribute("avgPriceRental", response.get("avgPriceRental"));

        model.addAttribute("countContracts", response.get("countContracts"));
        model.addAttribute("countRentalForActualMonth", response.get("countRentalForActualMonth"));
        model.addAttribute("countContractsByStatus", response.get("countContractsByStatus"));
        model.addAttribute("countByTypeReceipt", response.get("countByTypeReceipt"));
        model.addAttribute("countByTypeReturn", response.get("countByTypeReturn"));
        model.addAttribute("countByAdditionalOptions", response.get("countByAdditionalOptions"));
        model.addAttribute("countContractsByFioManager", response.get("countContractsByFioManager"));
        model.addAttribute("countRentalsWithFine", response.get("countRentalsWithFine"));
        return "reports/contractsReport";
    }

    @GetMapping("/clients")
    public String reportsByClients(@RequestParam Map<String, String> form,
                                     Model model) {
        Map<String, Object> response = reportsService.reportsByClients(form);

        model.addAttribute("oldestUser", response.get("oldestUser"));
        model.addAttribute("maxAgeClients", response.get("maxAgeClients"));

        model.addAttribute("youngestUser", response.get("youngestUser"));
        model.addAttribute("minAgeClients", response.get("minAgeClients"));

        model.addAttribute("countRentWithFineFirstGroup", response.get("countRentWithFineFirstGroup"));
        model.addAttribute("countRentWithFineSecondGroup", response.get("countRentWithFineSecondGroup"));
        model.addAttribute("countRentWithFineThirdGroup", response.get("countRentWithFineThirdGroup"));

        model.addAttribute("averageAge", response.get("averageAge"));
        model.addAttribute("countUsers", response.get("countUsers"));
        model.addAttribute("countClients", response.get("countClients"));
        model.addAttribute("countManagers", response.get("countManagers"));
        model.addAttribute("countAdmins", response.get("countAdmins"));
        return "reports/clientsReport";
    }
}
