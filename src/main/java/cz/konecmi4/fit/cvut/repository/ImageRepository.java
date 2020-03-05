package cz.konecmi4.fit.cvut.repository;

import cz.konecmi4.fit.cvut.model.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
    Image findByName(String name);

}
