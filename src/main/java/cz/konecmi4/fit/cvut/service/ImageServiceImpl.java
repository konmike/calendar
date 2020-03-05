package cz.konecmi4.fit.cvut.service;


import cz.konecmi4.fit.cvut.model.Image;
import cz.konecmi4.fit.cvut.repository.ImageRepository;
import org.springframework.stereotype.Service;

@Service
public class ImageServiceImpl implements ImageService {
    private final ImageRepository imageRepository;

    public ImageServiceImpl(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }

    @Override
    public Image getImage(Long id) {
        return imageRepository.getOne(id);
    }
}
