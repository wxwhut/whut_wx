package com.whut_vaccine.domain;


public class Vaccine{
    private int id;
    private String makeday;
    private String keepday;
    private String vaccinename;
    private double price;
    private String introduce;
    private int pnumber;

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public Vaccine(int id, String makeday, String keepday, String vaccinename, double price, String introduce, int pnumber) {
        this.id = id;
        this.makeday = makeday;
        this.keepday = keepday;
        this.vaccinename = vaccinename;
        this.price = price;
        this.introduce = introduce;
        this.pnumber = pnumber;
    }

    public Vaccine(){

    }
    public Vaccine(int id, String makeday, String keepday, String vaccinename) {
        this.id = id;
        this.makeday = makeday;
        this.keepday = keepday;
        this.vaccinename = vaccinename;
    }
    public Vaccine(int id, String makeday, String keepday, String vaccinename, int pnumber) {
        this.id = id;
        this.makeday = makeday;
        this.keepday = keepday;
        this.vaccinename = vaccinename;
        this.pnumber = pnumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMakeday() {
        return makeday;
    }

    public void setMakeday(String makeday) {
        this.makeday = makeday;
    }

    public String getKeepday() {
        return keepday;
    }

    public void setKeepday(String keepday) {
        this.keepday = keepday;
    }

    public String getVaccinename() {
        return vaccinename;
    }

    public void setVaccinename(String vaccinename) {
        this.vaccinename = vaccinename;
    }

    public int getPnumber() {
        return pnumber;
    }

    public void setPnumber(int pnumber) {
        this.pnumber = pnumber;
    }

    @Override
    public String toString() {
        return "vaccine{" +
                "id=" + id +
                ", makeday='" + makeday + '\'' +
                ", keepday='" + keepday + '\'' +
                ", vaccinename='" + vaccinename + '\'' +
                ", pnumber=" + pnumber +
                '}';
    }
}
