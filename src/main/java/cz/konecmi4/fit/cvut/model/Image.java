package cz.konecmi4.fit.cvut.model;

import javax.persistence.*;


@Entity
//@Table(name = "image")
public class Image {
    @Id
    @GeneratedValue
    private Long id;
    private String name;
    private String path;
    private String extension;

    public Image(){};

    public Image(String name, String path, String extension) {
        this.name = name;
        this.path = path;
        this.extension = extension;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    @Override
    public String toString() {
        return "Image [id=" + id + ", name=" + name + "]";
    }
}
