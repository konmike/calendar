package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Calendar;

public interface CalendarService {
    Calendar getCalendar(Long id);
    Long saveCalendar(Calendar calendar);
}
