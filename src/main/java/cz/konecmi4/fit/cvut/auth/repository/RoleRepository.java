package cz.konecmi4.fit.cvut.auth.repository;

import cz.konecmi4.fit.cvut.auth.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;


public interface RoleRepository extends JpaRepository<Role,Long> {

}
