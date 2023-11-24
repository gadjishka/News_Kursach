package com.newsKursach.kursach.entities;

import lombok.Getter;

@Getter
public class EmailRequest {

    // Геттеры
    private String email;
    private String subject;
    private String message;

    // Сеттеры
    public void setEmail(String email) {
        this.email = email;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
