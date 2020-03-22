package cz.konecmi4.fit.cvut.controller;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.service.CalendarService;
import cz.konecmi4.fit.cvut.service.ImageService;
import cz.konecmi4.fit.cvut.service.UserService;
import cz.konecmi4.fit.cvut.validator.CalendarCreateValidator;
import cz.konecmi4.fit.cvut.validator.UploadImageValidator;
import org.apache.commons.io.FilenameUtils;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.Principal;
import java.util.*;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
    private final CalendarService calendarService;
    private final UserService userService;
    private final ImageService imageService;

    private Path rootLocation;

    private final CalendarCreateValidator calendarCreateValidator;
    private final UploadImageValidator uploadImageValidator;

    public CalendarController(CalendarService calendarService, UserService userService,
                              ImageService imageService, Path rootLocation,
                              CalendarCreateValidator calendarCreateValidator, UploadImageValidator uploadImageValidator) {
        this.calendarService = calendarService;
        this.userService = userService;
        this.imageService = imageService;
        this.rootLocation = rootLocation;
        this.calendarCreateValidator = calendarCreateValidator;
        this.uploadImageValidator = uploadImageValidator;
    }

    @GetMapping()
    public String getCalendar(@RequestParam("calId") Long calId, Model model) {
        Calendar calendar = calendarService.getCalendar(calId);

        System.out.println("Uploadnute obrazky: ");
        System.out.println(calendar.getImages());


        System.out.println("Vybrane obrazky: ");
        System.out.println(calendar.getSelImage());
        //System.out.println(tmp);

        model.addAttribute("cal",calendar);
        return "/show-calendar";
    }

    @GetMapping("/create")
    public String getCreateCalendar(Model model){
        model.addAttribute("cal", new Calendar());
        return "create-calendar";
    }

    @PostMapping("/create")
    public String createCalendar(@ModelAttribute("cal") Calendar c, Principal principal, BindingResult bindingResult) {
        System.out.println("Id: " + c.getId());
        System.out.println("Name: " + c.getName());
        System.out.println("Year: " + c.getYear());
        System.out.println("Type: " + c.getType());
        System.out.println("Design: " + c.getDesign());
        System.out.println("Color labels: " + c.getColorLabels());
        System.out.println("Color dates: " + c.getColorDates());
//        System.out.println("Offset: " + c.getOffset());
//        System.out.println("Lang: " + c.getLang());


        calendarCreateValidator.validate(c,bindingResult);

        if (bindingResult.hasErrors()) {
            System.out.println("Chyba validace!");
            System.out.println(bindingResult.getAllErrors());
            return "create-calendar";
        }

        Optional <User> user = userService.getUserByName(principal.getName());
        Set<Calendar> calendars;

        if(user.isPresent())
            calendars = user.get().getCalendars();
        else{
            return "redirect:/";
        }

        ArrayList<String> selImage = new ArrayList<>();

        for(int i = 0; i < 13; i++) selImage.add("null");

        c.setSelImage(selImage);

        calendarService.saveCalendar(c);
        calendars.add(c);
        userService.updateUser(user.get());

        return "redirect:/calendar/update?calId=" + c.getId();
    }

    @GetMapping("/myCalendars")
    public String getCalendars(Model model, Principal principal) throws Exception
    {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything ok");
        }else {
            return "redirect:/";
        }

        System.out.println(user.get().getUsername());

        Set<Calendar> calendars = user.get().getCalendars();

        ArrayList<String> frontPages = new ArrayList<>();

        for (Calendar cal : calendars) {
            System.out.println("Vybrane: " + cal.getSelImage());
            //never happen
//            if(cal.getSelImage().isEmpty()){
//                System.out.println("Sorry, je to prazdne, nekde mas chybu...");
//                continue;
//            }
            System.out.println("Pridavam uvodni " + cal.getSelImage().get(0));
            frontPages.add(cal.getSelImage().get(0));
        }

        System.out.println("Vsechny uvodky " + frontPages);

        model.addAttribute("calendars",calendars);
        model.addAttribute("frontPages",frontPages);

        return "/my-calendars";
    }

    @RequestMapping("/update")
    public String updateCalendar(@RequestParam("calId") Long calId, Model model) {
        Calendar c = calendarService.getCalendar(calId);

        System.out.println("Update images: " + c.getImages());
        System.out.println("Select images: " + c.getSelImage());



        model.addAttribute("cal", c);


        return "/update-calendar";
    }

    @PostMapping("/update")
    public String saveUpdateCalendar(@RequestParam(name = "files", required = false) MultipartFile[] files,
                                     @RequestParam(name = "redir") String redir, RedirectAttributes redirectAttributes,
                                     @ModelAttribute("cal") Calendar tmpC, BindingResult bindingResult) throws IOException {

        calendarCreateValidator.validate(tmpC,bindingResult);
        //TODO nefunguje presmerovani s chybou
        if (bindingResult.hasErrors()) {
            System.out.println("Chyba validace!");
            System.out.println(bindingResult.getAllErrors());
            return "redirect:/calendar/update?calId=" + tmpC.getId();
        }

        Calendar c = calendarService.getCalendar(tmpC.getId());

        System.out.println(tmpC.getName());
        System.out.println(tmpC.getYear());
//        System.out.println(tmpC.getLang());
//        System.out.println(tmpC.getOffset());
        System.out.println("Update vybrane " + tmpC.getSelImage());
        System.out.println("Typ" + tmpC.getType());
        System.out.println("Design" + tmpC.getDesign());

        if(files.length != 0){
            Set<Image> images = c.getImages();

            for (MultipartFile file:files) {
                String name = file.getOriginalFilename();
                System.out.println(name);
                String extension = FilenameUtils.getExtension(file.getOriginalFilename());
                System.out.println(extension);

                if(Objects.equals(name, "") && Objects.equals(extension, "")){
                    System.out.println("Další prázdná potvora...");
                    continue;
                }

                if(!uploadImageValid(file)){
                    System.out.println("Chyba validace!");
                    redirectAttributes.addFlashAttribute("fileErrors", "Obrázek musí být typu jpg, jpeg nebo png.");
                    return "redirect:/calendar/update?calId=" + tmpC.getId();
                }
                if(!uploadImageSizeValid(file)){
                    System.out.println("Chyba validace!");
                    redirectAttributes.addFlashAttribute("fileErrors", "Obrázek musí mít minimální rozlišení 700x700.");
                    return "redirect:/calendar/update?calId=" + tmpC.getId();
                }
//                uploadImageValidator.validate(file,bindingResult);
//
//                if (bindingResult.hasErrors()) {
//                    System.out.println("Chyba validace!");
//                    System.out.println(bindingResult.getAllErrors());
//                    //model.addAttribute("fileErrors", "Je to blbost!!!");
//                    return "redirect:/calendar/update?calId=" + tmpC.getId();
//                }

//                String name = file.getOriginalFilename();

//                System.out.println(name);


                String uuid = UUID.randomUUID().toString();


                String imagePath = null;
                if(name != null)
                    imagePath = this.rootLocation.resolve(name).toString();
                else{
                    name = uuid;
                    imagePath = this.rootLocation.resolve(name).toString();
                }

                if(!Files.exists(this.rootLocation.resolve(imagePath))){
                    Files.copy(file.getInputStream(), this.rootLocation.resolve(imagePath));
                }else{
                    Random random = new Random();
                    int rNumber = random.nextInt(10000);
                    name = FilenameUtils.getBaseName(file.getOriginalFilename());
                    imagePath = this.rootLocation.resolve(name + "_" + rNumber + "." + extension).toString();
                    System.out.println("Vlastni image path: " + imagePath);
                    Files.copy(file.getInputStream(), this.rootLocation.resolve(imagePath));
                    name = name + "_" + rNumber + "." + extension;
                    System.out.println("Vlastni name: " + name);
                }

                String path = MvcUriComponentsBuilder.fromMethodName(CalendarController.class,"serveFile", name).build().toString();
                images.add(new Image(name,path,extension));
            }
        }


        if(!c.getName().equals(tmpC.getName())){
            c.setName(tmpC.getName());
        }
        if(c.getYear() != tmpC.getYear()){
            c.setYear(tmpC.getYear());
        }

        if(c.getSelImage() != tmpC.getSelImage()){
            c.setSelImage(tmpC.getSelImage());
        }
        if(c.getType() != tmpC.getType()){
            c.setType(tmpC.getType());
        }
        if(c.getDesign() != tmpC.getDesign()){
            c.setDesign(tmpC.getDesign());
        }
        if(!c.getColorLabels().equals(tmpC.getColorLabels())){
            c.setColorLabels(tmpC.getColorLabels());
        }
        if(!c.getColorDates().equals(tmpC.getColorDates())){
            c.setColorDates(tmpC.getColorDates());
        }
        if(!c.getBackgroundColor().equals(tmpC.getBackgroundColor())){
            c.setBackgroundColor(tmpC.getBackgroundColor());
        }

        calendarService.saveCalendar(c);

        if(redir.equals("image")){
            return "redirect:/calendar/update?calId=" + tmpC.getId();
        }else {
            return "redirect:/calendar?calId=" + tmpC.getId();
        }
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

    @GetMapping("/delete")
    public String deleteCalendar(@RequestParam(name="calId") Long calId, Principal principal) throws IOException {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything ok");
        }else {
            return "redirect:/";
        }
        Set<Long> delId = new LinkedHashSet<>();
        Calendar calendar = calendarService.getCalendar(calId);

        Set<Calendar> calendars = user.get().getCalendars();
        calendars.remove(calendar);
        userService.updateUser(user.get());


        if(calendar.getImages() != null) {
            for (Image image : calendar.getImages()) {
                delId.add(image.getId());
            }
        }

        for(Long imgId : delId){
            Image image = imageService.getImage(imgId);
            imageService.deleteImage(calendar, image);
        }

        if(calendar.getImages() != null) {
            calendar.getImages().clear();
        }

        calendarService.deleteCalendar(calId);
        return "redirect:/calendar/myCalendars";
    }

    @RequestMapping("/image/delete")
    public String deleteImage(@RequestParam("calId") Long calId, @RequestParam("imgId") Long imgId) throws Exception {
        Calendar calendar = calendarService.getCalendar(calId);
        Image image = imageService.getImage(imgId);

        calendar.getSelImage().remove(image.getPath());

        imageService.deleteImage(calendar,image);

        calendarService.saveCalendar(calendar);
        return "redirect:/calendar/update?calId=" + calId;

    }


//TODO vytvořit speciální validator na obrazky...
    private boolean uploadImageValid(MultipartFile file){
        String type = file.getContentType();
        System.out.println("Soubor je typu " + type);
        System.out.println("Soubor ma nazev " + file.getOriginalFilename());

        if (  !(type.equals("image/png")) && !(type.equals("image/jpeg"))  ) {
            System.out.println("Neni to png ani jpg, je to " + file.getContentType());
            return false;
        }
        return true;
    }
    private boolean uploadImageSizeValid(MultipartFile file) throws IOException {


        ImageInputStream iis = ImageIO.createImageInputStream(file.getInputStream());
        Iterator<ImageReader> readers = ImageIO.getImageReaders(iis);

        if (readers.hasNext()) {
            //Get the first available ImageReader
            ImageReader reader = readers.next();
            reader.setInput(iis, true);

            if(!(reader.getWidth(0) > 700 && reader.getHeight(0) > 700)){
                return false;
            }
            System.out.println("Format : " + reader.getFormatName());
            System.out.println("Width : " + reader.getWidth(0) + " pixels");
            System.out.println("Height : " + reader.getHeight(0) + " pixels");
        }
        return true;
    }
}
