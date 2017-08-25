package com.hxj.entity;

/**
 * Created by hxj on 17-8-21.
 */
public class Manager {

    private int mid;
    private String mloginName;
    private String mloginPass;

    public int getMid() {
        return mid;
    }

    public String getMloginName() {
        return mloginName;
    }

    public String getMloginPass() {
        return mloginPass;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public void setMloginName(String mloginName) {
        this.mloginName = mloginName;
    }

    public void setMloginPass(String mloginPass) {
        this.mloginPass = mloginPass;
    }

    @Override
    public String toString() {
        return "Manager{" +
                "mid=" + mid +
                ", mloginName='" + mloginName + '\'' +
                ", mloginPass='" + mloginPass + '\'' +
                '}';
    }
}
