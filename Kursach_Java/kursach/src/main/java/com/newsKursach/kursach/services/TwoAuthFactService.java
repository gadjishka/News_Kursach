package com.newsKursach.kursach.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TwoAuthFactService {
    // Пример сервиса для работы с двухфакторной аутентификацией

    @Autowired
    private EmailService emailService;

    public void sendTwoFactorAuthenticationCode(String email, String code) {
        String subject = "Код двухфакторной аутентификации";
        String message = "Ваш код: " + code;
        emailService.sendSimpleMessage(email, subject, message);
    }
}


