package com.newsKursach.kursach.repositories;


import com.newsKursach.kursach.entities.City;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository extends JpaRepository<City, Long> {
}
