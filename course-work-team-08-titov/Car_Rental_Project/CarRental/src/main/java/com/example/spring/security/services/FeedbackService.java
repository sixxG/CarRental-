package com.example.spring.security.services;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.repositories.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    public List<Feedback> findAll() {
        return feedbackRepository.findAll();
    }
    public Feedback findByAuthor(String name) {
        return feedbackRepository.findByAuthor(name);
    }
    @Transactional
    public void editFeedback(Map<String, String> form, String userName) throws ParseException {

        int id = Integer.parseInt(form.get("id"));

        Feedback feedbackBefore = feedbackRepository.findById(id);

        if (form.get("chekAnonymous") == null || form.get("AppealBody") == null)
            return;
        String checkAnonymous = form.get("chekAnonymous");
        String AppealBody = form.get("AppealBody");
        int score = Integer.parseInt(form.get("score"));

        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

        feedbackBefore.setBody(AppealBody);
        feedbackBefore.setScore(score);
        feedbackBefore.setDate(formatter.parse(formatter.format(new Date())));

        if (checkAnonymous.equals("of")){
            feedbackBefore.setAuthor(userName);
            feedbackRepository.save(feedbackBefore);
        } else {
            feedbackBefore.setAuthor("Анонимный пользователь");
            feedbackRepository.save(feedbackBefore);
        }

        feedbackRepository.findById(feedbackBefore.getId());
    }
    @Transactional
    public void addFeedback(Map<String, String> form, String userName) throws ParseException {

        if (form.get("chekAnonymous") == null || form.get("AppealBody") == null)
            return;
        String chekAnonymous = form.get("chekAnonymous");
        String AppealBody = form.get("AppealBody");
        int score = Integer.parseInt(form.get("score"));

        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

        if (chekAnonymous.equals("of")){
            Feedback feedback = new Feedback(AppealBody,  formatter.parse(formatter.format(new Date())), score, userName);
            feedbackRepository.save(feedback);
        } else {
            Feedback feedback = new Feedback(AppealBody, formatter.parse(formatter.format(new Date())), score, "Анонимный пользователь");
            feedbackRepository.save(feedback);
        }
    }

    @Transactional
    public void deleteById(int id) {
        if (feedbackRepository.findById(id) == null)
            return;
        feedbackRepository.deleteById(id);
    }

    public Map<String, Object> sortFeedbackByScore(String revert, int numberPage, int countItemOnPage, Principal user) {
        Map<String, Object> response = new HashMap<>();

        if (user != null) {
            response.put("isFeedbackExist", feedbackRepository.findByAuthor(user.getName()) == null);
        } else {
            response.put("isFeedbackExist", false);
        }

        if (revert.equals("yes")) {
            response.put("feedbacks", feedbackRepository.findAllByOrderByScoreDesc(PageRequest.of(numberPage, countItemOnPage)).toList());
        } else {
            response.put("feedbacks", feedbackRepository.findAllByOrderByScoreAsc(PageRequest.of(numberPage, countItemOnPage)).toList());
        }
        response.putAll(feedbackStatistic());

        response.put("countPage", Math.ceil((double) feedbackRepository.count()/countItemOnPage));
        return response;
    }

    public Map<String, Object> sortFeedbackByDate(Principal user, int numberPage, int countItemOnPage) {
        Map<String, Object> response = new HashMap<>();

        if (user != null) {
            response.put("isFeedbackExist", feedbackRepository.findByAuthor(user.getName()) == null);
        } else {
            response.put("isFeedbackExist", false);
        }
        response.putAll(feedbackStatistic());

        response.put("feedbacks", feedbackRepository.findAllByOrderByDateDesc(PageRequest.of(numberPage, countItemOnPage)).toList());
        response.put("countPage", Math.ceil((double) feedbackRepository.count()/countItemOnPage));
        return response;
    }

    public Map<String, Object> getFeedbackList(int numberPage, Principal user) {
        Map<String, Object> response = new HashMap<>();
        List<Feedback> feedbackList = feedbackRepository.findAll();

        if (user != null) {
            List<Feedback> x = feedbackList.stream().filter(feedback -> feedback.getAuthor().equals(user.getName())).toList();
            response.put("isFeedbackExist",x.isEmpty());
        } else {
            response.put("isFeedbackExist", false);
        }

        response.putAll(feedbackStatistic());

        response.put("countPage", Math.ceil(feedbackList.size()/6f));
        response.put("feedbacks", feedbackList.stream().skip(6L *numberPage).limit(6).collect(Collectors.toList()));

        return response;
    }

    public Map<String, Object> feedbackStatistic() {
        Map<String, Object> response = new HashMap<>();

        long countFeedbacks = feedbackRepository.count();
        double percentPositive = Math.floor((double)(feedbackRepository.countPositiveFeedbacks() * 100) / countFeedbacks);
        double percentNegative = feedbackRepository.countNegativeFeedbacks() != 0 ? Math.floor((double) (feedbackRepository.countNegativeFeedbacks() * 100) / countFeedbacks) : 0;

        response.put("countFeedbacks", countFeedbacks);
        response.put("percentPositive", percentPositive);
        response.put("percentNegative", percentNegative);

        return response;
    }
}
