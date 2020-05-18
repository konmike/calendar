package cz.konecmi4.fit.cvut.controller;

import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.*;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.model.User;
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


    @RequestMapping("/delete")
    public String deleteImage(@RequestParam("calId") Long calId, @RequestParam("imgId") Long imgId, Principal principal) throws Exception {
        Optional<User> user = userService.getUserByName(principal.getName());
        Calendar calendar = calendarService.getCalendar(calId);
        Image image = imageService.getImage(imgId);

        imageService.deleteImage(calendar,image);

        if(calendar.getImages().isEmpty()){
//            System.out.println("Mazani kalendare v deleteImage");
            if(!user.isPresent())
                return "redirect:/";

            user.get().getCalendars().remove(calendar);
            calendarService.deleteCalendar(calId);
            userService.updateUser(user.get());
            return "redirect:/image/";
        }

        calendarService.saveCalendar(calendar);
        return "redirect:/image/?calId=" + calId;
    }
}
