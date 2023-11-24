package com.newsKursach.kursach.controllers;

import com.newsKursach.kursach.apiResponse.NasaAPI.NasaResponse;
import com.newsKursach.kursach.services.NASAService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/nasa")
public class NasaController {
    @Autowired
    private NASAService nasaService;


    @GetMapping("/{date}")
    public NasaResponse getNasaData(@PathVariable String date) {
        return nasaService.getData(date);
    }
}
