/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.myplan.entity;

import com.cdboo.myplan.entity.CdbooMyPlanTimestep;
import com.cdboo.userchannel.entity.CdbooUserChannel;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 计划时段频道表Entity
 * @author yubin
 * @version 2017-02-06
 */
public class CdbooMyPlanTimestepChannel extends DataEntity<CdbooMyPlanTimestepChannel> {
	
	private static final long serialVersionUID = 1L;
	private CdbooMyPlanTimestep myPlanTimestep;		// my_plan_timestep_id
	private CdbooUserChannel userChannel;		// user_channel_id
	private String channelType;		// channel_type
	private String operationType;		// operation_type
	
	public CdbooMyPlanTimestepChannel() {
		super();
	}

	public CdbooMyPlanTimestepChannel(CdbooMyPlanTimestep myPlanTimestep, CdbooUserChannel userChannel,
			String channelType, String operationType) {
		super();
		this.myPlanTimestep = myPlanTimestep;
		this.userChannel = userChannel;
		this.channelType = channelType;
		this.operationType = operationType;
	}

	public CdbooMyPlanTimestepChannel(String id){
		super(id);
	}

	public CdbooMyPlanTimestep getMyPlanTimestep() {
		return myPlanTimestep;
	}

	public void setMyPlanTimestep(CdbooMyPlanTimestep myPlanTimestep) {
		this.myPlanTimestep = myPlanTimestep;
	}
	
	public CdbooUserChannel getUserChannel() {
		return userChannel;
	}

	public void setUserChannel(CdbooUserChannel userChannel) {
		this.userChannel = userChannel;
	}
	
	@Length(min=0, max=1, message="channel_type长度必须介于 0 和 1 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=64, message="operation_type长度必须介于 0 和 64 之间")
	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	
}