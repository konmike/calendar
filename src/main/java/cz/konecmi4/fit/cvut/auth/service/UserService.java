package cz.konecmi4.fit.cvut.auth.service;

import cz.konecmi4.fit.cvut.auth.model.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    User findByUsername(String username);

    public void saveUser(User user);
    public void updateUser(User user);
    public User getUser(int theId);
    public List < User > getUsers();
    public void deleteUser(int theId);
}
