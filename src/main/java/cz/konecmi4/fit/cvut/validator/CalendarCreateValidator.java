package cz.konecmi4.fit.cvut.validator;

import cz.konecmi4.fit.cvut.model.Calendar;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CalendarCreateValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        Calendar calendar = (Calendar) o;


        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "year", "NotEmptyYear");

        if (calendar.getName().length() < 6 || calendar.getName().length() > 32) {
            errors.rejectValue("name", "size.calendar.name");
        }

    }
}
