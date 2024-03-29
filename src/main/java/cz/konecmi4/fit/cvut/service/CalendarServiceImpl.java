package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.repository.CalendarRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarServiceImpl implements CalendarService {
    private final CalendarRepository calendarRepository;

    public CalendarServiceImpl(CalendarRepository calendarRepository) {
        this.calendarRepository = calendarRepository;
    }

    @Override
    public Calendar getCalendar(Long id) {
        return calendarRepository.getOne(id);
    }

    @Override
    public List<Calendar> getAllCalendars() {
        return calendarRepository.findAll();
    }

    @Override
    public Long saveCalendar(Calendar calendar) {
        Calendar newCalendar =  calendarRepository.save(calendar);
        return newCalendar.getId();
    }

    @Override
    public void deleteCalendar(Long id) {
        calendarRepository.deleteById(id);
    }
}
