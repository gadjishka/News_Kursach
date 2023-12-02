package com.newsKursach.kursach.services;


import com.newsKursach.kursach.apiResponse.Auth.AuthenticationRequest;
import com.newsKursach.kursach.apiResponse.Auth.AuthenticationResponse;
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

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final RoleRepository roleRepository;
    public AuthenticationResponse register(RegisterRequest request) {
    //TODO: ПРоверка польщователя на существование
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

        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
        var user = repository.findByEmail(request.getEmail())
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }

}
