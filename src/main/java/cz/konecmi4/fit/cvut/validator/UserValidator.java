package cz.konecmi4.fit.cvut.validator;

import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.service.UserService;
//import org.omg.CosNaming.NamingContextPackage.NotEmpty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {
    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals((aClass));
    }


    private static boolean isValidEmail(String email) {
        String regex = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
        return email.matches(regex);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;


        if (user.getUsername().length() < 6 || user.getUsername().length() > 32) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (userService.findByUsername(user.getUsername()).isPresent()) {
            System.out.println("Tento uzivatel tam jiz je:");
            System.out.println(userService.findByUsername(user.getUsername()));
            System.out.println("======== SMŮLA ========");

            errors.rejectValue("username", "Duplicate.userForm.username");
        }


        if (!isValidEmail(user.getEmail()) && user.getEmail().length() < 1) {
            errors.rejectValue("email", "BadEmail.userForm.email");
        }

        if (userService.findByUsername(user.getUsername()).isPresent()) {
            System.out.println("Tento uzivatel tam jiz je:");
            System.out.println(userService.findByUsername(user.getUsername()));
            System.out.println("======== SMŮLA ========");

            errors.rejectValue("username", "Duplicate.userForm.username");
        }


        if (user.getPassword().length() < 8 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.userForm.password");
        }

        if(!user.getPassword().matches(".*\\d.*"))
            errors.rejectValue("password", "Number.userForm.password");

        if(user.getPassword().equals(user.getPassword().toLowerCase()))
            errors.rejectValue("password", "Uppercase.userForm.password");

        if (!user.getPasswordConfirm().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirm", "Diff.userForm.passwordConfirm");
        }
    }
}
