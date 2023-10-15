package com.newsKursach.kursach.repositories;

import com.newsKursach.kursach.entities.Subscription;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
}

