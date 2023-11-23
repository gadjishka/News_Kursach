package com.newsKursach.kursach.apiResponse.WeatherAPI;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Clouds {
    private int all;

    // Геттеры и сеттеры для полей

    public void setAll(int all) {
        this.all = all;
    }
}
