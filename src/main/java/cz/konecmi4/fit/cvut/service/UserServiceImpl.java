package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.RoleRepository;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @Override
    public List< User > getUser(String name) {
        return userRepository.findByUsernameLike("%"+name+"%");
    }

    @Override
    public User getUser(Long id) {
        return userRepository.getOne(id);
    }

    @Override
    public Optional<User> getUserByName(String name) {
        return userRepository.findByUsername(name);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public void saveUser(User user){
        user.setPassword((bCryptPasswordEncoder.encode((user.getPassword()))));
        user.setRoles((new HashSet<>(roleRepository.findAll())));
        userRepository.save(user);
    }

    @Override
    public void updateUser(User user) {
        userRepository.save(user);
    }

    @Override
    public void updateUserPassword(User user) {
        user.setPassword((bCryptPasswordEncoder.encode((user.getNewPassword()))));
        userRepository.save(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /*@Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }*/

    /*@Override
    public Iterable<User> findAll() {
        return userRepository.findAll();
    }*/

    /*@Override
    public void saveOrUpdate(User user) {
        if (findById(user.getId()) == null) {
            userRepository.save(user);
        }else {
            userRepository.update(user);
        }

    }*/

    /*@Override
    @Transactional
    public void delete(long id) {
        userRepository.deleteById(id);
    }*/
}
