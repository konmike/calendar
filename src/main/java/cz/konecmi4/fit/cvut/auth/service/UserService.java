package cz.konecmi4.fit.cvut.auth.service;

import cz.konecmi4.fit.cvut.auth.model.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    Optional<User> findByUsername(String username);

    public void saveUser(User user);
    public void updateUser(User user);
    public User getUser(int id);
    public List < User > getUsers();
    public List < User > getUser(String name);
    public void deleteUser(int id);
}
