package com.example.spring.security.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;
import java.util.List;

@Controller
public class ChartController {

    @GetMapping("/chart")
    public String showChart(Model model) {
        List<String> labels = Arrays.asList("January", "February", "March", "April", "May", "June", "July");
        List<Integer> data = Arrays.asList(65, 59, 80, 81, 56, 55, 40);

        model.addAttribute("labels", labels);
        model.addAttribute("data", data);

        return "graphs";
    }
}