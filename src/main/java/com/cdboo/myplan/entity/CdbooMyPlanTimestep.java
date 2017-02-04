/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.entity;

import org.hibernate.validator.constraints.Length;
import com.cdboo.usertimestep.entity.CdbooUserTimestep;
import com.cdboo.userchannel.entity.CdbooUserChannel;

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
	private CdbooUserChannel userChannel;		// 用户频道id
	private String channelType;		// 频道类型，是组合频道还是子频道
	private String operationType;		// 业态id，机构表id
	
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
	
	public CdbooUserChannel getUserChannel() {
		return userChannel;
	}

	public void setUserChannel(CdbooUserChannel userChannel) {
		this.userChannel = userChannel;
	}
	
	@Length(min=0, max=1, message="频道类型，是组合频道还是子频道长度必须介于 0 和 1 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=64, message="业态id，机构表id长度必须介于 0 和 64 之间")
	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	
}