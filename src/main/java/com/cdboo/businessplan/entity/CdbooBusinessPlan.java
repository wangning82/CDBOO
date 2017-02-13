/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.businessplan.entity;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;
import com.cdboo.business.entity.Business;
import com.cdboo.timestep.entity.Timestep;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 行业计划模板表Entity
 * @author yubin
 * @version 2017-02-10
 */
public class CdbooBusinessPlan extends DataEntity<CdbooBusinessPlan> {
	
	private static final long serialVersionUID = 1L;
	private String planName;		// 计划名称
	private Business business;		// 行业id
	private String week;		// 周属性
	private String style;		// 风格（主题，节日，计划，插播）
	private Date startDate;		// 开始日期
	private Date endDate;		// 结束日期
	private String cycleIndex;		// 循环次数
	private String intervalTime;		// 重复时间
	private String businessId;
	private List<Timestep> timesteps = Lists.newArrayList();
	private List<String> timeStepIds = Lists.newArrayList();
	public String getBusinessId() {
		return businessId;
	}

	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}

	public CdbooBusinessPlan() {
		super();
	}

	public CdbooBusinessPlan(String id){
		super(id);
	}

	@Length(min=0, max=100, message="计划名称长度必须介于 0 和 100 之间")
	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}
	
	public Business getBusiness() {
		return business;
	}

	public void setBusiness(Business business) {
		this.business = business;
	}
	
	@Length(min=0, max=100, message="周属性长度必须介于 0 和 100 之间")
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

	public List<Timestep> getTimesteps() {
		return timesteps;
	}

	public void setTimesteps(List<Timestep> timesteps) {
		this.timesteps = timesteps;
	}

	public List<String> getTimeStepIds() {
		return timeStepIds;
	}

	public void setTimeStepIds(List<String> timeStepIds) {
		this.timeStepIds = timeStepIds;
	}
	
}