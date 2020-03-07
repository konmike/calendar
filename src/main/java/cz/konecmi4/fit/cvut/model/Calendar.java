package cz.konecmi4.fit.cvut.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
//@Table(name = "calendar")
public class Calendar {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private int year;
    private int offset;
    private String lang;

    @OneToMany(cascade = CascadeType.ALL)
    @OrderBy("id")
    private Set<Image> images = new LinkedHashSet<>();

    public Calendar() {
    }

    public Calendar(ArrayList<String> selImage) {
        this.selImage = selImage;
    }

    @Lob
    @Column
    private ArrayList<String> selImage;

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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    //    public String getType() {
//        return type;
//    }

//    public void setType(String type) {
//        this.type = type;
//    }


    public ArrayList<String> getSelImage() {
        return selImage;
    }

    public void setSelImage(ArrayList<String> selImage) {
        this.selImage = selImage;
    }

    public Set<Image> getImages() {
        return images;
    }

    public void setImages(Set<Image> images) {
        this.images = images;
    }

}
