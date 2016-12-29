package com.cdboo.rest;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by mmzz on 2016/12/28.
 */
public class RestModel implements Serializable {

    private String userName;//用户姓名
    private String shopownerName;//店长姓名

    private Date businessHoursBegin;//营业时间开始
    private Date businessHoursEnd;//营业时间结束

    private String address;//门店地址
    private String photo;//用户头像

    List<PlanModel> planModelList;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getShopownerName() {
        return shopownerName;
    }

    public void setShopownerName(String shopownerName) {
        this.shopownerName = shopownerName;
    }

    public Date getBusinessHoursBegin() {
        return businessHoursBegin;
    }

    public void setBusinessHoursBegin(Date businessHoursBegin) {
        this.businessHoursBegin = businessHoursBegin;
    }

    public Date getBusinessHoursEnd() {
        return businessHoursEnd;
    }

    public void setBusinessHoursEnd(Date businessHoursEnd) {
        this.businessHoursEnd = businessHoursEnd;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public List<PlanModel> getPlanModelList() {
        return planModelList;
    }

    public void setPlanModelList(List<PlanModel> planModelList) {
        this.planModelList = planModelList;
    }
}
