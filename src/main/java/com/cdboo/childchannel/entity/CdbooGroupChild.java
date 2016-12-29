/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.childchannel.entity;

import com.cdboo.channel.entity.CdbooChannel;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 组合频道子表Entity
 * @author yubin
 * @version 2016-12-29
 */
public class CdbooGroupChild extends DataEntity<CdbooGroupChild> {
	
	private static final long serialVersionUID = 1L;
	private CdbooChannel groupChannelId;		// 组合频道
	private CdbooChannel childChannelId;		// 子频道
	private String status;		// 状态位显示
	
	public CdbooGroupChild() {
		super();
	}

	public CdbooGroupChild(String id){
		super(id);
	}

	public CdbooChannel getGroupChannelId() {
		return groupChannelId;
	}

	public void setGroupChannelId(CdbooChannel groupChannelId) {
		this.groupChannelId = groupChannelId;
	}
	
	public CdbooChannel getChildChannelId() {
		return childChannelId;
	}

	public void setChildChannelId(CdbooChannel childChannelId) {
		this.childChannelId = childChannelId;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}