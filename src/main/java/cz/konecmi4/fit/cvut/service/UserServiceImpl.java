package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Role;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.RoleRepository;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

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
    public void createUser(User user){
        Set<Role> roles = new HashSet<>();
        List<User> users = userRepository.findAll();
        Long id_user = 1L;
        Long id_admin = 2L;
        roles.add(roleRepository.getOne(id_user));
        if(users.isEmpty()) {
            roles.add(roleRepository.getOne(id_admin));
            user.setAdmin(true);
        }
        user.setPassword((bCryptPasswordEncoder.encode((user.getPassword()))));
        user.setRoles(roles);
        userRepository.save(user);
    }

    @Override
    public void setUserRoles(User user) {
        Set<Role> roles = user.getRoles();
        List<User> users = userRepository.findAll();
        Long id_user = 1L;
        Long id_admin = 2L;

        if(users.isEmpty()) {
            roles.add(roleRepository.getOne(id_admin));
            roles.add(roleRepository.getOne(id_user));
            user.setAdmin(true);
        }

        if(user.getAdmin() && user.getRoles().size() == 1){
            roles.add(roleRepository.getOne(id_admin));
        }else if(!user.getAdmin() && user.getRoles().size() == 2){
            Role rAdmin = roleRepository.getOne(id_admin);
            roles.remove(rAdmin);
        }else if(user.getAdmin() && user.getRoles().size() == 0){
            roles.add(roleRepository.getOne(id_admin));
            roles.add(roleRepository.getOne(id_user));
            user.setAdmin(true);
        }else{
            roles.add(roleRepository.getOne(id_user));
        }

        user.setRoles(roles);
        userRepository.save(user);
    }

    @Override
    public void updateUser(User user) {
        userRepository.save(user);
    }

    @Override
    public void updateUserPassword(User user) {
        //Set<Role> roles = user.getRoles();

        user.setPassword((bCryptPasswordEncoder.encode((user.getNewPassword()))));

//        System.out.println(user.getAdmin());
//        if(user.getAdmin() && user.getRoles().size() == 1){
//            Long id_admin = 2L;
//            roles.add(roleRepository.getOne(id_admin));
//        }
//        if(!user.getAdmin() && user.getRoles().size() == 2){
//            Long id_admin = 2L;
//            Role rAdmin = roleRepository.getOne(id_admin);
//            roles.remove(rAdmin);
//        }
//        user.setRoles(roles);
        userRepository.save(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
}
