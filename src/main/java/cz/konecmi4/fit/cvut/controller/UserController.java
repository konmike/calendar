package cz.konecmi4.fit.cvut.controller;

import cz.konecmi4.fit.cvut.model.Role;
import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.repository.UserRepository;
import cz.konecmi4.fit.cvut.service.SecurityService;
import cz.konecmi4.fit.cvut.service.UserService;

import cz.konecmi4.fit.cvut.validator.UpdateUserValidator;
import cz.konecmi4.fit.cvut.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private UpdateUserValidator updateUserValidator;

    @GetMapping("/users/list")
    public String listUsers(Model theModel) {
        List<User> theUsers = userService.getUsers();
        theModel.addAttribute("users", theUsers);
        return "admin/welcome";
    }

    @GetMapping("/user/update")
    public String showFormForUpdate(@RequestParam("username") String username,
                                    Model theModel) {
        //User theUser = userService.getUser(theId);
        User user;
        try {
            user = userService.findByUsername(username).orElseThrow(Exception::new);
        }catch (Exception e){
            return "redirect:/welcome";
        }
        theModel.addAttribute("user", user);
        return "update-form";
    }

    /*@GetMapping("/user/gallery")
    public String showUserGallery(@RequestParam("username") String username,
                                    Model theModel) {
        //User theUser = userService.getUser(theId);
        User user;
        try {
            user = userService.findByUsername(username).orElseThrow(Exception::new);
        }catch (Exception e){
            return "redirect:/";
        }
        theModel.addAttribute("user", user);
        return "update-form";
    }*/

    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute("user") User user,
                             Principal principal,
                             BindingResult bindingResult) throws Exception {
        updateUserValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            System.out.println("Chyba validace!");
            System.out.println(bindingResult.getAllErrors());
            return "update-form";
        }

        User realUser = userRepository.findByUsername(principal.getName()).orElseThrow(() -> new Exception());

        realUser.setNewPassword(user.getNewPassword());

        /*System.out.println("Aktualizuji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getNewPassword());
        System.out.println(user.getOldPassword());
        System.out.println("==============================");*/

        userService.updateUser(realUser);

        System.out.println("Po ulozeni!");
        return "redirect:/";
    }

    @PostMapping("/saveUser")
    public String saveUser(@ModelAttribute("user") User theUser, BindingResult bindingResult) {
        /*userValidator.validate(theUser, bindingResult);

        if (bindingResult.hasErrors()) {
            return "update-form";
        }*/

        /*System.out.println("Ukladam tohoto uživatele:");
        System.out.println(theUser.getUsername());
        System.out.println(theUser.getPassword());
        System.out.println("==============================");*/

        userService.saveUser(theUser);
        return "redirect:/";
    }

    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("userId") Long id) {
        userService.deleteUser(id);
        return "redirect:/users/list";
    }

    @GetMapping("/addNewUser")
    public String addNewUser(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/addNewUser")
    public String addNewUser(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        /*System.out.println("Pridavam tohoto uživatele:");
        System.out.println(userForm.getUsername());
        System.out.println(userForm.getPassword());
        System.out.println("==============================");*/

        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }
        userService.saveUser(userForm);

        return "redirect:/users/list";
    }

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("userForm") User user, BindingResult bindingResult) {
        /*System.out.println("Registruji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        System.out.println("==============================");*/

        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.saveUser(user);
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
        User user = userRepository.findByUsername(principal.getName()).orElseThrow(Exception::new);

        for (Role role : user.getRoles()){
            if(role.getName().equals("ROLE_ADMIN")){
                return "redirect:/admin/";
            }
        }

        return "welcome";
    }


    @GetMapping("/admin")
    public String adminhome(Model model, @RequestParam(defaultValue = "") String name)
    {
        model.addAttribute("users", userService.getUser(name));
        return "admin/welcome";
    }

    @GetMapping("/admin/list-gallery")
    public String showAllGallery(Model model)
    {
        model.addAttribute("users", userService.getUsers());
        return "admin/list-users-image";
    }

    /*@RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap modelMap) {
        modelMap.put("users", userService.findAll());
        return "admin/admin";
    }*/
}
