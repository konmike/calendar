package cz.konecmi4.fit.cvut.auth.service;

import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.RoleRepository;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @Override
    public List< User > getUsers() {
        return userRepository.findAll();
    }

    @Override
    public List< User > getUser(String name) {
        return userRepository.findByUsernameLike("%"+name+"%");
    }


    @Override
    public User getUser(int id) {
        Long theId = new Long(id);
        return userRepository.getOne(theId);
    }

    @Override
    public void deleteUser(int theId) {
        userRepository.deleteById((long) theId);
    }


    @Override
    public void saveUser(User user){
        user.setPassword((bCryptPasswordEncoder.encode((user.getPassword()))));
        user.setRoles((new HashSet<>(roleRepository.findAll())));
        userRepository.save(user);
    }

    @Override
    public void updateUser(User user) {
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
