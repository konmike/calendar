package cz.konecmi4.fit.cvut.auth.web;

import cz.konecmi4.fit.cvut.auth.model.User;
import cz.konecmi4.fit.cvut.auth.repository.UserRepository;
import cz.konecmi4.fit.cvut.auth.service.SecurityService;
import cz.konecmi4.fit.cvut.auth.service.UserService;

import cz.konecmi4.fit.cvut.auth.validator.UserValidator;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

    @GetMapping("/users/list")
    public String listUsers(Model theModel) {
        List< User > theUsers = userService.getUsers();
        theModel.addAttribute("users", theUsers);
        return "admin/list-users";
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

    @PostMapping("/updateUser")
    public String updateUser(@ModelAttribute("user") User theUser, BindingResult bindingResult) {
        /*userValidator.validate(theUser, bindingResult);

        if (bindingResult.hasErrors()) {
            return "update-form";
        }*/

        System.out.println("Aktualizuji tohoto uživatele:");
        System.out.println(theUser.getUsername());
        System.out.println(theUser.getPassword());
        System.out.println("==============================");

        userService.updateUser(theUser);
        return "redirect:/";
    }

    @PostMapping("/saveUser")
    public String saveUser(@ModelAttribute("user") User theUser, BindingResult bindingResult) {
        /*userValidator.validate(theUser, bindingResult);

        if (bindingResult.hasErrors()) {
            return "update-form";
        }*/

        System.out.println("Ukladam tohoto uživatele:");
        System.out.println(theUser.getUsername());
        System.out.println(theUser.getPassword());
        System.out.println("==============================");

        userService.saveUser(theUser);
        return "redirect:/";
    }

    @GetMapping("/user/delete")
    public String deleteUser(@RequestParam("userId") int theId) {
        userService.deleteUser(theId);
        return "redirect:/users/list";
    }

    @GetMapping("/addNewUser")
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
    }

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("userForm") User user, BindingResult bindingResult) {
        System.out.println("Registruji tohoto uživatele:");
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        System.out.println("==============================");

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
    public String welcome(Model model) {
        return "welcome";
    }


    @GetMapping("/admin/special")
    public String adminhome(Model model)
    {
        return "admin/special";
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
