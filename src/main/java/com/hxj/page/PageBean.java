package com.hxj.page;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by com.hxj on 17-7-24.
 */
public class PageBean<T>{

    private int pageNow = 1;
    private int pageCount = 5;
    private int totalRows;
    private int totalPages;
    private Integer start;
    private List<T> datas;
    private Map<String,Object> conditions;

    public int getPageNow() {
        return pageNow;
    }

    public int getPageCount() {
        return pageCount;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public Integer getStart() {
        if (start==null){
            return (pageNow-1)*pageCount;
        }
        return start;
    }

    public int getTotalPages() {
        if(totalRows%pageCount==0){
            totalPages = totalRows/pageCount;
        }else{
            totalPages = totalRows/pageCount+1;
        }
        return totalPages;
    }

    public List<T> getDatas() {
        return datas;
    }

    public Map<String,Object> getConditions() {
        return conditions;
    }

    public void setPageNow(int pageNow) {
        this.pageNow = pageNow;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
    }

    public void setConditions(Map<String,Object> conditions) {
        this.conditions = conditions;
    }

    public Map<String,Object> getMap(){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("total", this.getTotalRows());
        map.put("rows", this.getDatas());
        return map;
    }

    @Override
    public String toString() {
        return "PageBean{" +
                "pageNow=" + pageNow +
                ", pageCount=" + pageCount +
                ", totalRows=" + totalRows +
                ", totalPages=" + totalPages +
                '}';
    }
}
