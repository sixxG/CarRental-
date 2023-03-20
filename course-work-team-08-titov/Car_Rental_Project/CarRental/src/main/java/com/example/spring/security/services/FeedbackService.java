package com.example.spring.security.services;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.repositories.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    public boolean editFeedback(Map<String, String> form, String userName) {

        int id = Integer.parseInt(form.get("id"));

        Feedback feedbackBefore = feedbackRepository.findById(id);

        String checkAnonymous = form.get("chekAnonymous");
        String AppealBody = form.get("AppealBody");
        int score = Integer.parseInt(form.get("score"));

        feedbackBefore.setBody(AppealBody);
        feedbackBefore.setScore(score);
        feedbackBefore.setDate(new Date());

        if (checkAnonymous.equals("of")){
            feedbackBefore.setAuthor(userName);
            feedbackRepository.save(feedbackBefore);
        } else {
            feedbackBefore.setAuthor("Анонимный пользователь");
            feedbackRepository.save(feedbackBefore);
        }

        return feedbackRepository.findById(feedbackBefore.getId()) != null;
    }

    public void addFeedback(Map<String, String> form, String userName) {

        String chekAnonymous = form.get("chekAnonymous");
        String AppealBody = form.get("AppealBody");
        int score = Integer.parseInt(form.get("score"));

        if (chekAnonymous.equals("of")){
            Feedback feedback = new Feedback(AppealBody, new Date(), score, userName);
            feedbackRepository.save(feedback);
        } else {
            Feedback feedback = new Feedback(AppealBody, new Date(), score, "Анонимный пользователь");
            feedbackRepository.save(feedback);
        }

    }

}
