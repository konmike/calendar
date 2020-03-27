package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    Optional<User> findByUsername(String username);
    Optional<User> findById(Long id);
    User findByEmail(String email);

    void createUser(User user);
    void setUserRoles(User user);
    void updateUser(User user);
    void updateUserPassword(User user);
    User getUser(Long id);
    Optional<User> getUserByName(String name);
    List < User > getUsers();
    List < User > getUser(String name);
    void deleteUser(Long id);
}
