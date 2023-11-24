package com.newsKursach.kursach.repositories;


import com.newsKursach.kursach.entities.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {

    Role findByRoleName(String user);
}
