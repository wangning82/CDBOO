/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.musicinsert.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.modules.sys.entity.User;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 插播计划表Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooMusicInsert extends DataEntity<CdbooMusicInsert> {
	
	private static final long serialVersionUID = 1L;
	private String insertNo;		// 插播编号
	private String insertName;		// 插播名称
	private Date startDate;		// 开始日期
	private Date endDate;		// 结束日期
	private String musicId;		// 音乐
	private String time;		// 时间点
	private String number;		// 循环次数
	private String status;		// 状态位显示
	private User user;		// 用户
	
	public CdbooMusicInsert() {
		super();
	}

	public CdbooMusicInsert(String id){
		super(id);
	}

	@Length(min=0, max=100, message="插播编号长度必须介于 0 和 100 之间")
	public String getInsertNo() {
		return insertNo;
	}

	public void setInsertNo(String insertNo) {
		this.insertNo = insertNo;
	}
	
	@Length(min=0, max=100, message="插播名称长度必须介于 0 和 100 之间")
	public String getInsertName() {
		return insertName;
	}

	public void setInsertName(String insertName) {
		this.insertName = insertName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=0, max=64, message="音乐长度必须介于 0 和 64 之间")
	public String getMusicId() {
		return musicId;
	}

	public void setMusicId(String musicId) {
		this.musicId = musicId;
	}
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	@Length(min=0, max=10, message="循环次数长度必须介于 0 和 10 之间")
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}