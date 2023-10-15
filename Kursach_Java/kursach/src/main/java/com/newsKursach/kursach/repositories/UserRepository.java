package com.newsKursach.kursach.repositories;


import com.newsKursach.kursach.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    // Дополнительные методы для работы с пользователями
}

