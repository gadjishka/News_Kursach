package com.newsKursach.kursach.TEST;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.util.Objects;

@Entity
public class StationData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String code;

    // геттеры и сеттеры

    public StationData() {
    }

    // конструктор для создания StationData из Station
    public StationData(Country.CountryData.Station station) {
        this.title = station.getTitle();
        this.code = station.getCodes().getYandexCode();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StationData that = (StationData) o;
        return Objects.equals(title, that.title) && Objects.equals(code, that.code);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, code);
    }
}