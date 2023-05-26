package com.example.spring.security.controllerTest;

import com.example.spring.security.models.Car;
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

import java.util.List;

import static org.hamcrest.core.StringContains.containsString;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@WithUserDetails("user1")
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/MainControllerTest/create-car-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/AccountControllerTest/create-user-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/MainControllerTest/create-car-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = {"/scripts/AccountControllerTest/create-user-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
public class MainControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void mainPageTest() throws Exception {
        this.mockMvc.perform(get("/"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Здравствуйте user1!")))
                .andExpect(content().string(containsString("Выйти")));
    }

    @Test
    public void popularCarListTest() throws Exception {
        this.mockMvc.perform(get("/"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(model().attributeExists("cars"))
                .andExpect(model().attributeExists("carsBrand"));
    }

    @Test
    public void contactsPageTest() throws Exception {
        this.mockMvc.perform(get("/contacts"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Адресс")))
                .andExpect(content().string(containsString("Владимир, Проспект Строителей 7Б, стр. 14,")));
    }

    @Test
    public void aboutPageTest() throws Exception {
        this.mockMvc.perform(get("/about"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Условия аренды")))
                .andExpect(content().string(containsString("О нас")));
    }
}
