/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.entity;

import java.util.List;
import org.hibernate.validator.constraints.Length;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 新计划表Entity
 * @author yubin
 * @version 2017-02-03
 */
public class CdbooMyPlanTimestep extends DataEntity<CdbooMyPlanTimestep> {
	
	private static final long serialVersionUID = 1L;
	private CdbooMyPlan plan;		// 计划id 父类
	private CdbooUserTimestep userTimestep;		// 用户时段id
	List<CdbooUserChannel> cdbooUserChannels = Lists.newArrayList();
	List<CdbooMyPlanTimestepChannel> cdbooMyPlanTimestepChannels = Lists.newArrayList();
	public CdbooMyPlanTimestep() {
		super();
	}

	public CdbooMyPlanTimestep(String id){
		super(id);
	}

	public CdbooMyPlanTimestep(CdbooMyPlan plan){
		this.plan = plan;
	}

	@Length(min=0, max=64, message="计划id长度必须介于 0 和 64 之间")
	public CdbooMyPlan getPlan() {
		return plan;
	}

	public void setPlan(CdbooMyPlan plan) {
		this.plan = plan;
	}
	
	public CdbooUserTimestep getUserTimestep() {
		return userTimestep;
	}

	public void setUserTimestep(CdbooUserTimestep userTimestep) {
		this.userTimestep = userTimestep;
	}

	public List<CdbooUserChannel> getCdbooUserChannels() {
		return cdbooUserChannels;
	}

	public void setCdbooUserChannels(List<CdbooUserChannel> cdbooUserChannels) {
		this.cdbooUserChannels = cdbooUserChannels;
	}

	public List<CdbooMyPlanTimestepChannel> getCdbooMyPlanTimestepChannels() {
		return cdbooMyPlanTimestepChannels;
	}

	public void setCdbooMyPlanTimestepChannels(List<CdbooMyPlanTimestepChannel> cdbooMyPlanTimestepChannels) {
		this.cdbooMyPlanTimestepChannels = cdbooMyPlanTimestepChannels;
	}
	
}