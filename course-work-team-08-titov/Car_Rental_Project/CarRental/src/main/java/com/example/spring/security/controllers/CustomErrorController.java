package com.example.spring.security.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @RequestMapping("/error")
    public String handlerError(HttpServletRequest request, Model model) {

        int statusCode = (int) request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Exception exception = (Exception) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);

        log.info("Http status code >> " + statusCode);
        log.info("Exception >> " + exception);

        Class<?> exceptionType = (Class<?>) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION_TYPE);
        String errorMessage = (String) request.getAttribute(RequestDispatcher.ERROR_MESSAGE);
        String requestUri = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
        String servletName = (String) request.getAttribute(RequestDispatcher.ERROR_SERVLET_NAME);

        log.info("Exception type >> " + exceptionType);
        log.info("Error message >> " + errorMessage);
        log.info("Request URI >> " + requestUri);
        log.info("Servlet Name >> " + servletName);

        model.addAttribute("statusCode", statusCode);
        model.addAttribute("requestUri", requestUri);
        model.addAttribute("servletName", servletName);

        if (statusCode == 404) {
            return "errors/404";
        } else {
            model.addAttribute("exception", exception);
            model.addAttribute("exceptionType", exceptionType);
            model.addAttribute("errorMessage", errorMessage);
            return "errors/500";
        }
    }

    @RequestMapping("/error_500")
    public String serverError500() {
        int x = 10 / 0;
        return "errors/404";
    }
}
