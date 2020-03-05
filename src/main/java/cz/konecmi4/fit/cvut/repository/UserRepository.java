package cz.konecmi4.fit.cvut.repository;

import cz.konecmi4.fit.cvut.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {


    Optional<User> findByUsername(String username);

    List<User> findByUsernameLike(String username);
    //Optional<User> findByName(String username);
}
