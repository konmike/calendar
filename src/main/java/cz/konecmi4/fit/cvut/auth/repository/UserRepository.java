package cz.konecmi4.fit.cvut.auth.repository;

import cz.konecmi4.fit.cvut.auth.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
