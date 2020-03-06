package cz.konecmi4.fit.cvut.controller;

import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Collectors;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.ImageRepository;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import cz.konecmi4.fit.cvut.service.CalendarService;
import cz.konecmi4.fit.cvut.service.ImageService;
import cz.konecmi4.fit.cvut.service.UserService;
import org.apache.commons.io.FilenameUtils;
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

    private final UserService userService;
    private final ImageService imageService;
    private final CalendarService calendarService;

    private Path rootLocation;

    public ImageController(UserService userService, Path rootLocation, ImageService imageService,
                           CalendarService calendarService) {
        this.userService = userService;
        this.rootLocation = rootLocation;
        this.imageService = imageService;
        this.calendarService = calendarService;
    }

    @GetMapping("/")
    public String listUploadedFiles(@RequestParam(name = "calId",required = false) Long calId, Model model, Principal principal) throws Exception {

        if (principal == null) {
            return "redirect:/find";
        }

        if(calId != null){
            Calendar calendar = calendarService.getCalendar(calId);
            model.addAttribute("cal", calendar);
            return "image/upload";
        }

        /*User user = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        List<String> stringss = user.getImageList().stream()
                .map(image -> this.rootLocation.resolve(image.getName()))
                .map(path -> MvcUriComponentsBuilder
                        .fromMethodName(ImageController.class, "serveFile", path.getFileName().toString()).build()
                        .toString())
                .collect(Collectors.toList());
        */

        //model.addAttribute("files", stringss);
        model.addAttribute("cal", new Calendar());


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
    public String handleFileUpload(@RequestParam(name = "calId", required = false) Long calId, @RequestParam("path") String redir, @RequestParam("files") MultipartFile[] files, RedirectAttributes redirectAttributes,
                                   Principal principal) throws Exception {

        Optional<User> user = userService.getUserByName(principal.getName());
        Set<Calendar> calendars = user.get().getCalendars();

        Calendar cal = new Calendar();
        if(calId != null){
            cal = calendarService.getCalendar(calId);
        }

        Set<Image> images = cal.getImages();
        System.out.println("Post Start");

        if(files.length == 0){
            System.out.println("Nic neprislo");
        }

        for (MultipartFile file:files) {

            System.out.println("Post foreach");

            /*if (file.getSize() == 0) {
                return "redirect:/image/";
            }*/

            String name = file.getOriginalFilename();
            String extension = FilenameUtils.getExtension(file.getOriginalFilename());
            System.out.println(name);
            //System.out.println(file.getContentType());
            System.out.println(extension);

            String uuid = UUID.randomUUID().toString();
            //System.out.println("Ahojky, jak je?");


            String imagePath = this.rootLocation.resolve(name).toString();

            //System.out.println(imagePath);

            String path = MvcUriComponentsBuilder.fromMethodName(ImageController.class,"serveFile", name).build().toString();
            System.out.println("Real path: " + path);

            System.out.println("Nevim path: " + imagePath);

            images.add(new Image(name,path,extension));

            if(!Files.exists(this.rootLocation.resolve(imagePath))){
                Files.copy(file.getInputStream(), this.rootLocation.resolve(imagePath));
            }
        }

        Long tmpId = calendarService.saveCalendar(cal);

        calendars.add(cal);
        userService.updateUser(user.get());

        System.out.println("Post End");

        if(redir.equals("update")){
            return "redirect:/calendar/update?calId=" + tmpId;
        }else{
            return "redirect:/image/?calId=" + tmpId;
        }
    }

    @RequestMapping("/delete")
    public String deleteImage(@RequestParam("calId") Long calId, @RequestParam("imgId") Long imgId, Principal principal) throws Exception {
        Optional<User> user = userService.getUserByName(principal.getName());
        Calendar calendar = calendarService.getCalendar(calId);
        Image image = imageService.getImage(imgId);

        imageService.deleteImage(calendar,image);

        if(calendar.getImages().isEmpty()){
            System.out.println("Mazani kalendare v deleteImage");
            user.get().getCalendars().remove(calendar);
            calendarService.deleteCalendar(calId);
            userService.updateUser(user.get());
            return "redirect:/image/";
        }

        calendarService.saveCalendar(calendar);
        return "redirect:/image/?calId=" + calId;

    }
}
