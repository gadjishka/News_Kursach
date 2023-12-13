package com.newsKursach.kursach.services;

import com.newsKursach.kursach.entities.OtpCode;
import com.newsKursach.kursach.repositories.OtpCodeRepository;
import com.newsKursach.kursach.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class OtpCodeService {

    private final OtpCodeRepository otpCodeRepository;

    @Autowired
    public OtpCodeService(OtpCodeRepository otpCodeRepository) {
        this.otpCodeRepository = otpCodeRepository;
    }

    @Transactional
    public void saveOtpCode(User user, String code) {
        LocalDateTime expirationTime = LocalDateTime.now().plusMinutes(60); //код будет действителен в течение часа
        OtpCode otpCode = new OtpCode(user, code, expirationTime);
        otpCodeRepository.save(otpCode);
    }

    public String generateRandomCode() {
        Random random = new Random();
        int randomInt = random.nextInt(10000);
        return String.format("%04d", randomInt);
    }

    @Transactional
    public boolean verifyOtpCode(User user, String code) {
        Optional<OtpCode> optionalOtpCode = otpCodeRepository.findByUserAndCode(user, code);

        if (optionalOtpCode.isPresent()) {
            OtpCode otpCode = optionalOtpCode.get();
            if (otpCode.getExpirationTime().isAfter(LocalDateTime.now())) {
                otpCodeRepository.delete(otpCode);
                return true;
            }
        }

        return false;
    }

    @Transactional
    public void cleanUpExpiredCodes() {
        List<OtpCode> expiredCodes = otpCodeRepository.findByExpirationTimeBefore(LocalDateTime.now());
        otpCodeRepository.deleteAll(expiredCodes);
    }
}