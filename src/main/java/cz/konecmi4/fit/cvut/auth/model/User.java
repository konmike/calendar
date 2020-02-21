package cz.konecmi4.fit.cvut.auth.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String password;

    @Transient
    private String passwordConfirm;

    @Transient
    private String newPassword;

    @Transient
    private String oldPassword;

    @ManyToMany
    private Set<Role> roles;

    @OneToMany(cascade = CascadeType.ALL)
    private Set<Image> imageList;

    @OneToMany(cascade = CascadeType.ALL)
    private Set<Calendar> calendars;

    private ArrayList checkImage;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Set<Image> getImageList() {
        return imageList;
    }

    public void setImageList(Set<Image> imageList) {
        this.imageList = imageList;
    }

    public ArrayList getCheckImage() {
        return checkImage;
    }

    public void setCheckImage(ArrayList checkImage) {
        this.checkImage = checkImage;
    }

    public Set<Calendar> getCalendars() {
        return calendars;
    }

    public void setCalendars(Set<Calendar> calendars) {
        this.calendars = calendars;
    }
}
