package com.cdboo.rest;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.timestep.entity.Timestep;
import com.cdboo.timestep.service.TimestepService;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;
import java.util.List;

/**
 * Created by mmzz on 2016/12/28.
 */
public class RestModel {

    private String planNo;		// 计划编号
    private String playName;		// 计划名称
    private String musicStyle;		// 风格
    private String week;		// 日期
    private Date startDate;		// 开始日期
    private Date endDate;		// 结束日期
    private String status;		// 状态位显示

    Timestep timestep;
    CdbooChannel channel;

    public String getPlanNo() {
        return planNo;
    }

    public void setPlanNo(String planNo) {
        this.planNo = planNo;
    }

    public String getPlayName() {
        return playName;
    }

    public void setPlayName(String playName) {
        this.playName = playName;
    }

    public String getMusicStyle() {
        return musicStyle;
    }

    public void setMusicStyle(String musicStyle) {
        this.musicStyle = musicStyle;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestep getTimestep() {
        return timestep;
    }

    public void setTimestep(Timestep timestep) {
        this.timestep = timestep;
    }

    public CdbooChannel getChannel() {
        return channel;
    }

    public void setChannel(CdbooChannel channel) {
        this.channel = channel;
    }
}
