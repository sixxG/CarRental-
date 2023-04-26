package com.example.spring.security.controllerTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestBuilders.formLogin;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.unauthenticated;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/UserControllerTest/create-admin-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
public class RegistrationControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    @Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
    public void registrationPageTest() throws Exception {
        this.mockMvc.perform(get("/registration"))
                .andDo(print())
                .andExpect(unauthenticated())
                .andExpect(xpath("/html/body/div[2]/form/div/div[1]/p[1][contains(text(),'Регистрация')]").exists())
                .andExpect(xpath("/html/body/div[2]/form/div/div[5]/input[@data-id='ЗАРЕГИСТРИРОВАТЬСЯ']").exists());
    }

    @Test
    public void registrationSuccessTest() throws Exception {
        this.mockMvc.perform(post("/registration")
                        .param("username", "newUser")
                        .param("password", "1")
                        .param("email", "newUserEmail@mail.ru")
                        .with(csrf()))
                .andDo(print())
                .andExpect(unauthenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/login"));
        this.mockMvc.perform(formLogin().user("newUser").password("1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/"));
    }

    @Test
    public void registrationUnsuccessfulEmailUsedTest() throws Exception {
        this.mockMvc.perform(post("/registration")
                        .param("username", "user1132")
                        .param("password", "2")
                        .param("email", "user1@mail.ru")
                        .with(csrf()))
                .andDo(print())
                .andExpect(unauthenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Account/Registration"))
                .andExpect(model().attribute("message", "Email is already used!"));
    }

    @Test
    public void registrationUnsuccessfulUserNameUsedTest() throws Exception {
        this.mockMvc.perform(post("/registration")
                        .param("username", "user1")
                        .param("password", "2")
                        .param("email", "user123@mail.ru")
                        .with(csrf()))
                .andDo(print())
                .andExpect(unauthenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Account/Registration"))
                .andExpect(model().attribute("message", "User exists!"));
    }
}
