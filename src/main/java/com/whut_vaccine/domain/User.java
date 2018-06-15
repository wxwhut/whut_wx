package com.whut_vaccine.domain;

public class User {
    private int id;
    private String username;
    private String password;
    private String leveltype;
    private String email;
    private String phone;

    public User() {
    }

    public User(String username, String password, String leveltype, String email, String phone) {
        this.username = username;
        this.password = password;
        this.leveltype = leveltype;
        this.email = email;
        this.phone = phone;
    }

    public User(String username, String password) {
        this.username = username;
        this.password = password;
        this.leveltype = "1";
        this.email = "";
        this.phone = "";
    }

    public User(int id, String username, String password, String leveltype, String email, String phone) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.leveltype = leveltype;
        this.email = email;
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getusername() {
        return username;
    }

    public void setusername(String username) {
        this.username = username;
    }

    public String getpassword() {
        return password;
    }

    public void setpassword(String password) {
        this.password = password;
    }

    public String getLeveltype() {
        return leveltype;
    }

    public void setLeveltype(String leveltype) {
        this.leveltype = leveltype;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "User{" +
                "id="  +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", leveltype='" + leveltype + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}
