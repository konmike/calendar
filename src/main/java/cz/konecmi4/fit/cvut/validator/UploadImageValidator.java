package cz.konecmi4.fit.cvut.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.Objects;

@Component
public class UploadImageValidator {
    public boolean uploadImageValid(MultipartFile file){
        String type = file.getContentType();
        System.out.println("Soubor je typu " + type);
        System.out.println("Soubor ma nazev " + file.getOriginalFilename());

        if (  !(type.equals("image/png")) && !(type.equals("image/jpeg"))  ) {
            System.out.println("Neni to png ani jpg, je to " + file.getContentType());
            return false;
        }
        return true;
    }
    public boolean uploadImageSizeValid(MultipartFile file) throws IOException {


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
