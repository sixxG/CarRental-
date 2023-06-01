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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@WithUserDetails("admin")
@TestPropertySource("/application-test.properties")
@Sql(value = {"/scripts/UserControllerTest/create-admin-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
public class UserControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void userListPageTest() throws Exception {
        this.mockMvc.perform(get("/user"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("Пользователи")))
                .andExpect(content().string(containsString("Администраторы")))
                .andExpect(content().string(containsString("Менеджеры")))
                .andExpect(content().string(containsString("Пользователей с такой ролью не существует!")))
                .andExpect(content().string(containsString("Здравствуйте admin!")))
                .andExpect(xpath("//*[@id='admins']/table/tbody/tr/td[@data-id=1]").exists());
    }

    @Test
    public void userEditPageDataTest() throws Exception {
        this.mockMvc.perform(get("/user/1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(content().string(containsString("UserEditor")))
                .andExpect(content().string(containsString("Roles")))
                .andExpect(xpath("//*[@id='ADMIN'][@checked='checked']").exists());
    }

    @Test
    public void userEditSuccessTest() throws Exception {
        this.mockMvc.perform(post("/user")
                        .param("userName", "newUserNameForManager")
                        .param("ADMIN", "on")
                        .param("userId", "2")
                        .with(csrf()))
                .andDo(print())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/user"));
        this.mockMvc.perform(get("/user").param("name", "admin"))
                .andExpect(xpath("//*[@id='admins']/table/tbody/tr/td[2][@data-id='newUserNameForManager']").exists())
                .andExpect(xpath("//*[@id='admins']/table/tbody/tr/td[2]").exists());
    }

    @Test
    public void userEditUnsuccessfulTest() throws Exception {
        this.mockMvc.perform(post("/user")
//                        .param("userName", "newUserNameForManager")
                        .param("ADMIN", "on")
                        .param("userId", "2")
                        .with(csrf()))
                .andDo(print())
                .andExpect(xpath("//*[@id='MANAGER'][@checked='checked']").exists())
                .andExpect(xpath("//*[@id='inputEmail3'][@value='manager']").exists());
    }
}
