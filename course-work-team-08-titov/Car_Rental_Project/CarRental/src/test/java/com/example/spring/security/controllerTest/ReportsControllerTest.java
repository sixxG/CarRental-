package com.example.spring.security.controllerTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/UserControllerTest/create-admin-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = {"/scripts/MainControllerTest/create-car-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/MainControllerTest/create-car-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = {"/scripts/ReportsControllerTest/create-contract-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/ReportsControllerTest/create-contract-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@WithUserDetails("admin")
public class ReportsControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void reportsByCarsPageTest() throws Exception {
        this.mockMvc.perform(get("/reports/cars"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(view().name("reports/carsReport"))
                .andExpect(model().attribute("oldestCarId", 2))
                .andExpect(model().attribute("maxYearCar", 62))
                .andExpect(model().attribute("youngestCarId", 1))
                .andExpect(model().attribute("minYearCar", 5))
                .andExpect(model().attribute("maxPriceCarId", 2))
                .andExpect(model().attribute("maxPrice", 20000))
                .andExpect(model().attribute("minPriceCarId", 1))
                .andExpect(model().attribute("minPrice", 3500))
                .andExpect(model().attribute("maxMileageCarId", 2))
                .andExpect(model().attribute("maxMileage", 89000))
                .andExpect(model().attribute("minMileageCarId", 1))
                .andExpect(model().attribute("minMileage", 40000))
                .andExpect(model().attribute("averagePrice", 12000))
                .andExpect(model().attribute("averageYear", 25))
                .andExpect(model().attribute("averageMileage", 65333))
                .andExpect(model().attribute("countCars", 6))
                .andExpect(model().attribute("countFreeCars", 6))
                .andExpect(model().attribute("countBusyCars", 0));
    }

    @Test
    public void reportsByClientsPageTest() throws Exception {
        this.mockMvc.perform(get("/reports/clients"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[1][@data-id='countUsersSystem_3'][contains(text(),'3')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[2][@data-id='countClients_1'][contains(text(),'1')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[3][@data-id='countManagers_1'][contains(text(),'1')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[4][@data-id='countAdmins_1'][contains(text(),'1')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[1]/h4[@data-id='maxAgeClients_33'][contains(text(),'33 лет')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[2]/h4[@data-id='minAgeClients_33'][contains(text(),'33 лет')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/h4[@data-id='averageAge_33'][contains(text(),'33 лет')]").exists());
    }

    @Test
    public void reportsByContractsPageTest() throws Exception {
        Long xNull = null;

        this.mockMvc.perform(get("/reports/contracts"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(model().attribute("countOptional", 6L))
                .andExpect(model().attribute("percentVideoReg", 50.0))
                .andExpect(model().attribute("percentAutoBox", 16.0))
                .andExpect(model().attribute("percentKidsChair", 33.0))
                .andExpect(model().attribute("contractsForPeriod", xNull))
                .andExpect(model().attribute("resultPrice", xNull))
                .andExpect(model().attribute("maxPriceRental", 60000))
                .andExpect(model().attribute("idMaxPriceRental", 1))
                .andExpect(model().attribute("minPriceRental", 45000))
                .andExpect(model().attribute("idMinPriceRental", 2))
                .andExpect(model().attribute("avgPriceRental", 53334))
                .andExpect(model().attribute("countContracts", 3))
                .andExpect(model().attribute("countRentalForActualMonth", 0))
                .andExpect(model().attribute("countRentalsWithFine", 1));
    }

    @Test
    public void reportsByContractsCountRentsForPeriodSuccessTest() throws Exception {
        this.mockMvc.perform(get("/reports/contracts")
                        .param("inputStart", "2023-04-01")
                        .param("inputEnd", "2023-04-28"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table[@data-id='contractsForPeriod']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table/tbody/tr[1]/td[1][@data-id='1']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table/tbody/tr[2]/td[1][@data-id='2']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table/tbody/tr[3]/td[1][@data-id='3']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table/tbody/tr[4]/td[2][contains(text(),'160,000')]").exists());
    }

    @Test
    public void reportsByContractsCountRentsForPeriodUnsuccessfulTest() throws Exception {
        this.mockMvc.perform(get("/reports/contracts")
                        .param("inputStart", "2023-03-01")
                        .param("inputEnd", "2023-03-28"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/table[@data-id='contractsForPeriod']").doesNotExist());
    }

    @Test
    public void reportsByContractsCountRentsManagersForPeriodSuccessTest() throws Exception {
        this.mockMvc.perform(get("/reports/contracts")
                        .param("startPeriod", "2023-04-01")
                        .param("endPeriod", "2023-04-28"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id='contractsByManager']/table/tbody/tr[1]/td[1][@data-id='Сидоров Виктор Сергеевич']").exists())
                .andExpect(xpath("//*[@id='contractsByManager']/table/tbody/tr[1]/td[2][@data-id='Сидоров Виктор Сергеевич_3']").exists())
                .andExpect(xpath("//*[@id='contractsByManager']/table/tbody/tr[1]/td[3][@data-id='Сидоров Виктор Сергеевич_160,000']").exists());
    }

    @Test
    public void reportsByContractsCountRentsManagersForPeriodUnsuccessfulTest() throws Exception {
        this.mockMvc.perform(get("/reports/contracts")
                        .param("startPeriod", "2023-03-01")
                        .param("endPeriod", "2023-03-28"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("//*[@id='contractsByManager']/table/tbody/tr[1][@data-id='countContractsByFioManager']").doesNotExist());
    }
}
