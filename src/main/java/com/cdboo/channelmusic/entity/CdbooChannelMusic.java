/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channelmusic.entity;

import com.cdboo.channel.entity.CdbooChannel;
import com.cdboo.music.entity.CdbooMusic;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 频道音乐中间表生成方案Entity
 * @author yubin
 * @version 2017-01-23
 */
public class CdbooChannelMusic extends DataEntity<CdbooChannelMusic> {
	
	private static final long serialVersionUID = 1L;
	private CdbooChannel channel;   // 子频道
	private CdbooMusic music;		// 音乐
	private Integer sort;           // 排序
	public CdbooChannelMusic() {
		super();
	}

	public CdbooChannelMusic(String id){
		super(id);
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

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

}