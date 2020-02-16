package cz.konecmi4.fit.cvut.auth.repository;

import cz.konecmi4.fit.cvut.auth.model.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
    Image findByName(String name);

}
