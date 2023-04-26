package com.example.spring.security.controllers;

import com.example.spring.security.services.FeedbackService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.text.ParseException;
import java.util.Map;

@Controller
public class FeedbackController {
    private final FeedbackService feedbackService;

    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    @GetMapping("/appeal")
    public String appealList(Model model, Principal user, @RequestParam(defaultValue = "0") int numberPage) {
        Map<String, Object> response = feedbackService.getFeedbackList(numberPage, user);

        model.addAttribute("isFeedbackExist", response.get("isFeedbackExist"));

        model.addAttribute("countFeedbacks", response.get("countFeedbacks").toString());
        model.addAttribute("percentPositive", response.get("percentPositive").toString());
        model.addAttribute("percentNegative", response.get("percentNegative").toString());

        model.addAttribute("countPage", response.get("countPage"));
        model.addAttribute("feedbacks", response.get("feedbacks"));

        return "Appeal/appealList";
    }

    @PostMapping("/feedback")
    public String addFeedback(@RequestParam Map<String, String> form, Principal user) throws ParseException {
        feedbackService.addFeedback(form, user.getName());
        return "redirect:/appeal?numberPage=0";
    }

    @PostMapping("/feedback/edit")
    public String editFeedback(@RequestParam Map<String, String> form,Principal user, HttpServletRequest request) throws ParseException {
        feedbackService.editFeedback(form, user.getName());
        return "redirect:" + request.getHeader("referer");
    }

    @GetMapping("/appeal/bydate")
    public String sortAppealByDate(Model model, Principal user, @RequestParam(defaultValue = "0") int numberPage) {
        Map<String, Object> response = feedbackService.sortFeedbackByDate(user, numberPage, 3);

        model.addAttribute("countFeedbacks", response.get("countFeedbacks").toString());
        model.addAttribute("percentPositive", response.get("percentPositive").toString());
        model.addAttribute("percentNegative", response.get("percentNegative").toString());

        model.addAttribute("isFeedbackExist", response.get("isFeedbackExist"));
        model.addAttribute("feedbacks", response.get("feedbacks"));
        model.addAttribute("countPage", response.get("countPage"));

        return "Appeal/appealList";
    }

    @GetMapping("/appeal/byscore")
    public String sortAppealByScore(@RequestParam String revert, @RequestParam(defaultValue = "0") int numberPage, Model model, Principal user) {
        Map<String, Object> response = feedbackService.sortFeedbackByScore(revert, numberPage, 3, user);

        model.addAttribute("countFeedbacks", response.get("countFeedbacks").toString());
        model.addAttribute("percentPositive", response.get("percentPositive").toString());
        model.addAttribute("percentNegative", response.get("percentNegative").toString());

        model.addAttribute("isFeedbackExist", response.get("isFeedbackExist"));
        model.addAttribute("feedbacks", response.get("feedbacks"));
        model.addAttribute("countPage", response.get("countPage"));

        return "Appeal/appealList";
    }

    @PostMapping("/appeal/delete")
    public String deleteFeedback(@RequestParam int id, HttpServletRequest request) {
        feedbackService.deleteById(id);
        return "redirect:" + request.getHeader("referer");
    }
}
