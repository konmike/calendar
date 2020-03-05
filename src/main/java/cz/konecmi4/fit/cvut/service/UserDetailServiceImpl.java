package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Role;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class UserDetailServiceImpl implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Override
    @Transactional(readOnly=true)
    public UserDetails loadUserByUsername(String username){


//        return userRepository.findByUsername(username)
//                .map(user -> new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
//                        AuthorityUtils.createAuthorityList("USER")
//                ))
//                .orElseThrow(() -> new UsernameNotFoundException("can't find"));

        Optional<User> user = userRepository.findByUsername(username);
        if(!user.isPresent()) throw new UsernameNotFoundException(username);

        String name = user.get().getUsername();

        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        for(Role role : user.get().getRoles()){
            grantedAuthorities.add(new SimpleGrantedAuthority(role.getName()));
        }

        return new org.springframework.security.core.userdetails.User(
                user.get().getUsername(),
                user.get().getPassword(),
                grantedAuthorities);
    }
}
