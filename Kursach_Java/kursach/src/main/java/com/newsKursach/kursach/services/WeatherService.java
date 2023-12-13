package com.newsKursach.kursach.services;

import com.newsKursach.kursach.apiResponse.WeatherAPI.OpenWeatherMapResponse;

import com.newsKursach.kursach.entities.WeatherData;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherService {
    @Value("e156e27a3826eebeaff26f7eecba4a1d")
    private String weatherApiKey;

    public WeatherData getWeatherData(String cityName) {
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&appid=" + weatherApiKey;

        RestTemplate restTemplate = new RestTemplate();

        OpenWeatherMapResponse response = restTemplate.getForObject(apiUrl, OpenWeatherMapResponse.class);

        if (response != null) {
            WeatherData weatherData = new WeatherData();
            weatherData.setCity(response.getName());
            weatherData.setTemperature(response.getMain().getTemp() - 273.15); // Конвертируем в градусы Цельсия
            weatherData.setCondition(response.getWeather().get(0).getDescription());
            weatherData.setBase(response.getBase());
            weatherData.setVisibility(response.getVisibility());
            weatherData.setId(response.getId());
            weatherData.setFeelsLike(response.getMain().getFeels_like());
            weatherData.setTempMin(response.getMain().getTemp_min() - 273.15);
            weatherData.setTempMax(response.getMain().getTemp_max() - 273.15);
            weatherData.setPressure(response.getMain().getPressure());
            weatherData.setHumidity(response.getMain().getHumidity());
            weatherData.setSeaLevel(response.getMain().getSea_level());
            weatherData.setGroundLevel(response.getMain().getGrnd_level());
            weatherData.setWindSpeed(response.getWind().getSpeed());
            weatherData.setWindDeg(response.getWind().getDeg());
            weatherData.setWindGust(response.getWind().getGust());
            if (response.getRain() != null) {
                weatherData.setRain1h(response.getRain().getRain1h());
            }
            weatherData.setCloudsAll(response.getClouds().getAll());
            weatherData.setSunrise(response.getSys().getSunrise());
            weatherData.setSunset(response.getSys().getSunset());

            return weatherData;
        } else {
            return null;
        }
    }
}

