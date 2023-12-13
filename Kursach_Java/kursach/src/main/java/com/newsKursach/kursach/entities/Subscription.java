package com.newsKursach.kursach.entities;

import jakarta.persistence.*;
import lombok.Getter;

@Getter
@Entity
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @ManyToOne
    @JoinColumn(name = "city_id")
    private City city;
    public void setId(Long id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setCity(City city) {
        this.city = city;
    }
}
