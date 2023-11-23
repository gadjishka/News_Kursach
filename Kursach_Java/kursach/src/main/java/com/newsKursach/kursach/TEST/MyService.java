package com.newsKursach.kursach.TEST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class MyService {
    private final StationDataRepository stationDataRepository;
    private final APIService apiService;

    @Autowired
    public MyService(StationDataRepository stationDataRepository, APIService apiService) {
        this.stationDataRepository = stationDataRepository;
        this.apiService = apiService;
    }

    public void processAndSaveData() {
        Country countries = apiService.getData();
        List<StationData> trainStations = new ArrayList<>();

        // Итерируем по каждой стране в массиве
        for (Country.CountryData country : countries.getCountries()) {
            for (Country.CountryData.Region region : country.getRegions()) {
                for (Country.CountryData.Settlement settlement : region.getSettlements()) {
                    for (Country.CountryData.Station station : settlement.getStations()) {
                        // Создаем объект StationData из Station
                        StationData existingStationData = stationDataRepository.findByTitleAndCode(station.getTitle(), station.getCodes().getYandexCode());

                        if (existingStationData == null && Objects.equals(station.getTransportType(), "train")) {
                            // Создаем объект StationData из Station
                            StationData stationData = new StationData(station);
                            // Сохраняем в базу данных
                            stationDataRepository.save(stationData);
                        }
                    }
                }
            }
        }
    }
}