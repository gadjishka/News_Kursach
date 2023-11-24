package com.newsKursach.kursach.TEST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class MyyController {

    private final MyService myService;
    private final APIService apiService;

    @Autowired
    public MyyController(MyService myService, APIService apiService) {
        this.myService = myService;
        this.apiService = apiService;
    }

    @GetMapping("/data")
    public String processData() {
        // Вызывает метод вашего сервиса для обработки и сохранения данных
        myService.processAndSaveData();

        return "good";
    }
}