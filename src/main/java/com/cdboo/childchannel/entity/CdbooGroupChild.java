/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.childchannel.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.common.Constants;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 组合频道子表Entity
 * @author yubin
 * @version 2016-12-29
 */
public class CdbooGroupChild extends DataEntity<CdbooGroupChild> {
	
	private static final long serialVersionUID = 1L;
	
	//子频道
	public static final String CHANNEL_TYPE_CHILD = Constants.CHANNEL_TYPE_CHILD;
		
	//组合频道
	public static final String CHANNEL_TYPE_GROUP = Constants.CHANNEL_TYPE_GROUP;
	
	private CdbooChannel groupChannelId;		// 组合频道
	private CdbooChannel childChannelId;		// 子频道
	private String status;		// 状态位显示
	private Integer sort;
	private Integer childChannelSize; //子频道数量
	private List<CdbooChannel> channelList = Lists.newArrayList();//组合频道集合
	private List<CdbooChannel> childChannelList = Lists.newArrayList();//子频道集合
	private List<CdbooGroupChild> groupChildChannelList = Lists.newArrayList();//子频道集合
	
	private List<String> channelIds = Lists.newArrayList();
	private List<Integer> sorts = Lists.newArrayList();
	
	public CdbooGroupChild() {
		super();
	}

	public CdbooGroupChild(String id){
		super(id);
	}

	public CdbooGroupChild(CdbooChannel groupChannelId, CdbooChannel childChannelId, Integer sort) {
		super();
		this.groupChannelId = groupChannelId;
		this.childChannelId = childChannelId;
		if (sort == null) {
			sort = 0;
		}
		this.sort = sort;
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

	public Integer getChildChannelSize() {
		return childChannelSize;
	}

	public void setChildChannelSize(Integer childChannelSize) {
		this.childChannelSize = childChannelSize;
	}

	public List<CdbooChannel> getChannelList() {
		return channelList;
	}

	public void setChannelList(List<CdbooChannel> channelList) {
		this.channelList = channelList;
	}

	public List<CdbooChannel> getChildChannelList() {
		return childChannelList;
	}

	public void setChildChannelList(List<CdbooChannel> childChannelList) {
		this.childChannelList = childChannelList;
	}

	public List<String> getChannelIds() {
		return channelIds;
	}

	public void setChannelIds(List<String> channelIds) {
		this.channelIds = channelIds;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public List<CdbooGroupChild> getGroupChildChannelList() {
		return groupChildChannelList;
	}

	public void setGroupChildChannelList(List<CdbooGroupChild> groupChildChannelList) {
		this.groupChildChannelList = groupChildChannelList;
	}

	public List<Integer> getSorts() {
		return sorts;
	}

	public void setSorts(List<Integer> sorts) {
		this.sorts = sorts;
	}

}