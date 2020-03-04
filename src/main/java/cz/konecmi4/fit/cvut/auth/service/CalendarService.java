package cz.konecmi4.fit.cvut.auth.service;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.model.User;

public interface CalendarService {
    public Calendar getCalendar(Long id);
}
