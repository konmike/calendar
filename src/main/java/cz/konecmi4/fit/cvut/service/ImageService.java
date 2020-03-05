package cz.konecmi4.fit.cvut.service;

import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;

import java.io.IOException;

public interface ImageService {
    Image getImage(Long id);
    void deleteImage(Calendar calendar, Image image) throws IOException;
}
