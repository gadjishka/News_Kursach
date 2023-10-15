package com.newsKursach.kursach.apiResponse;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;

import java.util.List;


@Getter
@JsonIgnoreProperties(ignoreUnknown = true)
public class OpenWeatherMapResponse {
    private String base;
    private int visibility;
    private int id;
    private String name;

    @JsonProperty("weather")
    private List<Weather> weather;

    @JsonProperty("main")
    private Main main;

    @JsonProperty("wind")
    private Wind wind;

    @JsonProperty("rain")
    private Rain rain;

    @JsonProperty("clouds")
    private Clouds clouds;

    @JsonProperty("sys")
    private Sys sys;

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

    // Геттеры и сеттеры для остальных полей

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Weather {
        private int id;
        private String main;
        private String description;
        private String icon;

        // Геттеры и сеттеры для полей

        public void setId(int id) {
            this.id = id;
        }

        public void setMain(String main) {
            this.main = main;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public void setIcon(String icon) {
            this.icon = icon;
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Main {
        private double temp;
        private double feels_like;
        private double temp_min;
        private double temp_max;
        private int pressure;
        private int humidity;
        private int sea_level;
        private int grnd_level;

        // Геттеры и сеттеры для полей

        public void setTemp(double temp) {
            this.temp = temp;
        }

        public void setFeels_like(double feels_like) {
            this.feels_like = feels_like;
        }

        public void setTemp_min(double temp_min) {
            this.temp_min = temp_min;
        }

        public void setTemp_max(double temp_max) {
            this.temp_max = temp_max;
        }

        public void setPressure(int pressure) {
            this.pressure = pressure;
        }

        public void setHumidity(int humidity) {
            this.humidity = humidity;
        }

        public void setSea_level(int sea_level) {
            this.sea_level = sea_level;
        }

        public void setGrnd_level(int grnd_level) {
            this.grnd_level = grnd_level;
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Wind {
        private double speed;
        private int deg;
        private double gust;

        // Геттеры и сеттеры для полей

        public void setSpeed(double speed) {
            this.speed = speed;
        }

        public void setDeg(int deg) {
            this.deg = deg;
        }

        public void setGust(double gust) {
            this.gust = gust;
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Rain {
        @JsonProperty("1h")
        private double rain1h;

        // Геттеры и сеттеры для полей

        public void setRain1h(double rain1h) {
            this.rain1h = rain1h;
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Clouds {
        private int all;

        // Геттеры и сеттеры для полей

        public void setAll(int all) {
            this.all = all;
        }
    }

    @Getter
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Sys {
        private long sunrise;
        private long sunset;

        // Геттеры и сеттеры для полей

        public void setSunrise(long sunrise) {
            this.sunrise = sunrise;
        }

        public void setSunset(long sunset) {
            this.sunset = sunset;
        }
    }

}