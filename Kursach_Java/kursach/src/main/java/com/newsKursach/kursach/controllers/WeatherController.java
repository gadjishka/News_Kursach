package com.newsKursach.kursach.controllers;


import com.newsKursach.kursach.entities.WeatherData;
import com.newsKursach.kursach.services.WeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/weather")
public class WeatherController {
    @Autowired
    private WeatherService weatherService;

    @GetMapping("/city/{cityName}")
    public WeatherData getWeatherData(@PathVariable String cityName) {
        return weatherService.getWeatherData(cityName);
    }
}