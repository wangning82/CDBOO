/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usertimestep.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;
import jersey.repackaged.com.google.common.collect.Lists;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.cdboo.timestep.entity.Timestep;
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
	private String lastTimeStepId;//最后选择的时段id，为了配合页面使用，没有存到数据库，备用
	
	private String ids;
	private String userId;
	private List<String> notIncludeIds;
	
	private List<CdbooUserTimestep> timestepList = Lists.newArrayList();
	private List<Timestep> timestepEntityList = Lists.newArrayList();
	
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

	public List<CdbooUserTimestep> getTimestepList() {
		return timestepList;
	}

	public void setTimestepList(List<CdbooUserTimestep> timestepList) {
		this.timestepList = timestepList;
	}
	
	public List<Timestep> getTimestepEntityList() {
		return timestepEntityList;
	}

	public void setTimestepEntityList(List<Timestep> timestepEntityList) {
		this.timestepEntityList = timestepEntityList;
	}

	public String getLastTimeStepId() {
		return lastTimeStepId;
	}

	public void setLastTimeStepId(String lastTimeStepId) {
		this.lastTimeStepId = lastTimeStepId;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;

		if (StringUtils.isNotBlank(ids)) {
			notIncludeIds = Lists.newArrayList();
			String[] idsArray = StringUtils.split(ids, ",");
			for (int i = 0; i < idsArray.length; i++) {
				notIncludeIds.add("'" + idsArray[i] + "'");
			}
		}
	}

	public List<String> getNotIncludeIds() {
		return notIncludeIds;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}