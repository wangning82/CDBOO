package com.cdboo.business.entity;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.timestep.entity.Timestep;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Role;

import java.util.Date;
import java.util.List;

/**
 * Created by mmzz on 2016/12/13.
 */
public class BusinessTimestep extends DataEntity<BusinessTimestep> {

    private String name;
    private String sort;
    private String remarks;
    private String status;

    private String musicStyle;
    private String week;
    private Date startDate;
    private Date endDate;

    private Business business;
    private Timestep timestep;
    private CdbooChannel channel;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public Timestep getTimestep() {
        return timestep;
    }

    public void setTimestep(Timestep timestep) {
        this.timestep = timestep;
    }

    @Override
    public String getRemarks() {
        return remarks;
    }

    @Override
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public CdbooChannel getChannel() {
        return channel;
    }

    public void setChannel(CdbooChannel channel) {
        this.channel = channel;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getMusicStyle() {
        return musicStyle;
    }

    public void setMusicStyle(String musicStyle) {
        this.musicStyle = musicStyle;
    }
}
