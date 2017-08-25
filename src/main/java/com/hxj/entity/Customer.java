package com.hxj.entity;

public class Customer {
    private Integer cusid;

    private String cusname;

    private String cusLoginName;

    private String cusLoginPass;

    private Integer cusgender;

    private Integer cusage;

    private String cusprovince;

    private String cusarea;

    private String cusphone;

    public Integer getCusid() {
        return cusid;
    }

    public void setCusid(Integer cusid) {
        this.cusid = cusid;
    }

    public String getCusname() {
        return cusname;
    }

    public void setCusname(String cusname) {
        this.cusname = cusname == null ? null : cusname.trim();
    }

    public Integer getCusgender() {
        return cusgender;
    }

    public void setCusgender(Integer cusgender) {
        this.cusgender = cusgender;
    }

    public Integer getCusage() {
        return cusage;
    }

    public void setCusage(Integer cusage) {
        this.cusage = cusage;
    }

    public String getCusprovince() {
        return cusprovince;
    }

    public void setCusprovince(String cusprovince) {
        this.cusprovince = cusprovince == null ? null : cusprovince.trim();
    }

    public String getCusarea() {
        return cusarea;
    }

    public void setCusarea(String cusarea) {
        this.cusarea = cusarea == null ? null : cusarea.trim();
    }

    public String getCusphone() {
        return cusphone;
    }

    public void setCusphone(String cusphone) {
        this.cusphone = cusphone == null ? null : cusphone.trim();
    }

    public String getCusLoginName() {
        return cusLoginName;
    }

    public String getCusLoginPass() {
        return cusLoginPass;
    }

    public void setCusLoginName(String cusLoginName) {
        this.cusLoginName = cusLoginName;
    }

    public void setCusLoginPass(String cusLoginPass) {
        this.cusLoginPass = cusLoginPass;
    }


    @Override
    public String toString() {
        return "Customer{" +
                "cusid=" + cusid +
                ", cusname='" + cusname + '\'' +
                ", cusLoginName='" + cusLoginName + '\'' +
                ", cusLoginPass='" + cusLoginPass + '\'' +
                ", cusgender=" + cusgender +
                ", cusage=" + cusage +
                ", cusprovince='" + cusprovince + '\'' +
                ", cusarea='" + cusarea + '\'' +
                ", cusphone='" + cusphone + '\'' +
                '}';
    }
}