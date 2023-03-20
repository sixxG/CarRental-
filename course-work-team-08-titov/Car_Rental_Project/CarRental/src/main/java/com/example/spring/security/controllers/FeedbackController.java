package com.example.spring.security.controllers;

import com.example.spring.security.models.Feedback;
import com.example.spring.security.repositories.FeedbackRepository;
import com.example.spring.security.services.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class FeedbackController {
    @Autowired
    private FeedbackRepository feedbackRepository;

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping("/appeal")
    public String appealList(Model model, Principal user, @RequestParam int numberPage) {

        List<Feedback> feedbackList = feedbackRepository.findAll();

        if (user != null) {
            List<Feedback> x = feedbackList.stream().filter(feedback -> feedback.getAuthor().equals(user.getName())).collect(Collectors.toList());
            model.addAttribute("isFeedbackExist",x.isEmpty());
        } else {
            model.addAttribute("isFeedbackExist", false);
        }
        model.addAttribute("countPage", feedbackList.size()/10);
        model.addAttribute("feedbacks", feedbackList.stream().skip(10L *numberPage).limit(10).collect(Collectors.toList()));

        return "Appeal/appealList";
    }

    @PostMapping("/feedback")
    public String addFeedback(@RequestParam Map<String, String> form, Principal user, Model model) {

        feedbackService.addFeedback(form, user.getName());

        List<Feedback> feedbackList = feedbackRepository.findAll();
        model.addAttribute("countPage", feedbackList.size()/10);

        return "redirect:/appeal?numberPage=0";
    }

    @PostMapping("/feedback/edit")
    public String editFeedback(@RequestParam Map<String, String> form,Principal user, Model model, HttpServletRequest request) {

        if (feedbackService.editFeedback(form, user.getName())) {
            model.addAttribute("message", "Что-то не так! Попробуйте ещё раз или позднее");
        }

        return "redirect:" + request.getHeader("referer");
    }

    @GetMapping("/appeal/bydate")
    public String sortAppealByDate(Model model, Principal user) {

        List<Feedback> feedbackList = feedbackRepository.findAll()
                .stream()
                .sorted(Comparator.comparing(Feedback::getDate))
                .collect(Collectors.toList());

        if (user != null) {
            List<Feedback> x = feedbackList.stream().filter(feedback -> feedback.getAuthor().equals(user.getName())).collect(Collectors.toList());
            model.addAttribute("isFeedbackExist",x.isEmpty());
        } else {
            model.addAttribute("isFeedbackExist", false);
        }

        model.addAttribute("feedbacks", feedbackList);
        model.addAttribute("countPage", 1);

        return "Appeal/appealList";
        //return "redirect:/appeal?numberPage=0";
    }

    @GetMapping("/appeal/byscore")
    public String sortAppealByScore(@RequestParam String revert, Model model, Principal user) {
        List<Feedback> feedbackList = feedbackRepository.findAll().stream().sorted(Comparator.comparing(Feedback::getScore)).collect(Collectors.toList());

        if (user != null) {
            List<Feedback> x = feedbackList.stream().filter(feedback -> feedback.getAuthor().equals(user.getName())).collect(Collectors.toList());
            model.addAttribute("isFeedbackExist",x.isEmpty());
        } else {
            model.addAttribute("isFeedbackExist", false);
        }

        if (revert.equals("yes")) {
            model.addAttribute("feedbacks", feedbackList.stream().sorted(Comparator.comparing(Feedback::getScore).reversed()).collect(Collectors.toList()));
        } else {
            model.addAttribute("feedbacks", feedbackList);
        }

        model.addAttribute("countPage", 1);

        return "Appeal/appealList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/appeal/delete")
    public String deleteFeedback(@RequestParam int id, HttpServletRequest request) {

        Feedback feedback = feedbackRepository.findById(id);

        feedbackRepository.delete(feedback);

        return "redirect:" + request.getHeader("referer");
    }
}
