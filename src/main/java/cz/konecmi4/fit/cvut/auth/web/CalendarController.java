package cz.konecmi4.fit.cvut.auth.web;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.Set;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
    @Autowired
    CalendarRepository calendarRepository;

    @Autowired
    UserRepository userRepository;

    @RequestMapping("/")
    public String showCalendar(@ModelAttribute("cal") Calendar c, Principal principal) throws Exception
    {
        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else {
            for (Object o : c.getSelImage()) {
                System.out.println(o);
            }
        }

        /*System.out.println("Kalendaris");
        System.out.println(c.getName());
        System.out.println(c.getYear());
        System.out.println(c.getSelImage());
        System.out.println("==== END Kalendaris ====");*/

        calendarRepository.save(c);

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        Set<Calendar> calSet = user.getCalendars();
        calSet.add(c);
        user.setCalendars(calSet);

        userRepository.save(user);

        return "image/showCheck";
    }
}
