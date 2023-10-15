package com.newsKursach.kursach.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Data
@Entity
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String password;
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;
    // Геттеры и сеттеры

    public User(String username, String password, Role role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }



    public void setPassword(String password) {
        this.password = new BCryptPasswordEncoder().encode(password);
    }


    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }



    public void setRole(Role role) {
        this.role = role;
    }
}

