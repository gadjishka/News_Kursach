package com.newsKursach.kursach.services;

import com.newsKursach.kursach.services.OtpCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender emailSender;

    @Autowired
    private OtpCodeService otpCodeService;

    public void sendSimpleMessage(String to, String code) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("Verification code");
        message.setText("Code for you: " + code);
        emailSender.send(message);
    }
}