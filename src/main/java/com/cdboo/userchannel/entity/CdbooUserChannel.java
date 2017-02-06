/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.userchannel.entity;

import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.List;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.music.entity.CdbooMusic;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户频道表Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooUserChannel extends DataEntity<CdbooUserChannel> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户id
	private CdbooChannel channel;		// 频道id
	private CdbooMusic music;		// 音乐id
	private int musicSize;
	
	private String operationType;//yetai
	
	private List<String> channelIds = Lists.newArrayList();
	
	private List<CdbooChannel> channelList = Lists.newArrayList();
	
	private List<CdbooMusic> musicList = Lists.newArrayList();
	
	private List<String> musicIds = Lists.newArrayList();
	
	public CdbooUserChannel() {
		super();
	}

	public CdbooUserChannel(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public CdbooChannel getChannel() {
		return channel;
	}

	public void setChannel(CdbooChannel channel) {
		this.channel = channel;
	}
	
	public CdbooMusic getMusic() {
		return music;
	}

	public void setMusic(CdbooMusic music) {
		this.music = music;
	}

	public int getMusicSize() {
		return musicSize;
	}

	public void setMusicSize(int musicSize) {
		this.musicSize = musicSize;
	}

	public List<CdbooChannel> getChannelList() {
		return channelList;
	}

	public void setChannelList(List<CdbooChannel> channelList) {
		this.channelList = channelList;
	}

	public List<CdbooMusic> getMusicList() {
		return musicList;
	}

	public void setMusicList(List<CdbooMusic> musicList) {
		this.musicList = musicList;
	}

	public List<String> getMusicIds() {
		return musicIds;
	}

	public void setMusicIds(List<String> musicIds) {
		this.musicIds = musicIds;
	}

	public List<String> getChannelIds() {
		return channelIds;
	}

	public void setChannelIds(List<String> channelIds) {
		this.channelIds = channelIds;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

}