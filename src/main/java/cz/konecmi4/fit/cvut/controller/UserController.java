package cz.konecmi4.fit.cvut.controller;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Role;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.service.SecurityService;
import cz.konecmi4.fit.cvut.service.UserService;

import cz.konecmi4.fit.cvut.validator.NewPasswordValidator;
import cz.konecmi4.fit.cvut.validator.OldPasswordValidator;
import cz.konecmi4.fit.cvut.validator.UpdateUserValidator;
import cz.konecmi4.fit.cvut.validator.UserValidator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Controller
public class UserController {
    private final UserService userService;
    private final SecurityService securityService;
    private final UserValidator userValidator;
    private final UpdateUserValidator updateUserValidator;
    private final OldPasswordValidator oldPasswordValidator;
    private final NewPasswordValidator newPasswordValidator;

    public UserController(UserService userService, SecurityService securityService, UserValidator userValidator, UpdateUserValidator updateUserValidator, OldPasswordValidator oldPasswordValidator, NewPasswordValidator newPasswordValidator) {
        this.userService = userService;
        this.securityService = securityService;
        this.userValidator = userValidator;
        this.updateUserValidator = updateUserValidator;
        this.oldPasswordValidator = oldPasswordValidator;
        this.newPasswordValidator = newPasswordValidator;
    }

    @GetMapping("/users/list")
    public String listUsers(Model model) {
        List<User> users = userService.getUsers();
        model.addAttribute("users", users);
        return "admin/welcome";
    }

    @GetMapping("/user/update")
    public String showFormForUpdate(@RequestParam("username") String username,
                                    Model model,
                                    Principal principal) {
        //User theUser = userService.getUser(theId);
        User user;
        try {
            user = userService.findByUsername(username).orElseThrow(Exception::new);
        }catch (Exception e){
            return "redirect:/welcome";
        }

        System.out.println("Uzivatel prihlaseny: " + principal.getName());
        System.out.println("Uzivatel aktualizovany: " + user.getUsername());

        Optional<User> tmp_admin = userService.findByUsername(principal.getName());
        if(tmp_admin.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Mas problem, bracho.");
            return "redirect:/welcome";
        }

        if(!user.getUsername().equals(principal.getName()) && !(tmp_admin.get().getAdmin())){
            System.out.println("Lezes kam nemas!");
            return "redirect:/welcome";
        }

        model.addAttribute("user", user);
        return "update-user";
    }


    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute("user") User tmpUser,
                             Principal principal,
                             BindingResult bindingResult) throws Exception {

        System.out.println("Uzivatel prihlaseny: " + principal.getName());
        System.out.println("Uzivatel aktualizovany: " + tmpUser.getUsername());

        Optional<User> realUser = userService.getUserByName(tmpUser.getUsername());
        Optional<User> loginUser = userService.getUserByName(principal.getName());

        if(realUser.isPresent() && loginUser.isPresent()){
            System.out.println("Everything OK.");
        }else{
            return "redirect:/";
        }

        if(loginUser.get().getAdmin()){
            System.out.println("Ano, jsme admin.");
            if(tmpUser.getNewPassword().isEmpty()){
                if(realUser.get().getAdmin() != tmpUser.getAdmin()){
                    realUser.get().setAdmin(tmpUser.getAdmin());
                }
                userService.setUserRoles(realUser.get());
                return "redirect:/";
            }else
                newPasswordValidator.validate(tmpUser, bindingResult);
        }else{
            System.out.println("Ne, nejsme admin.");
            oldPasswordValidator.validate(tmpUser,bindingResult);
            newPasswordValidator.validate(tmpUser,bindingResult);
        }
//
//        System.out.println("Je nebo neni: " + user.getAdmin());
//
        if (bindingResult.hasErrors()) {
            System.out.println("Chyba validace!");
            System.out.println(bindingResult.getAllErrors());
            return "update-user";
        }
//
//
//        System.out.println("Uzivatel prihlaseny: " + principal.getName());
//        System.out.println("Uzivatel aktualizovany: " + user.getUsername());

        if(realUser.get().getAdmin() != tmpUser.getAdmin()){
            realUser.get().setAdmin(tmpUser.getAdmin());
            userService.setUserRoles(realUser.get());
        }
        realUser.get().setNewPassword(tmpUser.getNewPassword());

        /*System.out.println("Aktualizuji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getNewPassword());
        System.out.println(user.getOldPassword());
        System.out.println("==============================");*/

        userService.updateUserPassword(realUser.get());

        System.out.println("Po ulozeni!");
        return "/";
    }

    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("userId") Long id) {
        userService.deleteUser(id);
        return "redirect:/users/list";
    }

    /*@GetMapping("/addNewUser")
    public String addNewUser(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/addNewUser")
    public String addNewUser(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        System.out.println("Pridavam tohoto uživatele:");
        System.out.println(userForm.getUsername());
        System.out.println(userForm.getPassword());
        System.out.println("==============================");

        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }
        userService.saveUser(userForm);

        return "redirect:/users/list";
    }*/

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("user", new User());
        return "registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("user") User user, BindingResult bindingResult) {
        /*System.out.println("Registruji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        System.out.println("==============================");*/

        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.createUser(user);
        userService.setUserRoles(user);
        securityService.autoLogin(user.getUsername(), user.getPasswordConfirm());
        return "redirect:/welcome";
    }

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Vaše jméno a heslo jsou nesprávné.");

        if (logout != null)
            model.addAttribute("message", "Byli jste úspěšně odhlášeni.");

        return "login";
    }

    @GetMapping({"/", "/welcome"})
    public String welcome(Principal principal) throws Exception {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Bracho mame problem s prihlasenim");
            return "redirect:/";
        }
        for (Role role : user.get().getRoles()){
            if(role.getName().equals("ROLE_ADMIN")){
                return "redirect:/admin/";
            }
        }

        return "welcome";
    }


    @GetMapping("/admin")
    public String adminHome(Model model, @RequestParam(defaultValue = "") String name)
    {
        model.addAttribute("users", userService.getUser(name));
        return "admin/welcome";
    }

    @GetMapping("/admin/create-user")
    public String adminCreateUser(Model model)
    {
        model.addAttribute("user", new User());
        return "admin/create-user";
    }

    @PostMapping("/admin/create-user")
    public String adminCreateUserSave(@ModelAttribute("user") User user, BindingResult bindingResult)
    {
        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "/admin/create-user";
        }

        userService.createUser(user);
        userService.setUserRoles(user);
        return "redirect:/users/list";
    }

    @GetMapping("/admin/list-calendars")
    public String showAllGallery(Model model, Principal principal)
    {
        Optional<User> tmpUser = userService.getUserByName(principal.getName());
        if(tmpUser.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Asi ses odhlasil");
            return "redirect:/";
        }

        if(!tmpUser.get().getAdmin()){
            return "redirect:/";
        }

        List<User> users = userService.getUsers();
        ArrayList<String> frontPages = new ArrayList<>();
        for (User user: users) {
            Set<Calendar> calendars = user.getCalendars();

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
        }


        model.addAttribute("users", users);
        model.addAttribute("frontPages", frontPages);
        return "admin/list-users-calendars";
    }

}
