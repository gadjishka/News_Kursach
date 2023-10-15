package com.newsKursach.kursach.entities;

import lombok.Getter;


import lombok.Getter;

@Getter
public class WeatherData {
    private String city;
    private double temperature;
    private String condition;
    private String base;
    private int visibility;
    private int id;
    private String name;
    private double feelsLike;
    private double tempMin;
    private double tempMax;
    private int pressure;
    private int humidity;
    private int seaLevel;
    private int groundLevel;
    private double windSpeed;
    private int windDeg;
    private double windGust;
    private double rain1h;
    private int cloudsAll;
    private long sunrise;
    private long sunset;

    // Геттеры и сеттеры

    public void setCity(String city) {
        this.city = city;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public void setVisibility(int visibility) {
        this.visibility = visibility;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setFeelsLike(double feelsLike) {
        this.feelsLike = feelsLike;
    }

    public void setTempMin(double tempMin) {
        this.tempMin = tempMin;
    }

    public void setTempMax(double tempMax) {
        this.tempMax = tempMax;
    }

    public void setPressure(int pressure) {
        this.pressure = pressure;
    }

    public void setHumidity(int humidity) {
        this.humidity = humidity;
    }

    public void setSeaLevel(int seaLevel) {
        this.seaLevel = seaLevel;
    }

    public void setGroundLevel(int groundLevel) {
        this.groundLevel = groundLevel;
    }

    public void setWindSpeed(double windSpeed) {
        this.windSpeed = windSpeed;
    }

    public void setWindDeg(int windDeg) {
        this.windDeg = windDeg;
    }

    public void setWindGust(double windGust) {
        this.windGust = windGust;
    }

    public void setRain1h(double rain1h) {
        this.rain1h = rain1h;
    }

    public void setCloudsAll(int cloudsAll) {
        this.cloudsAll = cloudsAll;
    }

    public void setSunrise(long sunrise) {
        this.sunrise = sunrise;
    }

    public void setSunset(long sunset) {
        this.sunset = sunset;
    }
}

