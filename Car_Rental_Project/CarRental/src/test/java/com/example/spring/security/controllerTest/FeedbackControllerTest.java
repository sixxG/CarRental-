package com.example.spring.security.controllerTest;

import com.example.spring.security.models.Feedback;
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

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
@Sql(value = {"/scripts/UserControllerTest/create-admin-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/UserControllerTest/create-admin-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = {"/scripts/FeedbackControllerTest/create-feedbacks-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@Sql(value = {"/scripts/FeedbackControllerTest/create-feedbacks-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
@Sql(value = "/scripts/FeedbackControllerTest/remove-auto_increment-before.sql", executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
@WithUserDetails("admin")
public class FeedbackControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Test
    public void appealListPageTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        feedbacks.add(new Feedback(1, "Отличный сервис, рекомендую!", formatter.parse("2023-04-20"), 4, "Иванов Петр Сергеевич"));
        feedbacks.add(new Feedback(2, "Плохое обслуживание, не вернусь сюда", formatter.parse("2023-04-18"), 2, "Александрова Ольга Ивановна"));
        feedbacks.add(new Feedback(3, "Всё отлично, спасибо!", formatter.parse("2023-04-17"), 5, "Петров Андрей Васильевич"));
        feedbacks.add(new Feedback(4, "Неплохой сервис, но есть недостатки", formatter.parse("2023-04-15"), 3, "Сидоров Николай Иванович"));
        feedbacks.add(new Feedback(5, "Совсем не понравилось, не рекомендую", formatter.parse("2023-04-14"), 1, "Анонимный пользователь"));
        feedbacks.add(new Feedback(6, "Удобное расположение и хорошие цены", formatter.parse("2023-04-12"), 4, "Иванов Сергей Викторович"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));
        feedbacks.add(new Feedback(10, "Нормальный сервис, но можно было и лучше", formatter.parse("2023-04-06"), 3, "Петров Сергей Иванович"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "3"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));
    }

    @Test
    public void appealListByDatePageTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        feedbacks.add(new Feedback(1, "Отличный сервис, рекомендую!", formatter.parse("2023-04-20"), 4, "Иванов Петр Сергеевич"));
        feedbacks.add(new Feedback(2, "Плохое обслуживание, не вернусь сюда", formatter.parse("2023-04-18"), 2, "Александрова Ольга Ивановна"));
        feedbacks.add(new Feedback(3, "Всё отлично, спасибо!", formatter.parse("2023-04-17"), 5, "Петров Андрей Васильевич"));

        this.mockMvc.perform(get("/appeal/bydate")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(4, "Неплохой сервис, но есть недостатки", formatter.parse("2023-04-15"), 3, "Сидоров Николай Иванович"));
        feedbacks.add(new Feedback(5, "Совсем не понравилось, не рекомендую", formatter.parse("2023-04-14"), 1, "Анонимный пользователь"));
        feedbacks.add(new Feedback(6, "Удобное расположение и хорошие цены", formatter.parse("2023-04-12"), 4, "Иванов Сергей Викторович"));

        this.mockMvc.perform(get("/appeal/bydate")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(10, "Нормальный сервис, но можно было и лучше", formatter.parse("2023-04-06"), 3, "Петров Сергей Иванович"));

        this.mockMvc.perform(get("/appeal/bydate")
                        .param("numberPage", "3"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        this.mockMvc.perform(get("/appeal/bydate")
                        .param("numberPage", "4"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));
    }

    @Test
    public void appealListByScoreNotRevertPageTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        feedbacks.add(new Feedback(5, "Совсем не понравилось, не рекомендую", formatter.parse("2023-04-14"), 1, "Анонимный пользователь"));
        feedbacks.add(new Feedback(2, "Плохое обслуживание, не вернусь сюда", formatter.parse("2023-04-18"), 2, "Александрова Ольга Ивановна"));
        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "0")
                        .param("revert", "no"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0));
                //.andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(4, "Неплохой сервис, но есть недостатки", formatter.parse("2023-04-15"), 3, "Сидоров Николай Иванович"));
        feedbacks.add(new Feedback(10, "Нормальный сервис, но можно было и лучше", formatter.parse("2023-04-06"), 3, "Петров Сергей Иванович"));
        feedbacks.add(new Feedback(1, "Отличный сервис, рекомендую!", formatter.parse("2023-04-20"), 4, "Иванов Петр Сергеевич"));

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "1")
                        .param("revert", "no"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "3")
                        .param("revert", "no"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "4")
                        .param("revert", "no"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));
    }

    @Test
    public void appealListByScoreWithRevertPageTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        feedbacks.add(new Feedback(3, "Всё отлично, спасибо!", formatter.parse("2023-04-17"), 5, "Петров Андрей Васильевич"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));
        feedbacks.add(new Feedback(1, "Отличный сервис, рекомендую!", formatter.parse("2023-04-20"), 4, "Иванов Петр Сергеевич"));


        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "0")
                        .param("revert", "yes"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(6, "Удобное расположение и хорошие цены", formatter.parse("2023-04-12"), 4, "Иванов Сергей Викторович"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(4, "Неплохой сервис, но есть недостатки", formatter.parse("2023-04-15"), 3, "Сидоров Николай Иванович"));


        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "1")
                        .param("revert", "yes"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        feedbacks.add(new Feedback(5, "Совсем не понравилось, не рекомендую", formatter.parse("2023-04-14"), 1, "Анонимный пользователь"));

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "3")
                        .param("revert", "yes"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

        feedbacks.clear();

        this.mockMvc.perform(get("/appeal/byscore")
                        .param("numberPage", "4")
                        .param("revert", "yes"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }

    @Test
    public void addFeedbackSuccessTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        this.mockMvc.perform(post("/feedback")
                        .param("chekAnonymous", "of")
                        .param("AppealBody", "all is good")
                        .param("score", "5")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/appeal?numberPage=0"));

        feedbacks.add(new Feedback(11, "all is good", formatter.parse(formatter.format(new Date())), 5, "admin"));
        feedbacks.add(new Feedback(1, "Отличный сервис, рекомендую!", formatter.parse("2023-04-20"), 4, "Иванов Петр Сергеевич"));
        feedbacks.add(new Feedback(2, "Плохое обслуживание, не вернусь сюда", formatter.parse("2023-04-18"), 2, "Александрова Ольга Ивановна"));

        this.mockMvc.perform(get("/appeal/bydate")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", false))
                .andExpect(model().attribute("countFeedbacks", "11"))
                .andExpect(model().attribute("percentPositive", "54.0"))
                .andExpect(model().attribute("percentNegative", "45.0"))
                .andExpect(model().attribute("countPage", 4.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }

    @Test
    public void addFeedbackUnsuccessfulTest() throws Exception {

        this.mockMvc.perform(post("/feedback")
                        .param("chekAnonymous", "of")
//                        .param("AppealBody", "all is good")
                        .param("score", "5")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/appeal?numberPage=0"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0));
    }

    @Test
    public void deleteFeedbackSuccessTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        this.mockMvc.perform(post("/appeal/delete")
                        .param("id", "10")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "9"))
                .andExpect(model().attribute("percentPositive", "55.0"))
                .andExpect(model().attribute("percentNegative", "44.0"))
                .andExpect(model().attribute("countPage", 2.0));

        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "9"))
                .andExpect(model().attribute("percentPositive", "55.0"))
                .andExpect(model().attribute("percentNegative", "44.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }

    @Test
    public void deleteFeedbackUnsuccessfulTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        this.mockMvc.perform(post("/appeal/delete")
                        .param("id", "11")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0));

        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));
        feedbacks.add(new Feedback(10, "Нормальный сервис, но можно было и лучше", formatter.parse("2023-04-06"), 3, "Петров Сергей Иванович"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }

    @Test
    public void editFeedbackSuccessTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        this.mockMvc.perform(post("/feedback/edit")
                        .param("id", "10")
                        .param("chekAnonymous", "of")
                        .param("AppealBody", "new feedback body")
                        .param("score", "5")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", false))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "60.0"))
                .andExpect(model().attribute("percentNegative", "40.0"))
                .andExpect(model().attribute("countPage", 2.0));

        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));
        feedbacks.add(new Feedback(10, "new feedback body", formatter.parse(formatter.format(new Date())), 5, "admin"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", false))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "60.0"))
                .andExpect(model().attribute("percentNegative", "40.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }

    @Test
    public void editFeedbackUnsuccessfulTest() throws Exception {
        List<Feedback> feedbacks =  new ArrayList<>();
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        this.mockMvc.perform(post("/feedback/edit")
                        .param("id", "10")
                        .param("chekAnonymous", "of")
//                        .param("AppealBody", "new feedback body")
                        .param("score", "5")
                        .with(user("admin"))
                        .with(csrf()))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("null"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "0"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0));

        feedbacks.add(new Feedback(7, "Очень дорого, не оправдывает своих цен", formatter.parse("2023-04-11"), 2, "Петрова Мария Васильевна"));
        feedbacks.add(new Feedback(8, "Всё было отлично, но машину выдали с опозданием", formatter.parse("2023-04-10"), 4, "Сидорова Елена Александровна"));
        feedbacks.add(new Feedback(9, "Удобно заказывать и быстрая выдача машины", formatter.parse("2023-04-08"), 5, "Анонимный пользователь"));
        feedbacks.add(new Feedback(10, "Нормальный сервис, но можно было и лучше", formatter.parse("2023-04-06"), 3, "Петров Сергей Иванович"));

        this.mockMvc.perform(get("/appeal")
                        .param("numberPage", "1"))
                .andDo(print())
                .andExpect(authenticated())
                .andExpect(status().isOk())
                .andExpect(view().name("Appeal/appealList"))
                .andExpect(model().attribute("isFeedbackExist", true))
                .andExpect(model().attribute("countFeedbacks", "10"))
                .andExpect(model().attribute("percentPositive", "50.0"))
                .andExpect(model().attribute("percentNegative", "50.0"))
                .andExpect(model().attribute("countPage", 2.0))
                .andExpect(model().attribute("feedbacks", feedbacks));

    }
}
