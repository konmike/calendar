package cz.konecmi4.fit.cvut.auth.web;

import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Collectors;

import ch.qos.logback.core.net.SyslogOutputStream;
import cz.konecmi4.fit.cvut.auth.model.Calendar;
import cz.konecmi4.fit.cvut.auth.model.Image;
import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.auth.repository.ImageRepository;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/image")
public class ImageController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private CalendarRepository calendarRepository;

    private Path rootLocation;

    public ImageController(UserRepository userRepository, Path rootLocation, ImageRepository imageRepository) {
        this.userRepository = userRepository;
        this.rootLocation = rootLocation;
        this.imageRepository = imageRepository;
    }

    @GetMapping("/")
    public String listUploadedFiles(Model model, Principal principal) throws Exception {

        if (principal == null) {
            return "redirect:/find";
        }

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        List<String> stringss = user.getImageList().stream()
                .map(image -> this.rootLocation.resolve(image.getName()))
                .map(path -> MvcUriComponentsBuilder
                        .fromMethodName(ImageController.class, "serveFile", path.getFileName().toString()).build()
                        .toString())
                .collect(Collectors.toList());


        model.addAttribute("files", stringss);

        return "image/upload";
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

    @PostMapping("/")
    public String handleFileUpload(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes,
                                   Principal principal) throws Exception {

        if (file.getSize() == 0) {
            return "redirect:/image/";
        }

        String uuid = UUID.randomUUID().toString();
        //System.out.println("Ahojky, jak je?");

        String imagePath = this.rootLocation.resolve(uuid + ".jpg").toString();

        //System.out.println(imagePath);
        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());
        //System.out.println(user);

        Set<Image> stringList = user.getImageList();
        stringList.add(new Image(imagePath));
        Files.copy(file.getInputStream(), this.rootLocation.resolve(imagePath));

        userRepository.save(user);

        return "redirect:/image/";
    }

    /*@GetMapping("/find")
    public String findPhotos(Model model) {
        return "findphoto";
    }*/

    @GetMapping("/search")
    public String showGallery(@RequestParam("name") String name, Model model)  {
        User user;
        try {
            user = userRepository.findByUsername(name).orElseThrow(Exception::new);
        } catch (Exception e) {
            return "redirect:/image/find";
        }

        ArrayList tmp = user.getImageList().stream()
                .map(image -> this.rootLocation.resolve(image.getName()))
                .map(path -> MvcUriComponentsBuilder
                        .fromMethodName(ImageController.class, "serveFile", path.getFileName().toString()).build()
                        .toString()).collect(Collectors.toCollection((Supplier<ArrayList>) ArrayList::new));


        //Calendar calendar = new Calendar();

        //user.setCheckImage(tmp);
        //calendar.setSelImage(tmp);


        /*System.out.println("Pred ulozenim do databaze:");
        System.out.println(user.getCheckImage());

        //userRepository.save(user);

        System.out.println("Meta 32 pohyb...");
        for (Object o : tmp) {
            System.out.println(o);
        }
        System.out.println("KONEC - Meta 32 pohyb... - KONEC");*/

        model.addAttribute("user", user);
        model.addAttribute("cal", new Calendar(tmp));

        return "image/findphoto";
    }

    /*@RequestMapping("/showChecked")
    public String showChecked(@ModelAttribute("cal") Calendar c, Principal principal) throws Exception
    {
        if(c.getSelImage().isEmpty()){
            System.out.println("Je to prazdny, fakt, nekecam...");
        }else {
            for (Object o : c.getSelImage()) {
                System.out.println(o);
            }
        }

        System.out.println("Kalendaris");
        System.out.println(c.getName());
        System.out.println(c.getYear());
        System.out.println(c.getSelImage());
        System.out.println("==== END Kalendaris ====");

        calendarRepository.save(c);

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        Set<Calendar> calSet = user.getCalendars();
        calSet.add(c);
        user.setCalendars(calSet);

        userRepository.save(user);

        return "image/showCheck";
    }*/

    @RequestMapping("/delete")
    public String findPhotos(Principal principal, @RequestParam("text") String text, String string) throws Exception {

        User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        text = text.substring(text.lastIndexOf("/"));
        text = this.rootLocation + text;

        Image image = imageRepository.findByName(text);

        user.getImageList().remove(image);

        userRepository.save(user);

        return "redirect:/image/";

    }
}
