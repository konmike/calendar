package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Calendar;

import java.util.List;

public interface CalendarService {
    Calendar getCalendar(Long id);
    List<Calendar> getAllCalendars();
    Long saveCalendar(Calendar calendar);
    void deleteCalendar(Long id);
}
