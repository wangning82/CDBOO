/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.usermusic.entity;

import com.cdboo.music.entity.CdbooMusic;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户曲库信息Entity
 * @author yubin
 * @version 2016-12-21
 */
public class CdbooOwnerMusic extends DataEntity<CdbooOwnerMusic> {
	
	private static final long serialVersionUID = 1L;
	private CdbooMusic musicId;		// 音乐id
	private User user;		// 用户id
	private String status;		// 状态位显示
	
	public CdbooOwnerMusic() {
		super();
	}

	public CdbooOwnerMusic(String id){
		super(id);
	}

	public CdbooMusic getMusicId() {
		return musicId;
	}

	public void setMusicId(CdbooMusic musicId) {
		this.musicId = musicId;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}