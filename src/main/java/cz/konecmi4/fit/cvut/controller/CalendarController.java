package cz.konecmi4.fit.cvut.controller;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.repository.ImageRepository;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import cz.konecmi4.fit.cvut.service.CalendarService;
import cz.konecmi4.fit.cvut.service.ImageService;
import cz.konecmi4.fit.cvut.service.UserService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.*;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

    private final CalendarRepository calendarRepository;
    private final UserRepository userRepository;
    private final CalendarService calendarService;
    private final UserService userService;
    private final ImageService imageService;


    private Path rootLocation;

    public CalendarController(CalendarRepository calendarRepository, UserRepository userRepository, CalendarService calendarService, UserService userService, ImageService imageService, Path rootLocation) {
        this.calendarRepository = calendarRepository;
        this.userRepository = userRepository;
        this.calendarService = calendarService;
        this.userService = userService;
        this.imageService = imageService;
        this.rootLocation = rootLocation;
    }

    @GetMapping()
    public String getCalendar(@RequestParam("calId") Long calId, Model model, Principal principal) throws Exception
    {
        Calendar calendar = calendarService.getCalendar(calId);

        //User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        //Set<Calendar> calSet = user.getCalendars();

        System.out.println("V show funkci:");
        System.out.println(calendar.getImages());

        //List<Image> sort = calendar.getImages();

//        ArrayList<String> tmp = calendar.getImages().stream()
//                .map(image -> this.rootLocation.resolve(image.getName()))
//                .map(path -> MvcUriComponentsBuilder
//                        .fromMethodName(CalendarController.class, "serveFile", path.getFileName().toString()).build()
//                        .toString()).collect(Collectors.toCollection(ArrayList::new));
//(Supplier<ArrayList<String>>)

        System.out.println("V show funkci 2:");
        //System.out.println(tmp);

        model.addAttribute("cal",calendar);
        model.addAttribute("calImage",calendar.getSelImage());

        return "/show-calendar";
    }

    @PostMapping("/create")
    public String createCalendar(@ModelAttribute("cal") Calendar c, Principal principal) throws Exception{
        Optional <User> user = userService.getUserByName(principal.getName());

        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else{
            for (Object o: c.getSelImage()) {
                System.out.println(o);
                String tmp = o.toString();
                System.out.println(tmp);

                String extension = FilenameUtils.getExtension(tmp);
                System.out.println(extension);
                System.out.println("=========================");
            }
        }

        calendarService.saveCalendar(c);

        Set<Calendar> tmp = user.get().getCalendars();
        tmp.add(c);
        userService.updateUser(user.get());

        //return "redirect:/calendar/myCalendars";
        return "redirect:/calendar?name=" + c.getName();
    }

    /*@PostMapping("/create")
    public String createCalendar(@ModelAttribute("cal") Calendar c, Principal principal) throws Exception {
        ArrayList<String> arrayList = new ArrayList<>();
        String imagePath = "";
        LinkedHashSet<Image> images = new LinkedHashSet<>();

        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else {

            for (Object o : c.getSelImage()) {

                System.out.println(o);
                String tmp = o.toString();
                System.out.println(tmp);


                if (tmp.equals("null")) {
                    System.out.println("prazdny image");
                    //String uuid = UUID.randomUUID().toString();
                    String extension = "nothing";
                    imagePath = this.rootLocation.resolve(extension).toString();
                    arrayList.add(imagePath);
                    images.add(new Image(imagePath));


                    continue;
                }
                //System.out.println("tmp:" + tmp);

//                String[] strings = tmp.split(",");
//                String two = strings[1];
//                System.out.println("two:" + two);
//                for (String string : strings) {
//                    System.out.print(string);
//                }
//                arrayList.add(strings[1]);

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
//                    Image image = new Image(imagePath);
//                    imageRepository.save(image);
                images.add(new Image(imagePath));
                Files.copy(inputStream, this.rootLocation.resolve(imagePath));

            }
        }
        System.out.println("Zapisujeme, success!");

        for (String s:arrayList) {
            System.out.println(s);
        }

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        System.out.println(c.getName());

        System.out.println("ArrayList:");
        System.out.println(arrayList);

        System.out.println("LinkedHashSet:");
        System.out.println(images);

        c.setSelImage(arrayList);
        c.setImages(images);
        calendarService.saveCalendar(c);

        Set<Calendar> tmp = user.getCalendars();
        tmp.add(c);
        userRepository.save(user);

        return "redirect:/calendar?name=" + c.getName();
    }*/

    @GetMapping("/myCalendars")
    public String getCalendars(Model model, Principal principal) throws Exception
    {
        Optional<User> user = userService.getUserByName(principal.getName());
        System.out.println(user.get().getUsername());

        Set<Calendar> calendars = user.get().getCalendars();

        ArrayList<String> frontPages = new ArrayList<>();

        for (Calendar cal : calendars) {
            System.out.println(cal.getSelImage());
            if(cal.getSelImage().isEmpty()){
                continue;
            }

            frontPages.add(cal.getSelImage().get(0));
        }

        System.out.println(frontPages);
        model.addAttribute("calendars",calendars);
        model.addAttribute("frontPages",frontPages);

        return "/my-calendars";
    }

    @GetMapping("/update")
    public String updateCalendar(@RequestParam("calId") Long calId, Model model, Principal principal) throws Exception {

        if (principal == null) {
            return "redirect:/find";
        }

        Calendar c = calendarService.getCalendar(calId);
//        List<String> stringss = c.getImages().stream()
//                .map(image -> this.rootLocation.resolve(image.getName()))
//                .map(path -> MvcUriComponentsBuilder
//                        .fromMethodName(ImageController.class, "serveFile", path.getFileName().toString()).build()
//                        .toString())
//                .collect(Collectors.toList());

        model.addAttribute("files", c.getSelImage());
        model.addAttribute("cal", c);

        return "/update_calendar";
    }

    @PostMapping("/update")
    public String saveUpdateCalendar(@ModelAttribute("cal") Calendar tmpC, Principal principal) throws Exception {

        if (principal == null) {
            return "redirect:/find";
        }
        Calendar c = calendarService.getCalendar(tmpC.getId());

        System.out.println(tmpC.getName());
        System.out.println(tmpC.getYear());
        System.out.println(tmpC.getLang());
        System.out.println(tmpC.getOffset());
        System.out.println(tmpC.getSelImage());

        System.out.println("Ahojky, toto je zatim prototyp update :)");

//        List<String> stringss = tmpC.getImages().stream()
//                .map(image -> this.rootLocation.resolve(image.getName()))
//                .map(path -> MvcUriComponentsBuilder
//                        .fromMethodName(ImageController.class, "serveFile", path.getFileName().toString()).build()
//                        .toString())
//                .collect(Collectors.toList());

        if(!c.getName().equals(tmpC.getName())){
            c.setName(tmpC.getName());
        }
        if(c.getYear() != tmpC.getYear()){
            c.setYear(tmpC.getYear());
        }
        if(!c.getLang().equals(tmpC.getLang())){
            c.setLang(tmpC.getLang());
        }
        if(c.getOffset() != tmpC.getOffset()){
            c.setOffset(tmpC.getOffset());
        }
        if(c.getSelImage() != tmpC.getSelImage()){
            c.setSelImage(tmpC.getSelImage());
        }

        calendarService.saveCalendar(c);

        return "redirect:/calendar?name=" + tmpC.getName();
    }

    @GetMapping("/files/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable String filename) throws MalformedURLException {

        Path file = this.rootLocation.resolve(filename);
        Resource resource = new UrlResource(file.toUri());

        return ResponseEntity
                .ok()
                .body(resource);
    }

    @GetMapping("/deleteNullCalendar")
    public String deleteNullCalendar(@RequestParam(name="calId", required = false) Long calId, @RequestParam("redir") String redir, Principal principal) throws IOException {
        Optional<User> user = userService.getUserByName(principal.getName());
        System.out.println("Redirect: " + redir);
        if(calId == null){
            return "redirect:" + redir;
        }
        Calendar calendar = calendarService.getCalendar(calId);
        user.get().getCalendars().remove(calendar);
        for (Image image:calendar.getImages()) {
            imageService.deleteImage(calendar,image);
        }

        calendarService.deleteCalendar(calId);
        userService.updateUser(user.get());

        return "redirect:" + redir;
    }
}
