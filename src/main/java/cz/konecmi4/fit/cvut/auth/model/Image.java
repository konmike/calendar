package cz.konecmi4.fit.cvut.auth.model;

import javax.persistence.*;


@Entity
//@Table(name = "image")
public class Image {
    @Id
    @GeneratedValue
    private Long id;

    private String name;

    public Image(){};

    public Image(String name) {
        this.name = name;
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

    @Override
    public String toString() {
        return "Image [id=" + id + ", name=" + name + "]";
    }
}
