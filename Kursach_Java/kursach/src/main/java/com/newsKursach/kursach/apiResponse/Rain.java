package com.newsKursach.kursach.apiResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;

@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Rain {
    @JsonProperty("1h")
    private double rain1h;

    // Геттеры и сеттеры для полей

    public void setRain1h(double rain1h) {
        this.rain1h = rain1h;
    }
}