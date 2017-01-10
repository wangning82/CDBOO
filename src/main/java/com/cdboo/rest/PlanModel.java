package com.cdboo.rest;

import java.io.Serializable;

/**
 * Created by mmzz on 2016/12/29.
 */
public class PlanModel implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String planNo;		// 计划编号
    private String playName;		// 计划名称
    private String musicStyle;		// 风格，优先级是 插播--节日--主题--风格
    private String week;		// 日期
    private String startDate;		// 开始日期
    private String endDate;		// 结束日期
    private String status;		// 状态位显示
    private String cycleTimes;     //循环次数 如果风格是插播，取该处字段值
    private String intervalTime; //间隔时间
    private String scene;//业态

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

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
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

    public String getCycleTimes() {
        return cycleTimes;
    }

    public void setCycleTimes(String cycleTimes) {
        this.cycleTimes = cycleTimes;
    }

    public String getScene() {
        return scene;
    }

    public void setScene(String scene) {
        this.scene = scene;
    }

    public String getIntervalTime() {
        return intervalTime;
    }

    public void setIntervalTime(String intervalTime) {
        this.intervalTime = intervalTime;
    }
}
