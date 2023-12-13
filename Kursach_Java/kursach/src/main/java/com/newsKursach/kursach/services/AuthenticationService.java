package com.newsKursach.kursach.services;


import com.newsKursach.kursach.apiResponse.Auth.AuthenticationRequest;
import com.newsKursach.kursach.apiResponse.Auth.AuthenticationResponse;
import com.newsKursach.kursach.apiResponse.Auth.PreAuthenticationRequest;
import com.newsKursach.kursach.apiResponse.Auth.RegisterRequest;
import com.newsKursach.kursach.config.jwtConfig.JwtService;
import com.newsKursach.kursach.entities.Role;
import com.newsKursach.kursach.entities.User;
import com.newsKursach.kursach.repositories.RoleRepository;
import com.newsKursach.kursach.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final RoleRepository roleRepository;
    private final OtpCodeService otpCodeService;
    private final EmailService emailService;


    public AuthenticationResponse register(RegisterRequest request) {
        var user = User.builder()
                .firstname(request.getFirstname())
                .lastname(request.getLastname())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))

                .build();
        Role userRole = roleRepository.findByRoleName("USER");
        if (userRole == null) {
            userRole = new Role();
            userRole.setRoleName("USER");
            roleRepository.save(userRole);
        }

        // Устанавливаем роль ROLE_USER для пользователя
        user.setRole(userRole);

        user.setFavCity(null);

        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }

    public String preAuthenticate(PreAuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        var user = repository.findByEmail(request.getEmail())
                .orElseThrow(() -> new NoSuchElementException("User not found"));

        var code = otpCodeService.generateRandomCode();

        otpCodeService.saveOtpCode(user, code);
        emailService.sendSimpleMessage(user.getEmail(), code);

        return "come on";
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {

        String mail = request.getEmail();
        String code = request.getCode();

        var user = repository.findByEmail(mail)
                .orElseThrow();
        if (otpCodeService.verifyOtpCode(user, code)) {
            var jwtToken = jwtService.generateToken(user);
            return AuthenticationResponse.builder()
                    .token(jwtToken)
                    .build();
        } else {
            return null;
        }
    }

}
