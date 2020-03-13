package cz.konecmi4.fit.cvut.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;

@Component
public class UploadImageValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        MultipartFile file = (MultipartFile) o;
        String type = file.getContentType();
        System.out.println("Soubor je typu " + type);
        System.out.println("Soubor ma nazev " + file.getOriginalFilename());

        if (  !(type.equals("image/png")) && !(type.equals("image/jpeg"))  ) {
            System.out.println("Neni to png ani jpg, je to " + file.getContentType());
            errors.reject("type.cal.extension");
        }
    }
}
