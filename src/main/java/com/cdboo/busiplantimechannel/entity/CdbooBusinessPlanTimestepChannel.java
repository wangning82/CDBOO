/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.busiplantimechannel.entity;

import com.cdboo.businessplantimestep.entity.CdbooBusinessPlanTimestep;
import com.cdboo.channel.entity.CdbooChannel;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 行业计划时段频道表Entity
 * @author yubin
 * @version 2017-02-10
 */
public class CdbooBusinessPlanTimestepChannel extends DataEntity<CdbooBusinessPlanTimestepChannel> {
	
	private static final long serialVersionUID = 1L;
	private CdbooBusinessPlanTimestep businessPlanTimestep;		// 行业计划时段关联表主键
	private CdbooChannel channel;		// 频道主键
	private String channelType;		// 频道类型
	private String operationType;		// 业态
	
	public CdbooBusinessPlanTimestepChannel() {
		super();
	}

	public CdbooBusinessPlanTimestepChannel(String id){
		super(id);
	}

	public CdbooBusinessPlanTimestep getBusinessPlanTimestep() {
		return businessPlanTimestep;
	}

	public void setBusinessPlanTimestep(CdbooBusinessPlanTimestep businessPlanTimestep) {
		this.businessPlanTimestep = businessPlanTimestep;
	}
	
	public CdbooChannel getChannel() {
		return channel;
	}

	public void setChannel(CdbooChannel channel) {
		this.channel = channel;
	}
	
	@Length(min=0, max=1, message="频道类型长度必须介于 0 和 1 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	
	@Length(min=0, max=64, message="业态长度必须介于 0 和 64 之间")
	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	
}