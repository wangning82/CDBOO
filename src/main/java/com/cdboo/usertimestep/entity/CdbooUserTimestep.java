/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usertimestep.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户时段信息Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooUserTimestep extends DataEntity<CdbooUserTimestep> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户id
	private String name;		// 时段名称
	private String startTime;		// 开始时间
	private String endTime;		// 结束时间
	
	public CdbooUserTimestep() {
		super();
	}

	public CdbooUserTimestep(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=64, message="时段名称长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
}