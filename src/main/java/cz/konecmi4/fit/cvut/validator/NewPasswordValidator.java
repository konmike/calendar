package cz.konecmi4.fit.cvut.validator;

import cz.konecmi4.fit.cvut.model.User;
import cz.konecmi4.fit.cvut.service.UserService;
//import org.omg.CosNaming.NamingContextPackage.NotEmpty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class NewPasswordValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals((aClass));
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

//        System.out.println("Validujeme:");
//        System.out.println(user.getPassword());
//        System.out.println(user.getOldPassword());
//        System.out.println(user.getNewPassword());

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "newPassword", "NotEmpty");
        if (user.getNewPassword().length() < 8 || user.getNewPassword().length() > 32) {
            errors.rejectValue("newPassword", "Size.user.newPassword");
        }

        if(!user.getNewPassword().matches(".*\\d.*"))
            errors.rejectValue("newPassword", "Number.userForm.password");

        if(user.getNewPassword().equals(user.getNewPassword().toLowerCase()))
            errors.rejectValue("newPassword", "Uppercase.userForm.password");


        if (!user.getPasswordConfirm().equals(user.getNewPassword())) {

            errors.rejectValue("passwordConfirm", "Diff.user.passwordConfirm");
        }
    }
}
