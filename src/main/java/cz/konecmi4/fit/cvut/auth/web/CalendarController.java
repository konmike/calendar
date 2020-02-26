package cz.konecmi4.fit.cvut.auth.web;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.xml.bind.DatatypeConverter;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
    @Autowired
    CalendarRepository calendarRepository;

    @Autowired
    UserRepository userRepository;

    private Path rootLocation;

    public CalendarController(Path rootLocation) {
        this.rootLocation = rootLocation;
    }

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


    @PostMapping("/create")
    public String createCalendar(@ModelAttribute("cal") Calendar c) throws IOException {
        ArrayList<String> arrayList = new ArrayList<>();

        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else {

            for (Object o : c.getSelImage()) {
                System.out.println(o);

                String tmp = o.toString();
                System.out.println("tmp:" + tmp);

                String[] strings = tmp.split(",");
                String two = strings[1];
                System.out.println("two:" + two);
                for (String string : strings) {
                    System.out.print(string);
                }
                arrayList.add(strings[1]);
                /*String uuid = UUID.randomUUID().toString();
                System.out.println("uuid:" + uuid);
                String[] strings = tmp.split(",");
                String one = strings[0];
                System.out.println("one:" + one);
                String two = strings[1];
                System.out.println("two:" + two);
                String extension;

                switch (strings[0]) {//check image's extension
                    case "data:image/jpeg;base64":
                        extension = "jpeg";
                        break;
                    case "data:image/png;base64":
                        extension = "png";
                        break;
                    default://should write cases for more images types
                        extension = "jpg";
                        break;
                }
                System.out.println("extension:" + extension);

                String imagePath = this.rootLocation.resolve(uuid).toString();
                System.out.println("imagePath:" + imagePath);

                System.out.println("String parse:" + strings[1]);

                byte[] data = Base64.getDecoder().decode(strings[1]);;
                System.out.println("Konvertovani dat: success");

                InputStream inputStream = new ByteArrayInputStream(data);
                System.out.println("Inputstream: success");

                Files.copy(inputStream, this.rootLocation.resolve(imagePath));
                arrayList.add(imagePath);*/
            }
        }

        System.out.println("Zapisujeme, success!");

        for (String s:arrayList) {
            System.out.println(s);
        }

        c.setSelImage(arrayList);

        calendarRepository.save(c);

        return "redirect:/admin/welcome";
    }
}
