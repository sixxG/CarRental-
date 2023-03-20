package com.example.spring.security.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Value("${upload.path}")
    private String uploadPath;

    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("Account/Login");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String filePathCars = "C:/Users/Oleg/Desktop/Car_Rental_Java/course-work-team-08-titov/Car_Rental_Project/CarRental/src/main/resources/static/img/cars/";
        String filePathImg = "C:/Users/Oleg/Desktop/Car_Rental_Java/course-work-team-08-titov/Car_Rental_Project/CarRental/src/main/resources/static/img/";


        registry.addResourceHandler("/imageCar/**")
                .addResourceLocations("file:/"+filePathCars);
        registry.addResourceHandler("/image/**")
                .addResourceLocations("file:/"+filePathImg);
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}
