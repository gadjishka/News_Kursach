package com.newsKursach.kursach.controllers;

import com.newsKursach.kursach.apiResponse.Auth.AuthenticationRequest;
import com.newsKursach.kursach.apiResponse.Auth.AuthenticationResponse;
import com.newsKursach.kursach.apiResponse.Auth.RegisterRequest;
import com.newsKursach.kursach.config.jwtConfig.JwtService;
import com.newsKursach.kursach.services.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService service;
    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register (
            @RequestBody RegisterRequest request
    ) {
        return ResponseEntity.ok(service.register(request));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate (
            @RequestBody AuthenticationRequest request
    ) {
        return ResponseEntity.ok(service.authenticate(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<?> refreshToken(HttpServletRequest request) {
        String authToken = request.getHeader("Authorization");
        if (authToken != null && authToken.startsWith("Bearer ")) {
            authToken = authToken.substring(7);

            String username = jwtService.extractUsername(authToken);
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);

            if (jwtService.isTokenValid(authToken, userDetails)) {
                // Генерируем новый токен с обновленным временем истечения
                String newToken = jwtService.generateToken(userDetails);

                // Отправляем новый токен как ответ
                return ResponseEntity.ok(newToken);
            }
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }



}
