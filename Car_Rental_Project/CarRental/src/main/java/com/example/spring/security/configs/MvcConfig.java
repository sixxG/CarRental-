package com.example.spring.security.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.validation.beanvalidation.MethodValidationPostProcessor;
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
        String filePathCars = "C:/Users/Oleg/Desktop/Project-CarRental/CarRental-/Car_Rental_Project/CarRental/src/main/resources/static/img/cars/";
        String filePathImg = "C:/Users/Oleg/Desktop/Project-CarRental/CarRental-/Car_Rental_Project/CarRental/src/main/resources/static/img/";


        registry.addResourceHandler("/imageCar/**")
                .addResourceLocations("file:/"+filePathCars);
        registry.addResourceHandler("/image/**")
                .addResourceLocations("file:/"+filePathImg);
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }

    @Bean
    public LocalValidatorFactoryBean validator() {
        return new LocalValidatorFactoryBean();
    }

    @Bean
    public MethodValidationPostProcessor methodValidationPostProcessor() {
        MethodValidationPostProcessor processor = new MethodValidationPostProcessor();
        processor.setValidator(validator());
        return processor;
    }
}
