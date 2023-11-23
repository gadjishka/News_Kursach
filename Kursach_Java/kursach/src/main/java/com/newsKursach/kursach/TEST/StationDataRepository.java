package com.newsKursach.kursach.TEST;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StationDataRepository extends JpaRepository<StationData, Long> {

    StationData findByTitleAndCode(String title, String code);
}

