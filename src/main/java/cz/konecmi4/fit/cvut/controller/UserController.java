package cz.konecmi4.fit.cvut.controller;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Role;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.service.SecurityService;
import cz.konecmi4.fit.cvut.service.UserService;

import cz.konecmi4.fit.cvut.validator.NewPasswordValidator;
import cz.konecmi4.fit.cvut.validator.OldPasswordValidator;
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

    private final OldPasswordValidator oldPasswordValidator;
    private final NewPasswordValidator newPasswordValidator;

    public UserController(UserService userService, SecurityService securityService,
                          UserValidator userValidator, OldPasswordValidator oldPasswordValidator,
                          NewPasswordValidator newPasswordValidator) {
        this.userService = userService;
        this.securityService = securityService;
        this.userValidator = userValidator;
        this.oldPasswordValidator = oldPasswordValidator;
        this.newPasswordValidator = newPasswordValidator;
    }

    @GetMapping("/users/list")
    public String listUsers(Model model, Principal principal) {
        Optional<User> tmp_admin = userService.findByUsername(principal.getName());
        if(tmp_admin.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Mas problem, bracho.");
            return "redirect:/welcome";
        }

        List<User> users = userService.getUsers();

        model.addAttribute("users", users);
        model.addAttribute("user", tmp_admin);
        return "views/admin/homepage";
    }

    @GetMapping("/user/update")
    public String showFormForUpdate(@RequestParam("id") Long id,
                                    Model model,
                                    Principal principal) {
        User editUser = userService.getUser(id);
        Optional<User> loginUser = userService.findByUsername(principal.getName());
        if(loginUser.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Mas problem, bracho.");
            return "redirect:/welcome";
        }
//        User user;
//        try {
//            user = userService.findByUsername(username).orElseThrow(Exception::new);
//        }catch (Exception e){
//            return "redirect:/welcome";
//        }

        System.out.println("Uzivatel prihlaseny: " + principal.getName());
        System.out.println("Uzivatel aktualizovany: " + editUser.getUsername());



        if(!editUser.getUsername().equals(principal.getName()) && !(loginUser.get().getAdmin())){
            System.out.println("Lezes kam nemas!");
            return "redirect:/welcome";
        }

        model.addAttribute("user", loginUser);
        model.addAttribute("updateUser", editUser);
        return "views/update-user";
    }


    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute("updateUser") User tmpUser,
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
            return "views/update-user";
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
    public String deleteUser(@RequestParam("userId") Long id, Principal principal) {
        User delUser = userService.getUser(id);
        if(!principal.getName().equals(delUser.getUsername())){
            userService.deleteUser(id);
        }else{
            System.out.println("Co, to jako zkousis?");
        }
        return "redirect:/users/list";
    }


    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("user", new User());
        return "views/registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("user") User user, BindingResult bindingResult) {
        /*System.out.println("Registruji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        System.out.println("==============================");*/

        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "views/registration";
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

        return "views/login";
    }

    @GetMapping({"/", "/welcome"})
    public String welcome(Model model, Principal principal) throws Exception {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Bracho mame problem s prihlasenim");
            return "redirect:/";
        }
        for (Role role : user.get().getRoles()){
            if(role.getName().equals("ROLE_ADMIN")){
                return "redirect:/admin";
            }
        }

        model.addAttribute("user", user);
        return "views/homepage";
    }


    @GetMapping("/admin")
    public String adminHome(Model model, Principal principal)
    {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Asi ses odhlasil");
            return "redirect:/";
        }

        model.addAttribute("users", userService.getUsers());
        model.addAttribute("user", user);
        return "views/admin/homepage";
    }

    @GetMapping("/admin/create-user")
    public String adminCreateUser(Model model, Principal principal)
    {
        Optional<User> user = userService.getUserByName(principal.getName());
        if(user.isPresent()){
            System.out.println("Everything OK");
        }else{
            System.out.println("Asi ses odhlasil");
            return "redirect:/";
        }

        model.addAttribute("newUser", new User());
        model.addAttribute("user", user);
        return "views/admin/create-user";
    }

    @PostMapping("/admin/create-user")
    public String adminCreateUserSave(@ModelAttribute("newUser") User user, BindingResult bindingResult)
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
    public String showAllCalendars(Model model, Principal principal)
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
        model.addAttribute("user", tmpUser);
        model.addAttribute("frontPages", frontPages);
        return "views/admin/list-users-calendars";
    }

}
