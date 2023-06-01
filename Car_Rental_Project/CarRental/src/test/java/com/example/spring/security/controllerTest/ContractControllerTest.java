package com.example.spring.security.controllerTest;

import com.example.spring.security.models.Car;
import com.example.spring.security.models.Contract;
import com.example.spring.security.models.Role;
import com.example.spring.security.models.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/ContractControllerTest/create-contract-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/ContractControllerTest/create-contract-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = "/scripts/CarControllerTest/remove-auto_increment-before.sql", executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@WithUserDetails("admin")
public class ContractControllerTest {

    @Autowired
    private MockMvc mockMvc;

    public static User getUser() {
        Collection<Role> roles = new ArrayList<>();
        roles.add(new Role(2, "USER"));
        return new User(1, "user1", "$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.",
                "user1@mail.ru", "Петров Петр Петрович", LocalDate.parse("1990-01-01"), "Владимир ул.Горького д.3",
                "+8 800 555 3535", "1234 5678", roles);
    }

    public static List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        return cars;
    }

    public static List<Contract> getAllContracts() {
        List<Contract> contracts = new ArrayList<>();
        List<Car> cars = getAllCars();
        User user = getUser();

        contracts.add(new Contract(1, "Сидоров Виктор Сергеевич", "Видеорегистратор: 1; ", LocalDateTime.parse("2023-04-30T15:00:00"),
                "Улица Кирова 7", LocalDateTime.parse("2023-05-11T10:00:00"), "Железнодорожный вокзал", 55000, "Действует", "",
                cars.get(1),user));
        contracts.add(new Contract(2, "Сидоров Виктор Сергеевич", "Детское кресло: 1; Видеорегистратор: 1; ", LocalDateTime.parse("2023-03-26T12:00:00"),
                "Офис", LocalDateTime.parse("2023-03-30T09:00:00"), "Офис", 45000, "Завершён",
                "Штраф: не полный бак. Помойте авто перед выдачей, у меня аллергия на пыль", cars.get(3), user));
        contracts.add(new Contract(3, "Сидоров Виктор Сергеевич", "Видеорегистратор: 1; ", LocalDateTime.parse("2023-03-25T15:00:00"),
                "Улица Кирова 7", LocalDateTime.parse("2023-04-01T10:00:00"), "Железнодорожный вокзал", 55000, "Завершён", "",
                cars.get(4), user));
        contracts.add(new Contract(4, "Сидоров Виктор Сергеевич", "Детское кресло: 3; Авто бокс: 1; Видеорегистратор: 1; ", LocalDateTime.parse("2023-03-29T10:00:00"),
                "Улица Пушкина дом Колотушкина", LocalDateTime.parse("2023-04-05T15:00:00"), "Автовокзал", 70000, "Отменён",
                "Хочу летающую машину", cars.get(0), user));

        return contracts;
    }

    @Test
    public void indexContractListForClientPageTest() throws Exception {
        User user = getUser();
        List<Contract> contracts = getAllContracts();

        List<Contract> canceledContracts =  new ArrayList<>();
        List<Contract> finishedContracts =  new ArrayList<>();

        canceledContracts.add(contracts.get(3));
        finishedContracts.add(contracts.get(1));
        finishedContracts.add(contracts.get(2));

        this.mockMvc.perform(get("/contract")
                        .param("page", "1")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/indexForClient"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("activeContract", contracts.get(0)))
                .andExpect(model().attribute("client", user))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("canceledContracts", canceledContracts))
                .andExpect(model().attribute("finishedContracts", finishedContracts))
                .andExpect(model().attribute("finedContracts", new ArrayList<>()));

        this.mockMvc.perform(get("/contract")
                        .param("page", "2")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/indexForClient"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("activeContract", contracts.get(0)))
                .andExpect(model().attribute("client", user))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("canceledContracts", canceledContracts))
                .andExpect(model().attribute("finishedContracts", finishedContracts))
                .andExpect(model().attribute("finedContracts", new ArrayList<>()));
    }

    @Test
    public void listContractsWithoutStatusPageTest() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users))
        ;
    }

    @Test
    public void listContractsWithStatusPageTest() throws Exception {
        List<Contract> contracts = getAllContracts().stream().filter(contract -> contract.getStatus().equals("Завершён")).toList();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Завершён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void detailsContractPageTest() throws Exception {
        List<Contract> contracts = getAllContracts();

        Long x = null;

        this.mockMvc.perform(get("/contract/details")
                        .param("id", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractDetails"))
                .andExpect(model().attribute("countVideoReg", "1"))
                .andExpect(model().attribute("countCarBox", "0"))
                .andExpect(model().attribute("countKidChes", "0"))
                .andExpect(model().attribute("contract", contracts.get(0)))
                .andExpect(model().attribute("errors", x))
                .andExpect(model().attribute("dayStart", "30 апреля"))
                .andExpect(model().attribute("dayEnd", "11 мая"))
                .andExpect(model().attribute("timeRent", 10L));
    }

    @Test
    public void editContractPageTest() throws Exception {
        List<Contract> contracts = getAllContracts();

        this.mockMvc.perform(get("/contract/edit")
                        .param("id", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractEdit"))
                .andExpect(model().attribute("contract", contracts.get(0)))
                .andExpect(model().attribute("dayStart", "30 апреля"))
                .andExpect(model().attribute("dayEnd", "11 мая"))
                .andExpect(model().attribute("timeRent", 10L));

        this.mockMvc.perform(get("/contract/edit")
                        .param("id", "12")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/contract/list/all"));
    }

    @Test
    public void createContractPageTest() throws Exception {
        List<Car> cars = getAllCars();
        User user = getUser();

        Long x = null;

        this.mockMvc.perform(post("/contract/create")
                        .param("car_id", "1")
                        .with(user("user1").authorities(new SimpleGrantedAuthority("USER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractCreate"))
                .andExpect(model().attribute("car", cars.get(0)))
                .andExpect(model().attribute("client", user))
                .andExpect(model().attribute("errors", x))
                .andExpect(model().attribute("dayStart", x))
                .andExpect(model().attribute("dayEnd", x));
       }

    @Test
    public void searchContractWithoutParams() throws Exception {
        List<Contract> contracts = getAllContracts();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");
        List<String> users = List.of("Петров Петр Петрович");

        Long x = null;

        this.mockMvc.perform(post("/contract/search")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("brand", x))
                .andExpect(model().attribute("client", x))
                .andExpect(model().attribute("dateStart", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void searchContractWithAllParams() throws Exception {
        List<Contract> contracts = getAllContracts();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");
        List<String> users = List.of("Петров Петр Петрович");

        List<Contract> responseContractsList = new ArrayList<>();
        responseContractsList.add(contracts.get(0));

        this.mockMvc.perform(post("/contract/search")
                        .param("Client", "Петров Петр Петрович")
                        .param("CarBrand", "Ford")
                        .param("DateStart", "2023-04-29")
                        .param("DateEnd", "2023-05-12")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("brand", "Ford"))
                .andExpect(model().attribute("client", "Петров Петр Петрович"))
                .andExpect(model().attribute("dateStart", "2023-04-29"))
                .andExpect(model().attribute("dateEnd", "2023-05-12"))
                .andExpect(model().attribute("contracts", responseContractsList))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void searchContractWithSomeParams() throws Exception {
        List<Contract> contracts = getAllContracts();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");
        List<String> users = List.of("Петров Петр Петрович");

        List<Contract> responseContractsList = new ArrayList<>();
        responseContractsList.add(contracts.get(0));
        responseContractsList.add(contracts.get(2));

        Long x = null;

        this.mockMvc.perform(post("/contract/search")
                        .param("Client", "Петров Петр Петрович")
                        .param("CarBrand", "Ford")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("brand", "Ford"))
                .andExpect(model().attribute("client", "Петров Петр Петрович"))
                .andExpect(model().attribute("dateStart", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("contracts", responseContractsList))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void deleteContractSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");
        List<String> users = List.of("Петров Петр Петрович");

        Long x = null;

        this.mockMvc.perform(post("/contract/delete")
                        .param("id", "4")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        contracts.remove(3);

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void deleteContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");
        List<String> users = List.of("Петров Петр Петрович");

        Long x = null;

        this.mockMvc.perform(post("/contract/delete")
                        .param("id", "5")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void createContractSuccess() throws Exception {

        this.mockMvc.perform(post("/contract/save")
                        .param("userName", "user1")
                        .param("car_id", "4")
                        .param("FIO_Customer", "newFio")
                        .param("email", "newEmail@mail.ru")
                        .param("phone", "88005553535")
                        .param("address", "new Address")
                        .param("driverLicense", "1234 5678")
                        .param("Date_Start", "2023-05-01 12:00")
                        .param("placeReceipt", "Офис")
                        .param("Date_End", "2023-05-11 12:00")
                        .param("placeReturn", "Офис")
                        .param("Registrator", "1")
                        .param("Notes", "Хочу автомобиль")
                        .param("AutoBox", "1")
                        .param("interest", "2")
                        .param("DeliveryPrice", "0")
                        .param("Price", "45100")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/contract?page=1"));

        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("newFio");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Car> cars = getAllCars();
        User user = getUser();
        user.setFio("newFio");
        user.setEmail("newEmail@mail.ru");
        user.setPhone("88005553535");
        user.setAddress("new Address");
        user.setDriverLicense("1234 5678");

        Car car = cars.get(3);
        car.setStatus("Забронирована");

        contracts.clear();
        contracts.add(new Contract(5, null, "Видеорегистратор: 1; Авто бокс: 1; Детское кресло: 2; ", LocalDateTime.parse("2023-05-01T12:00"),
                "Офис", LocalDateTime.parse("2023-05-11T12:00"), "Офис", 45100.0, "Не подтверждён", "Хочу автомобиль",
                cars.get(3),user));

        Long x = null;
        Contract contract = new Contract();

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Не подтверждён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void createContractUnsuccessful() throws Exception {

        this.mockMvc.perform(post("/contract/save")
                        .param("userName", "user1")
                        .param("car_id", "4")
                        .param("FIO_Customer", "newFio")
                        .param("email", "newEmail@mail.ru")
                        .param("phone", "88005553535")
                        .param("address", "new Address")
                        .param("driverLicense", "1234 5678")
                        .param("Date_Start", "2023-05-01 12:00")
                        .param("placeReceipt", "Офис")
                        .param("Date_End", "2023-05-01 17:00")
                        .param("placeReturn", "Офис")
                        .param("Registrator", "1")
                        .param("Notes", "Хочу автомобиль")
                        .param("AutoBox", "1")
                        .param("interest", "2")
                        .param("DeliveryPrice", "0")
                        .param("Price", "45100")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractCreate"))
                .andExpect(model().attributeExists("errorDate"))
                .andExpect(model().attribute("priceRental", "Произошла ошибка при расчёте цены аренда!"));

        List<Contract> contracts = new ArrayList<>();
        List<String> users = List.of("newFio");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Не подтверждён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 0L))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));
    }

    @Test
    public void editContractSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        Contract contract = contracts.get(0);
        contract.setNote("new Note");
        contract.setFioManager("new FIO manager");

        this.mockMvc.perform(post("/contract/edit")
                        .flashAttr("contract",contract)
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("details?id=1"));

        Long x = null;

        this.mockMvc.perform(get("/contract/details")
                        .param("id", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractDetails"))
                .andExpect(model().attribute("countVideoReg", "1"))
                .andExpect(model().attribute("countCarBox", "0"))
                .andExpect(model().attribute("countKidChes", "0"))
                .andExpect(model().attribute("contract", contract))
                .andExpect(model().attribute("errors", x))
                .andExpect(model().attribute("dayStart", "30 апреля"))
                .andExpect(model().attribute("dayEnd", "11 мая"))
                .andExpect(model().attribute("timeRent", 10L));
    }

    @Test
    public void editContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        Contract contract = contracts.get(0);
        contract.setNote(null);
        contract.setFioManager(null);

        this.mockMvc.perform(post("/contract/edit")
                        .flashAttr("contract",contract)
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("details?id=1"));

        contract = contracts.get(0);
        Long x = null;

        this.mockMvc.perform(get("/contract/details")
                        .param("id", "1")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/contractDetails"))
                .andExpect(model().attribute("countVideoReg", "1"))
                .andExpect(model().attribute("countCarBox", "0"))
                .andExpect(model().attribute("countKidChes", "0"))
                .andExpect(model().attribute("contract", contract))
                .andExpect(model().attribute("errors", x))
                .andExpect(model().attribute("dayStart", "30 апреля"))
                .andExpect(model().attribute("dayEnd", "11 мая"))
                .andExpect(model().attribute("timeRent", 10L));
    }

    @Test
    public void confirmContractSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/confirm")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;
        contract.setStatus("Подтверждён");
        responseContracts.add(contract);

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Подтверждён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void confirmContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/confirm")
                        .param("id", "6")
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Подтверждён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 0L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void startContractSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/start")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;
        contract.setStatus("Действует");
        responseContracts.add(contract);

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Действует")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void startContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        responseContracts.add(contracts.get(0));

        this.mockMvc.perform(post("/contract/start")
                        .param("id", "6")
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Действует")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void fineContractSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/fine")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;
        contract.setStatus("Ожидает оплаты штрафа");
        responseContracts.add(contract);

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Ожидает оплаты штрафа")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void fineContractUnsuccessful() throws Exception {
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();

        this.mockMvc.perform(post("/contract/fine")
                        .param("id", "6")
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Ожидает оплаты штрафа")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 0L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void finishContractByManagerSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/finish")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;
        contract.setStatus("Завершён");
        responseContracts.add(contract);
        responseContracts.add(contracts.get(1));
        responseContracts.add(contracts.get(2));

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Завершён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void finishContractByClientSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        User user = getUser();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/finish")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("user1").authorities(new SimpleGrantedAuthority("USER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/contract?page=1"));

        Long x = null;
        contract.setStatus("Завершён");

        List<Contract> canceledContracts =  new ArrayList<>();
        List<Contract> finishedContracts =  new ArrayList<>();

        canceledContracts.add(contracts.get(3));
        finishedContracts.add(contract);
        finishedContracts.add(contracts.get(1));
        finishedContracts.add(contracts.get(2));

        this.mockMvc.perform(get("/contract")
                        .param("page", "1")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/indexForClient"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("rentalHours", x))
                .andExpect(model().attribute("activeContract", x))
                .andExpect(model().attribute("client", user))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("canceledContracts", canceledContracts))
                .andExpect(model().attribute("finishedContracts", finishedContracts))
                .andExpect(model().attribute("finedContracts", new ArrayList<>()));

    }

    @Test
    public void finishContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();

        this.mockMvc.perform(post("/contract/finish")
                        .param("id", "6")
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        Long x = null;
        responseContracts.add(contracts.get(1));
        responseContracts.add(contracts.get(2));

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Завершён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void cancelContractByManagerSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/cancel")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("list/all?page=1"));

        Long x = null;
        Car car = contract.getCar();
        car.setStatus("Свободна");

        contract.setStatus("Отменён");
        contract.setCar(car);

        responseContracts.add(contract);
        responseContracts.add(contracts.get(3));

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Отменён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }

    @Test
    public void cancelContractByClientSuccess() throws Exception {
        List<Contract> contracts = getAllContracts();
        User user = getUser();
        Contract contract = contracts.get(0);

        this.mockMvc.perform(post("/contract/cancel")
                        .param("id", String.valueOf(contract.getId()))
                        .with(user("user1").authorities(new SimpleGrantedAuthority("USER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/contract?page=1"));

        Long x = null;

        Car car = contract.getCar();
        car.setStatus("Свободна");

        contract.setStatus("Отменён");
        contract.setCar(car);

        List<Contract> canceledContracts =  new ArrayList<>();
        List<Contract> finishedContracts =  new ArrayList<>();

        canceledContracts.add(contract);
        canceledContracts.add(contracts.get(3));

        finishedContracts.add(contracts.get(1));
        finishedContracts.add(contracts.get(2));

        this.mockMvc.perform(get("/contract")
                        .param("page", "1")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/indexForClient"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("rentalHours", x))
                .andExpect(model().attribute("activeContract", x))
                .andExpect(model().attribute("client", user))
                .andExpect(model().attribute("contracts", contracts))
                .andExpect(model().attribute("canceledContracts", canceledContracts))
                .andExpect(model().attribute("finishedContracts", finishedContracts))
                .andExpect(model().attribute("finedContracts", new ArrayList<>()));

    }

    @Test
    public void cancelContractUnsuccessful() throws Exception {
        List<Contract> contracts = getAllContracts();
        List<String> users = List.of("Петров Петр Петрович");
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        List<Contract> responseContracts = new ArrayList<>();

        this.mockMvc.perform(post("/contract/cancel")
                        .param("id", "6")
                        .with(user("manager").authorities(new SimpleGrantedAuthority("MANAGER")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));

        Long x = null;

        responseContracts.add(contracts.get(3));

        this.mockMvc.perform(get("/contract/list/all")
                        .param("page", "1")
                        .param("status", "Отменён")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Contract/listContracts"))
                .andExpect(model().attribute("countPage", 1L))
                .andExpect(model().attribute("contracts", responseContracts))
                .andExpect(model().attribute("cars", carsBrand))
                .andExpect(model().attribute("emptyFIO", x))
                .andExpect(model().attribute("users", users));

    }
}
