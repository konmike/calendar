package cz.konecmi4.fit.cvut.auth.web;

import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.model.Image;
import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.auth.repository.ImageRepository;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

    @Autowired
    ImageRepository imageRepository;

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
    public String createCalendar(@ModelAttribute("cal") Calendar c, Principal principal) throws Exception {
        ArrayList<String> arrayList = new ArrayList<>();
        String imagePath = "";

        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else {
            if(c.getSelImage().get(1).contains("data")) {
                for (Object o : c.getSelImage()) {

                    //System.out.println(o);

                    String tmp = o.toString();
                    //System.out.println("tmp:" + tmp);

                /*String[] strings = tmp.split(",");
                String two = strings[1];
                System.out.println("two:" + two);
                for (String string : strings) {
                    System.out.print(string);
                }
                arrayList.add(strings[1]);*/

                    String uuid = UUID.randomUUID().toString();
                    System.out.println("uuid:" + uuid);
                    String[] strings = tmp.split(",");
                    System.out.println("Velikost parsovani: " + strings.length);
//                String one = strings[0];
//                System.out.println("one:" + one);
//                String two = strings[1];
//                System.out.println("two:" + two);
                    String extension;
//TODO funkce na priponu
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

                    imagePath = this.rootLocation.resolve(uuid + "." + extension).toString();
                    System.out.println("imagePath:" + imagePath);

//                    System.out.println("String parse:" + strings[1]);

                    byte[] data = Base64.getDecoder().decode(strings[1]);

                    System.out.println("Konvertovani dat: success");

                    InputStream inputStream = new ByteArrayInputStream(data);
                    System.out.println("Inputstream: success");

                    arrayList.add(imagePath);
                    Image image = new Image(imagePath);
                    imageRepository.save(image);
                    Files.copy(inputStream, this.rootLocation.resolve(imagePath));

                }
            }else{
                String uuid = UUID.randomUUID().toString();
                String extension;
//TODO presunout do funkce
                switch (c.getSelImage().get(0)) {//check image's extension
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

                imagePath = this.rootLocation.resolve(uuid + "." + extension).toString();
                System.out.println("imagePath:" + imagePath);

                byte[] data = Base64.getDecoder().decode(c.getSelImage().get(1));

                System.out.println("Konvertovani dat: success");

                InputStream inputStream = new ByteArrayInputStream(data);
                System.out.println("Inputstream: success");

                arrayList.add(imagePath);
                Image image = new Image(imagePath);
                imageRepository.save(image);
                Files.copy(inputStream, this.rootLocation.resolve(imagePath));
            }
        }
        System.out.println("Zapisujeme, success!");

        /*for (String s:arrayList) {
            System.out.println(s);
        }*/

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        System.out.println(c.getName());

        c.setSelImage(arrayList);
        calendarRepository.save(c);

        Set<Calendar> tmp = user.getCalendars();
        tmp.add(c);
        userRepository.save(user);

        return "redirect:/admin/";
    }

    @GetMapping("/myCalendars")
    public String getCalendars(Model model, Principal principal) throws Exception
    {
        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        Set<Calendar> calSet = user.getCalendars();

        model.addAttribute("calendars",calSet);

        return "/my-calendars";
    }
}
