package com.newsKursach.kursach.controllers;

import com.newsKursach.kursach.entities.EmailRequest;
import com.newsKursach.kursach.services.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;

    @PostMapping("/send-email")
    public String sendEmail(@RequestBody EmailRequest emailRequest) {


        String to = emailRequest.getEmail();
        String subject = emailRequest.getSubject();
        String message = emailRequest.getMessage();

        emailService.sendSimpleMessage(to, subject, message);

        return "Email sent successfully";
    }
}
