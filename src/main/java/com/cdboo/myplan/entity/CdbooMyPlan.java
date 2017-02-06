/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.entity;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 新计划表Entity
 * @author yubin
 * @version 2017-02-03
 */
public class CdbooMyPlan extends DataEntity<CdbooMyPlan> {
	
	private static final long serialVersionUID = 1L;
	private String planName;		// 计划名称
	private User user;		// 用户id
	private String week;		// 周属性
	private String style;		// 风格（主题，节日，计划，插播）
	private Date startDate;		// 开始日期
	private Date endDate;		// 结束日期
	private String cycleIndex;		// 循环次数
	private String intervalTime;		// 重复时间
	private List<CdbooMyPlanTimestep> cdbooMyPlanTimestepList = Lists.newArrayList();		// 子表列表
	private List<CdbooUserTimestep> cdbooUserTimestepList = Lists.newArrayList();		// 用户时段中间表列表
	private List<String> userTimestepIds = Lists.newArrayList();
	private List<String> userChannelIds = Lists.newArrayList();
	private List<String> operationTypes = Lists.newArrayList();
	
	private String userTimeStepId;
	
	public CdbooMyPlan() {
		super();
	}

	public CdbooMyPlan(String id){
		super(id);
	}

	@Length(min=0, max=100, message="计划名称长度必须介于 0 和 100 之间")
	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}
	
	@Length(min=0, max=2, message="风格（主题，节日，计划，插播）长度必须介于 0 和 2 之间")
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
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
	
	@Length(min=0, max=255, message="循环次数长度必须介于 0 和 255 之间")
	public String getCycleIndex() {
		return cycleIndex;
	}

	public void setCycleIndex(String cycleIndex) {
		this.cycleIndex = cycleIndex;
	}
	
	@Length(min=0, max=10, message="重复时间长度必须介于 0 和 10 之间")
	public String getIntervalTime() {
		return intervalTime;
	}

	public void setIntervalTime(String intervalTime) {
		this.intervalTime = intervalTime;
	}
	
	public List<CdbooMyPlanTimestep> getCdbooMyPlanTimestepList() {
		return cdbooMyPlanTimestepList;
	}

	public void setCdbooMyPlanTimestepList(List<CdbooMyPlanTimestep> cdbooMyPlanTimestepList) {
		this.cdbooMyPlanTimestepList = cdbooMyPlanTimestepList;
	}

	public List<CdbooUserTimestep> getCdbooUserTimestepList() {
		return cdbooUserTimestepList;
	}

	public void setCdbooUserTimestepList(List<CdbooUserTimestep> cdbooUserTimestepList) {
		this.cdbooUserTimestepList = cdbooUserTimestepList;
	}

	public List<String> getUserTimestepIds() {
		return userTimestepIds;
	}

	public void setUserTimestepIds(List<String> userTimestepIds) {
		this.userTimestepIds = userTimestepIds;
	}

	public List<String> getWeeks() {
		if (StringUtils.isNotBlank(this.week)) {
			String[] weekArray = this.week.split(",");
			return Lists.newArrayList(weekArray);
		}
		return Lists.newArrayList();
	}

	public void setWeeks(List<String> weeks) {
		this.week = StringUtils.join(weeks, ",");
	}

	public String getUserTimeStepId() {
		return userTimeStepId;
	}

	public void setUserTimeStepId(String userTimeStepId) {
		this.userTimeStepId = userTimeStepId;
	}

	public List<String> getUserChannelIds() {
		return userChannelIds;
	}

	public void setUserChannelIds(List<String> userChannelIds) {
		this.userChannelIds = userChannelIds;
	}

	public List<String> getOperationTypes() {
		return operationTypes;
	}

	public void setOperationTypes(List<String> operationTypes) {
		this.operationTypes = operationTypes;
	}
	
}