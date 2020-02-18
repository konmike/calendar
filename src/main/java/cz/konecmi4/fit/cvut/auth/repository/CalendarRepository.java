package cz.konecmi4.fit.cvut.auth.repository;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CalendarRepository extends JpaRepository<Calendar, Long> {
    Calendar findByName(String name);
}
