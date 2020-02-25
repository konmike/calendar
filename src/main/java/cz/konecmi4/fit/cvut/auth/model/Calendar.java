package cz.konecmi4.fit.cvut.auth.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "calendar")
public class Calendar {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private int year;

    //private String type;


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

//    public String getType() {
//        return type;
//    }

//    public void setType(String type) {
//        this.type = type;
//    }


    public ArrayList getSelImage() {
        return selImage;
    }

    public void setSelImage(ArrayList selImage) {
        this.selImage = selImage;
    }
}
