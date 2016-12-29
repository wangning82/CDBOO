package com.cdboo.rest;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.timestep.entity.Timestep;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by mmzz on 2016/12/29.
 */
public class PlanModel implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String planNo;		// 计划编号
    private String playName;		// 计划名称
    private String musicStyle;		// 风格
    private String week;		// 日期
    private Date startDate;		// 开始日期
    private Date endDate;		// 结束日期
    private String status;		// 状态位显示

    private RestTimeStep timestep;
    private RestChannel channel;

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

	public RestTimeStep getTimestep() {
		return timestep;
	}

	public void setTimestep(RestTimeStep timestep) {
		this.timestep = timestep;
	}

	public RestChannel getChannel() {
		return channel;
	}

	public void setChannel(RestChannel channel) {
		this.channel = channel;
	}

}
