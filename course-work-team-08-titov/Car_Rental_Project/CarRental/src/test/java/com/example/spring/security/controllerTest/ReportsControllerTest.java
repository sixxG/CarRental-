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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.xpath;

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
                .andExpect(xpath("//p[@data-id='countCars_6'][contains(text(),'6')]").exists())
                .andExpect(xpath("//p[@data-id='countFreeCars_6'][contains(text(),'6')]").exists())
                .andExpect(xpath("//p[@data-id='countBusyCars_0'][contains(text(),'0')]").exists())

                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[1]/td[1][@data-id='Комфорт']").exists())
                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[2]/td[1][@data-id='Уникальные авто']").exists())
                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[3]/td[1][@data-id='Бизнес']").exists())

                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[1]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[2]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByClass']/table/tbody/tr[3]/td[2][contains(text(),'2')]").exists())

                .andExpect(xpath("//*[@id='collapseByTransmition']/table/tbody/tr[1]/td[1][@data-id='Механическая']").exists())
                .andExpect(xpath("//*[@id='collapseByTransmition']/table/tbody/tr[2]/td[1][@data-id='Робот']").exists())

                .andExpect(xpath("//*[@id='collapseByTransmition']/table/tbody/tr[1]/td[2][contains(text(),'4')]").exists())
                .andExpect(xpath("//*[@id='collapseByTransmition']/table/tbody/tr[2]/td[2][contains(text(),'2')]").exists())

                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[2]/td[1][@data-id='Передний']").exists())
                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[3]/td[1][@data-id='Полный']").exists())
                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[1]/td[1][@data-id='Задний']").exists())

                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[2]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[3]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByDrive']/table/tbody/tr[1]/td[2][contains(text(),'2')]").exists())

                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[1]/td[1][@data-id='Хетчбэк']").exists())
                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[2]/td[1][@data-id='Купэ']").exists())
                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[3]/td[1][@data-id='Внедорожник']").exists())

                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[1]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[2]/td[2][contains(text(),'2')]").exists())
                .andExpect(xpath("//*[@id='collapseByBody']/table/tbody/tr[3]/td[2][contains(text(),'2')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[1]/h4[@data-id='maxPrice_20,000'][contains(text(),'20,000')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[2]/h4[@data-id='minPrice_3,500'][contains(text(),'3,500')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/h4[1][@data-id='averagePrice_12,000'][contains(text(),'12,000')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[3]/h4[@data-id='maxYearCar_62'][contains(text(),'62')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[4]/h4[@data-id='minYearCar_5'][contains(text(),'5')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/h4[2][@data-id='averageYear_25'][contains(text(),'25')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[5]/h4[@data-id='maxMileage_89,000'][contains(text(),'89,000')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[6]/h4[@data-id='minMileage_40,000'][contains(text(),'40,000')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/h4[3][@data-id='averageMileage_65,333'][contains(text(),'65,333')]").exists());
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
        this.mockMvc.perform(get("/reports/contracts"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[1][@data-id='countContracts_3'][contains(text(),'3')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[2][@data-id='countRentalForActualMonth_3'][contains(text(),'3')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[2]/h4[3][@data-id='countRentalsWithFine_1'][contains(text(),'1')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[1]/h4[@data-id='maxPriceRental_60,000'][contains(text(),'60,000')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/a[2]/h4[@data-id='minPriceRental_45,000'][contains(text(),'45,000')]").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[3]/h4[@data-id='avgPriceRental_53,334'][contains(text(),'53,334')]").exists())

                .andExpect(xpath("//*[@id='contractsByStatus']/table/tbody/tr[1]/td[1][@data-id='status_Завершён']").exists())
                .andExpect(xpath("//*[@id='contractsByStatus']/table/tbody/tr[1]/td[2][@data-id='Завершён_3'][contains(text(),'3')]").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[1]/td[1][@data-id='Автовокзал']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[2]/td[1][@data-id='Офис']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[3]/td[1][@data-id='Улица Кирова 7']").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[1]/td[2][@data-id='Автовокзал_1']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[2]/td[2][@data-id='Офис_1']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[1]/tbody/tr[3]/td[2][@data-id='Улица Кирова 7_1']").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[1]/td[1][@data-id='Автовокзал']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[2]/td[1][@data-id='Офис']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[3]/td[1][@data-id='Железнодорожный вокзал']").exists())

                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[1]/td[2][@data-id='Автовокзал_1']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[2]/td[2][@data-id='Офис_1']").exists())
                .andExpect(xpath("/html/body/div[3]/div/div/div[1]/table[2]/tbody/tr[3]/td[2][@data-id='Железнодорожный вокзал_1']").exists());
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
