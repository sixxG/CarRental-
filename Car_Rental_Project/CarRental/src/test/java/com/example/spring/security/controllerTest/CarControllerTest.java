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
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/MainControllerTest/create-car-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/MainControllerTest/create-car-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = "/scripts/CarControllerTest/remove-auto_increment-before.sql", executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@WithUserDetails("admin")
public class CarControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void carListPageTest() throws Exception {
        List<Car> cars =  new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));

        this.mockMvc.perform(get("/car/all")
                        .param("numberPage", "0")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));

        cars.clear();

        this.mockMvc.perform(get("/car/all")
                        .param("numberPage", "1")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));
    }

    @Test
    public void carListByClassPageTest() throws Exception {
        List<Car> ComfortCars =  new ArrayList<>();
        List<Car> BusinessCars =  new ArrayList<>();
        List<Car> UniqueCars =  new ArrayList<>();
        List<Car> nullList = new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        ComfortCars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        ComfortCars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));

        UniqueCars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        UniqueCars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));

        BusinessCars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        BusinessCars.add(new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));

        this.mockMvc.perform(get("/car"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carByClass"))
                .andExpect(model().attribute("EconomyCar", nullList))
                .andExpect(model().attribute("ComfortCar", ComfortCars))
                .andExpect(model().attribute("BusinessCar", BusinessCars))
                .andExpect(model().attribute("PremiumCar", nullList))
                .andExpect(model().attribute("SuvCar", nullList))
                .andExpect(model().attribute("BusCar", nullList))
                .andExpect(model().attribute("UniqueCar", UniqueCars))
                .andExpect(model().attribute("carsBrand", carsBrand));
    }

    @Test
    public void addCarFormPageTest() throws Exception {

        this.mockMvc.perform(get("/addCar")
                .with(user("admin")
                        .authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carCreate"));
    }

    @Test
    @Sql(value = {"/scripts/CarControllerTest/create-contract-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    @Sql(value = {"/scripts/CarControllerTest/create-contract-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
    public void deleteCarPageTest() throws Exception {

        Car car = new Car(1, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text");
        Long x = null;

        this.mockMvc.perform(get("/car/delete")
                        .param("id", "1")
                        .with(user("admin")
                                .authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDelete"))
                .andExpect(model().attribute("contractId", x))
                .andExpect(model().attribute("isHasActiveContract", false))
                .andExpect(model().attribute("car", car));

        car = new Car(2, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text");

        this.mockMvc.perform(get("/car/delete")
                        .param("id", "2")
                        .with(user("admin")
                                .authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDelete"))
                .andExpect(model().attribute("contractId", 1))
                .andExpect(model().attribute("isHasActiveContract", true))
                .andExpect(model().attribute("car", car));
    }

    @Test
    public void editCarPageTest() throws Exception {

        Car car = new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text");

        this.mockMvc.perform(get("/car/edit")
                        .param("id", "5")
                        .with(user("admin")
                                .authorities(new SimpleGrantedAuthority("ADMIN"))))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carEdit"))
                .andExpect(model().attribute("carEdit", car));

        this.mockMvc.perform(get("/car/edit")
                        .param("id", "5")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is4xxClientError());
    }

    @Test
    @Sql(value = {"/scripts/CarControllerTest/create-contract-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    @Sql(value = {"/scripts/CarControllerTest/create-contract-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
    public void carDetailsPageTest() throws Exception {

        Car car = new Car(1, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text");
        Long x = null;

        this.mockMvc.perform(get("/car/details")
                        .param("id", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDetails"))
                .andExpect(model().attribute("contractId", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("isHasActiveContract", false))
                .andExpect(model().attribute("car", car));

        Collection<Role> roles = new ArrayList<>();
        roles.add(new Role(1, "USER"));
        User user = new User(1, "user1", "$2a$12$S2JpVOlJje2dbOaaNM8C0.BXhCYNBnAmy3FtL2a4yttm6ROi9Q4I.",
                "user1@mail.ru", "Петров Петр Петрович", LocalDate.parse("1990-01-01"), "Владимир ул.Горького д.3",
                "+8 800 555 3535", "1234 5678", roles);

        car = new Car(2, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес",
                2016, 67000, "Белый", "Робот", "Полный", 250, 12500,
                "Свободна", "bmwX5.jpeg", "some text");

        Contract contract = new Contract(1, "Сидоров Виктор Сергеевич", "Видеорегистратор: 1; ",
                LocalDateTime.parse("2023-04-30T15:00:00"), "Улица Кирова 7",
                LocalDateTime.parse("2023-05-11T10:00:00"), "Железнодорожный вокзал", 55000,
                "Действует", "", car, user);


        this.mockMvc.perform(get("/car/details")
                        .param("id", "2")
                        .param("username", "user1")
                        .with(user("user1")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDetails"))
                .andExpect(model().attribute("activeContract", contract))
                .andExpect(model().attribute("dateEnd", LocalDateTime.parse("2023-05-11T10:00")))
                .andExpect(model().attribute("isHasActiveContract", true))
                .andExpect(model().attribute("car", car));
    }

    @Test
    public void carByClassPageTest() throws Exception {
        List<Car> cars =  new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));

        this.mockMvc.perform(get("/carbyclass")
                        .param("numberPage", "0")
                        .param("carClass", "Комфорт")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));

        cars.clear();
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));

        this.mockMvc.perform(get("/carbyclass")
                        .param("numberPage", "0")
                        .param("carClass", "Уникальные авто")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));
    }

    @Test
    public void findCarTest() throws Exception {
        List<Car> cars =  new ArrayList<>();

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));

        this.mockMvc.perform(get("/findCar")
                        .param("numberPage", "0")
                        .param("typeBody", "Хетчбэк")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars));

        cars.clear();

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));

        this.mockMvc.perform(get("/findCar")
                        .param("numberPage", "0")
                        .param("typeDrive", "Задний")
                        .param("typeBody", "Хетчбэк")
                        .param("ListBrand", "Lifan")
                        .param("ListTypeTransmition", "Механическая")
                        .param("PriceOT", "3000")
                        .param("PriceDO", "4000")
                        .param("power", "130")
                        .param("year", "2018")
                        .param("mileage", "45000")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars));
    }

    @Test
    public void deleteCarSuccessTest() throws Exception {
        List<Car> cars =  new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));

        this.mockMvc.perform(post("/car/delete")
                        .param("id", "6")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/car"));

        cars.remove(5);

        this.mockMvc.perform(get("/car/all")
                        .param("numberPage", "0")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));

    }

    @Test
    public void deleteCarUnsuccessfulTest() throws Exception {
        List<Car> cars =  new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));

        this.mockMvc.perform(post("/car/delete")
                        .param("id", "7")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/car"));

        this.mockMvc.perform(get("/car/all")
                        .param("numberPage", "0")
                        .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));

    }

    @Test
    public void editCarSuccessTest() throws Exception {
        // Создание объекта машины для передачи в контроллер
        Car car = new Car(6, "VF7RD5FNABL000005", "BMW", "X55", "Внедорожник", "Бизнес", 2000, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text");

        // Ожидаемое значение для перенаправления
        String expectedRedirectUrl = "/car/details?id=" + car.getId();

        MockHttpServletRequestBuilder multipart = multipart("/car/edit")
                .file("newImage", "123".getBytes())
                .flashAttr("car",car)
                .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                .with(csrf());
        // Выполнение запроса на редактирование машины с загрузкой файла
        this.mockMvc.perform(multipart)
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl(expectedRedirectUrl));

        car = new Car(6, "VF7RD5FNABL000005", "BMW", "X55", "Внедорожник", "Бизнес", 2000, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text");
        Long x = null;

        this.mockMvc.perform(get("/car/details")
                        .param("id", "6")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDetails"))
                .andExpect(model().attribute("contractId", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("isHasActiveContract", false))
                .andExpect(model().attribute("car", car));
    }

    @Test
    public void editCarUnsuccessfulTest() throws Exception {
        // Создание объекта машины для передачи в контроллер
        Car car = new Car(6, "VF7RD5FNABL000005", "BMW", "X55", "Внедорожник", "Бизнес", 0, 0, "Белый", "Робот", "Полный", 0, 0, "Свободна", "bmwX5.jpeg", "some text");

        // Ожидаемое значение для перенаправления
        String expectedRedirectUrl = "/car/edit?id=" + car.getId();

        MockHttpServletRequestBuilder multipart = multipart("/car/edit")
                .file("newImage", "123".getBytes())
                .flashAttr("car",car)
                .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                .with(csrf());
        // Выполнение запроса на редактирование машины с загрузкой файла
        this.mockMvc.perform(multipart)
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl(expectedRedirectUrl));

        car = new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text");
        Long x = null;

        this.mockMvc.perform(get("/car/details")
                        .param("id", "6")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDetails"))
                .andExpect(model().attribute("contractId", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("isHasActiveContract", false))
                .andExpect(model().attribute("car", car));
    }

    @Test
    public void addCarSuccessTest() throws Exception {
        // Создание объекта машины для передачи в контроллер
        Car car = new Car(7, "11111111111111111", "1", "1", "Внедорожник", "Бизнес", 1900, 100000, "Белый", "Робот", "Полный", 2499, 199000, "Свободна", "bmwX5.jpeg", "some text");

        // Ожидаемое значение для перенаправления
        String expectedRedirectUrl = "/car";

        MockHttpServletRequestBuilder multipart = multipart("/car")
                .file("newImage", "123".getBytes())
                .flashAttr("car",car)
                .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                .with(csrf());
        // Выполнение запроса на редактирование машины с загрузкой файла
        this.mockMvc.perform(multipart)
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl(expectedRedirectUrl));

        Long x = null;

        this.mockMvc.perform(get("/car/details")
                        .param("id", "7"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carDetails"))
                .andExpect(model().attribute("contractId", x))
                .andExpect(model().attribute("dateEnd", x))
                .andExpect(model().attribute("isHasActiveContract", false))
                .andExpect(model().attribute("car", car));
    }

    @Test
    public void addCarUnsuccessfulTest() throws Exception {
        List<Car> cars =  new ArrayList<>();
        Set<String> carsBrand = new HashSet<>();
        Collections.addAll(carsBrand, "Lifan", "Ford", "BMW");

        cars.add(new Car(1, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg" ,"some text"));
        cars.add(new Car(2, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(3, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));
        cars.add(new Car(4, "VF7RD5FNABL500910", "Lifan", "MyWay", "Хетчбэк", "Комфорт", 2018, 40000, "Черный", "Механическая", "Задний", 136, 3500, "Свободна", "lifan.jpeg", "some text"));
        cars.add(new Car(5, "VF7RD5FNABL544911", "Ford", "Cobra Shelby", "Купэ", "Уникальные авто", 1961, 89000, "Синий", "Механическая", "Передний", 250, 20000, "Свободна", "ford_shelby.jpeg", "some text"));
        cars.add(new Car(6, "VF7RD5FNABL000005", "BMW", "X5", "Внедорожник", "Бизнес", 2016, 67000, "Белый", "Робот", "Полный", 250, 12500, "Свободна", "bmwX5.jpeg", "some text"));

        // Создание объекта машины для передачи в контроллер
        Car car = new Car(7, "1", "1", "1", "Внедорожник", "Бизнес", 1900, 100000, "Белый", "Робот", "Полный", 2499, 199000, "Свободна", "bmwX5.jpeg", "some text");

        // Ожидаемое значение для перенаправления
        String expectedRedirectUrl = "/carCreate";

        MockHttpServletRequestBuilder multipart = multipart("/car")
                .file("newImage", "123".getBytes())
                .flashAttr("car",car)
                .with(user("admin").authorities(new SimpleGrantedAuthority("ADMIN")))
                .with(csrf());

        this.mockMvc.perform(multipart)
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carCreate"));

        this.mockMvc.perform(get("/car/all")
                        .param("numberPage", "0")
                        .with(user("admin")))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Car/carList"))
                .andExpect(model().attribute("countPage", 1.0))
                .andExpect(model().attribute("cars", cars))
                .andExpect(model().attribute("carsBrand", carsBrand));
    }
}
