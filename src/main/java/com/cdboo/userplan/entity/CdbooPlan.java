/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userplan.entity;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.music.entity.CdbooMusic;
import com.cdboo.timestep.entity.Timestep;
import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户计划表Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooPlan extends DataEntity<CdbooPlan> {
	
	private static final long serialVersionUID = 1L;
	private String planNo;		// 计划编号
	private String playName;		// 计划名称
	private User user;		// 用户id
	private String userTimestepId;		// 用户时段id
	private String userChannelId;		// 用户频道id
	private String musicStyle;		// 风格
	private String week;		// 日期
	private Date startDate;		// 开始日期
	private Date endDate;		// 结束日期
	private String status;		// 状态位显示
	private String rate;//次数
	private String condition;//业态

	private Timestep timestep;
	private CdbooChannel channel;
	private CdbooMusic music;

	public CdbooPlan() {
		super();
	}

	public CdbooPlan(String id){
		super(id);
	}

	@Length(min=0, max=100, message="计划编号长度必须介于 0 和 100 之间")
	public String getPlanNo() {
		return planNo;
	}

	public void setPlanNo(String planNo) {
		this.planNo = planNo;
	}
	
	@Length(min=0, max=100, message="计划名称长度必须介于 0 和 100 之间")
	public String getPlayName() {
		return playName;
	}

	public void setPlayName(String playName) {
		this.playName = playName;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="用户时段id长度必须介于 0 和 64 之间")
	public String getUserTimestepId() {
		return userTimestepId;
	}

	public void setUserTimestepId(String userTimestepId) {
		this.userTimestepId = userTimestepId;
	}
	
	@Length(min=0, max=64, message="用户频道id长度必须介于 0 和 64 之间")
	public String getUserChannelId() {
		return userChannelId;
	}

	public void setUserChannelId(String userChannelId) {
		this.userChannelId = userChannelId;
	}
	
	@Length(min=0, max=255, message="风格长度必须介于 0 和 255 之间")
	public String getMusicStyle() {
		return musicStyle;
	}

	public void setMusicStyle(String musicStyle) {
		this.musicStyle = musicStyle;
	}
	
	@Length(min=0, max=255, message="日期长度必须介于 0 和 255 之间")
	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
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

	public CdbooMusic getMusic() {
		return music;
	}

	public void setMusic(CdbooMusic music) {
		this.music = music;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
}