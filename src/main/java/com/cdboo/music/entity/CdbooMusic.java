/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 曲库管理Entity
 * @author yubin
 * @version 2016-12-13
 */
public class CdbooMusic extends DataEntity<CdbooMusic> {
	
	private static final long serialVersionUID = 1L;
	private String musicNo;		// 音乐编号
	private String musicOwner;		// 音乐拥有者类型
	private String musicName;		// 音乐名称
	private String actor;		// 艺人
	private String special;		// 专辑
	private String volume;		// 音量
	private String status;		// 状态位显示
	private String path;
	
	public CdbooMusic() {
		super();
	}

	public CdbooMusic(String id){
		super(id);
	}

	@Length(min=0, max=100, message="音乐编号长度必须介于 0 和 100 之间")
	public String getMusicNo() {
		return musicNo;
	}

	public void setMusicNo(String musicNo) {
		this.musicNo = musicNo;
	}
	
	@Length(min=0, max=100, message="音乐拥有者类型长度必须介于 0 和 100 之间")
	public String getMusicOwner() {
		return musicOwner;
	}

	public void setMusicOwner(String musicOwner) {
		this.musicOwner = musicOwner;
	}
	
	@Length(min=0, max=1000, message="音乐名称长度必须介于 0 和 1000 之间")
	public String getMusicName() {
		return musicName;
	}

	public void setMusicName(String musicName) {
		this.musicName = musicName;
	}
	
	@Length(min=0, max=1000, message="艺人长度必须介于 0 和 1000 之间")
	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}
	
	@Length(min=0, max=1000, message="专辑长度必须介于 0 和 1000 之间")
	public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}
	
	@Length(min=0, max=1000, message="音量长度必须介于 0 和 1000 之间")
	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
}