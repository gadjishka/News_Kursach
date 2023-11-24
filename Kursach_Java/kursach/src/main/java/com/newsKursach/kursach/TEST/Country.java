package com.newsKursach.kursach.TEST;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;

import java.util.List;


@Getter
public class Country {
    private List<CountryData> countries;

    public void setCountries(List<CountryData> countries) {
        this.countries = countries;
    }
    @JsonIgnoreProperties(ignoreUnknown = true)
    @Getter
    public static class CountryData {
        private String title;
        private Codes codes;
        private List<Region> regions;

        public void setTitle(String title) {
            this.title = title;
        }

        public void setCodes(Codes codes) {
            this.codes = codes;
        }

        public void setRegions(List<Region> regions) {
            this.regions = regions;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        @Getter
        public static class Region {
            private String title;
            private Codes codes;
            private List<Settlement> settlements;

            // Геттеры и сеттеры

            public void setTitle(String title) {
                this.title = title;
            }

            public void setCodes(Codes codes) {
                this.codes = codes;
            }

            public void setSettlements(List<Settlement> settlements) {
                this.settlements = settlements;
            }
        }
        @JsonIgnoreProperties(ignoreUnknown = true)
        @Getter
        public static class Settlement {
            private String title;
            private Codes codes;
            private List<Station> stations;

            // Геттеры и сеттеры

            public void setTitle(String title) {
                this.title = title;
            }

            public void setCodes(Codes codes) {
                this.codes = codes;
            }

            public void setStations(List<Station> stations) {
                this.stations = stations;
            }
        }
        @JsonIgnoreProperties(ignoreUnknown = true)
        @Getter
        public static class Station {
            private String direction;
            private Codes codes;

            private String station_type;
            private String title;
            private double longitude;
            @JsonProperty("transport_type")
            private String transportType;
            private double latitude;

            // Геттеры и сеттеры


            public void setDirection(String direction) {
                this.direction = direction;
            }


            public void setCodes(Codes codes) {
                this.codes = codes;
            }

            public void setStationType(String stationType) {
                this.station_type = stationType;
            }


            public void setTitle(String title) {
                this.title = title;
            }


            public void setLongitude(double longitude) {
                this.longitude = longitude;
            }


            public void setTransportType(String transportType) {
                this.transportType = transportType;
            }


            public void setLatitude(double latitude) {
                this.latitude = latitude;
            }
        }
        @JsonIgnoreProperties(ignoreUnknown = true)
        @Getter
        public static class Codes {
            @JsonProperty("yandex_code")
            private String yandexCode;

            // геттер и сеттер

            public void setYandexCode(String yandexCode) {
                this.yandexCode = yandexCode;
            }

            public Codes() {
            }
        }
    }
}