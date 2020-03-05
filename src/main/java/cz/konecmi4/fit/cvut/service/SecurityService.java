package cz.konecmi4.fit.cvut.service;

public interface SecurityService {
    String findLoggedInUsername();

    void autoLogin(String username, String password);
}
