package cz.konecmi4.fit.cvut.repository;

import cz.konecmi4.fit.cvut.model.Calendar;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CalendarRepository extends JpaRepository<Calendar, Long> {
    Calendar findByName(String name);
}
