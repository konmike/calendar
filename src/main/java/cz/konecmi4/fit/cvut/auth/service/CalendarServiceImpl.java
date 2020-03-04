package cz.konecmi4.fit.cvut.auth.service;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.repository.CalendarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CalendarServiceImpl implements CalendarService {
    @Autowired
    CalendarRepository calendarRepository;

    @Override
    public Calendar getCalendar(Long id) {
        return calendarRepository.getOne(id);
    }
}
