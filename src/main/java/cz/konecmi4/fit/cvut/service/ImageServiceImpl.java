package cz.konecmi4.fit.cvut.service;


import cz.konecmi4.fit.cvut.model.Calendar;
import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.repository.CalendarRepository;
import cz.konecmi4.fit.cvut.repository.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@Service
public class ImageServiceImpl implements ImageService {
    private final ImageRepository imageRepository;
    private Path rootLocation;

    public ImageServiceImpl(ImageRepository imageRepository, Path rootLocation) {
        this.imageRepository = imageRepository;
        this.rootLocation = rootLocation;
    }

    @Override
    public Image getImage(Long id) {
        return imageRepository.getOne(id);
    }

    @Override
    public void deleteImage(Calendar calendar, Image image) throws IOException {
        System.out.println("Jsme v mazani");
        System.out.println("Calendar images pred: " + calendar.getImages());
        calendar.getImages().remove(image);
        System.out.println("Calendar images po: " + calendar.getImages());
        System.out.println("Smazano z vazby na kalendar");
        Path path = this.rootLocation.resolve(image.getName());

        System.out.println("Cesta k obrazku " + path);
        if(Files.exists(path)){
            System.out.println("Mazani z disku.");
            Files.delete(path);
        }

        imageRepository.deleteById(image.getId());
    }
}
