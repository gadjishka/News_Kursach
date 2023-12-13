package com.newsKursach.kursach.services;

import com.newsKursach.kursach.apiResponse.NasaAPI.NasaResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Objects;

@Service
public class NASAService {

    @Value("QtXaKbPv2H4dPIHuhQzK4CaR4tJMNa4xrbdk2igY")
    private String nasaApiKey;

    public NasaResponse getData(String date) {
        String apiUrl = "https://api.nasa.gov/planetary/apod?api_key=" + nasaApiKey;

        if (!Objects.equals(date, "today")) {
            apiUrl += "&date=" + date;
        }

        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(apiUrl, NasaResponse.class);
    }
}
