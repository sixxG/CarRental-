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

import static org.hamcrest.core.StringContains.containsString;
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
@WithUserDetails("user1")
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/AccountControllerTest/create-user-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/AccountControllerTest/create-user-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
public class AccountControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void accountMainPageTest() throws Exception {
        this.mockMvc.perform(get("/account").param("name", "user1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Личные данные.")))
                .andExpect(content().string(containsString("Петров Петр Петрович")))
                .andExpect(content().string(containsString("user1@mail.ru")))
                .andExpect(content().string(containsString("Вы пока не оставили отзыв о нашей компании!")))
                .andExpect(content().string(containsString("Здравствуйте user1!")));
    }

    @Test
    public void saveUserDataSuccessTest() throws Exception {
        this.mockMvc.perform(post("/account")
                        .param("fio", "newFIO")
                        .param("birthDate", "2000-01-01")
                        .param("email", "newEmail@mail.ru")
                        .param("address", "new Address")
                        .param("phone", "88005553535")
                        .param("driverLicense", "1234 5678")
                        .param("userId", "1")
                        .with(user("user1"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/account?name=user1"));
        this.mockMvc.perform(get("/account").param("name", "user1"))
                .andExpect(content().string(containsString("Ваши данные")))
                .andExpect(content().string(containsString("newFIO")))
                .andExpect(content().string(containsString("newEmail@mail.ru")));
    }

    @Test
    public void changePasswordPageTest() throws Exception {
        this.mockMvc.perform(get("/account/change_password"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Старый пароль")))
                .andExpect(xpath("//*[@id='password-form']/button").exists())
                .andExpect(xpath("//*[@id='oldPassword']").exists());
    }

    @Test
    public void changePasswordSuccessTest() throws Exception {
        this.mockMvc.perform(post("/account/change_password")
                        .param("oldPassword", "1111")
                        .param("newPassword", "1")
                        .param("confirmPassword", "1")
                        .with(csrf()))
                .andDo(print())
                .andExpect(content().string(containsString("Старый пароль")))
                .andExpect(content().string(containsString("Пароль бы изменён!")))
                .andExpect(xpath("//*[@id='password-form']/button").exists())
                .andExpect(xpath("//*[@id='oldPassword']").exists())
                .andExpect(xpath("//*[@id='password-form']/p[1]").exists());
    }

    @Test
    public void changePasswordUnsuccessfulTest() throws Exception {
        this.mockMvc.perform(post("/account/change_password")
                        .param("oldPassword", "1112")
                        .param("newPassword", "1")
                        .param("confirmPassword", "1")
                        .with(csrf()))
                .andDo(print())
                .andExpect(content().string(containsString("Старый пароль")))
                .andExpect(content().string(containsString("Неправильный старый пароль!")))
                .andExpect(xpath("//*[@id='password-form']/button").exists())
                .andExpect(xpath("//*[@id='oldPassword']").exists())
                .andExpect(xpath("//*[@id='password-form']/p[1]").exists());
    }
}
