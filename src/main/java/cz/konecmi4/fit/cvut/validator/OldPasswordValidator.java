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
public class OldPasswordValidator implements Validator {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public OldPasswordValidator(BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals((aClass));
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "oldPassword", "NotEmpty");
        if (!bCryptPasswordEncoder.matches(user.getOldPassword(),user.getPassword())) {

//            System.out.println(user.getPassword());
//            System.out.println(user.getOldPassword());
//            System.out.println(bCryptPasswordEncoder.encode(user.getOldPassword()));

            errors.rejectValue("oldPassword", "Diff.user.oldPassword");
        }
    }
}
