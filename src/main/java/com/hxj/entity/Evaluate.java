package com.hxj.entity;

public class Evaluate {
    private Integer eid;

    private Integer cusid;

    private Integer cid;

    private Integer attitude;

    private Integer exterior;

    private Integer trim;

    private Integer space;

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public Integer getCusid() {
        return cusid;
    }

    public void setCusid(Integer cusid) {
        this.cusid = cusid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getAttitude() {
        return attitude;
    }

    public void setAttitude(Integer attitude) {
        this.attitude = attitude;
    }

    public Integer getExterior() {
        return exterior;
    }

    public void setExterior(Integer exterior) {
        this.exterior = exterior;
    }

    public Integer getTrim() {
        return trim;
    }

    public void setTrim(Integer trim) {
        this.trim = trim;
    }

    public Integer getSpace() {
        return space;
    }

    public void setSpace(Integer space) {
        this.space = space;
    }

    @Override
    public String toString() {
        return "Evaluate{" +
                "eid=" + eid +
                ", cusid=" + cusid +
                ", cid=" + cid +
                ", attitude=" + attitude +
                ", exterior=" + exterior +
                ", trim=" + trim +
                ", space=" + space +
                '}';
    }
}