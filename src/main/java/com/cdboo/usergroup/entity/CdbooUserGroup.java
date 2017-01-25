package com.cdboo.usergroup.entity;

import java.util.List;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.childchannel.entity.CdbooGroupChild;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * Created by mmzz on 2017/1/3.
 */
public class CdbooUserGroup extends DataEntity<CdbooUserGroup> {
	private static final long serialVersionUID = 1L;

	private User user;

	private CdbooChannel cdbooChannel;

	private List<CdbooChannel> channelList = Lists.newArrayList();

	private List<CdbooChannel> groupChildList = Lists.newArrayList();
	
	private List<CdbooGroupChild> groupChildChannelList = Lists.newArrayList();//子频道集合
	
	private int childChannelSize;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public CdbooChannel getCdbooChannel() {
		return cdbooChannel;
	}

	public void setCdbooChannel(CdbooChannel cdbooChannel) {
		this.cdbooChannel = cdbooChannel;
	}

	public List<CdbooChannel> getChannelList() {
		return channelList;
	}

	public void setChannelList(List<CdbooChannel> channelList) {
		this.channelList = channelList;
	}

	public int getChildChannelSize() {
		return childChannelSize;
	}

	public void setChildChannelSize(int childChannelSize) {
		this.childChannelSize = childChannelSize;
	}

	public List<CdbooChannel> getGroupChildList() {
		return groupChildList;
	}

	public void setGroupChildList(List<CdbooChannel> groupChildList) {
		this.groupChildList = groupChildList;
	}

	public List<CdbooGroupChild> getGroupChildChannelList() {
		return groupChildChannelList;
	}

	public void setGroupChildChannelList(List<CdbooGroupChild> groupChildChannelList) {
		this.groupChildChannelList = groupChildChannelList;
	}

}
