package com.newsKursach.kursach.repositories;

import com.newsKursach.kursach.entities.OtpCode;
import com.newsKursach.kursach.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface OtpCodeRepository extends JpaRepository<OtpCode, Long> {

    Optional<OtpCode> findByUserAndCode(User user, String code);

    List<OtpCode> findByExpirationTimeBefore(LocalDateTime now);
}