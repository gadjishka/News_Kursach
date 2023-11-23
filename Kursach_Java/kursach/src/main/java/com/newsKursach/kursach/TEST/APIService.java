package com.newsKursach.kursach.TEST;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.newsKursach.kursach.apiResponse.NasaAPI.NasaResponse;
import org.springframework.http.*;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Service
public class APIService {

    private String apiKey = "c06c01e5-8f55-492c-b275-9e5db52ba287";


    public Country getData() {
        String apiUrl = "https://api.rasp.yandex.net/v3.0/stations_list/?apikey=" + apiKey + "&format=json&lang=ru_RU";

        try {
            // Используем RestTemplate для выполнения GET-запроса к API
            RestTemplate restTemplate = new RestTemplate();
            String jsonString = restTemplate.getForObject(apiUrl, String.class);

            // Инициализация ObjectMapper
            ObjectMapper objectMapper = new ObjectMapper();

            // Преобразование JSON-строки в объект
            Country yourObject = objectMapper.readValue(jsonString, Country.class);

            return yourObject;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }
}