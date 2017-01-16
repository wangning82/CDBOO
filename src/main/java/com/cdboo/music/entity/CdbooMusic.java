/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.music.entity;

import java.util.Date;
import java.util.List;
import org.hibernate.validator.constraints.Length;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 曲库管理Entity
 * @author 于滨
 * @version 2016-12-17
 */
public class CdbooMusic extends DataEntity<CdbooMusic> {
	
	private static final long serialVersionUID = 1L;
	private String musicNo;		// 音乐编号
	private String musicOwner;		// 音乐拥有者类型
	private String musicName;		// 音乐名称
	private String actor;		// 艺人
	private String special;		// 专辑
	private String volume;		// 音量
	private String status;		// 状态
	private String path;		// 音乐路径
	private String duration;    // 音乐时长
	private String ids;
	private List<String> idArray;
	private List<String> inIdArray;
	private String userId;
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	
	public CdbooMusic() {
		super();
	}

	public CdbooMusic(String id){
		super(id);
	}

	@Length(min=0, max=100, message="音乐编号长度必须介于 0 和 100 之间")
	@ExcelField(title="音乐编号",type=1,align=2, sort=10)
	public String getMusicNo() {
		return musicNo;
	}

	public void setMusicNo(String musicNo) {
		this.musicNo = musicNo;
	}
	
	@Length(min=0, max=1, message="音乐拥有者类型长度必须介于 0 和 1 之间")
	public String getMusicOwner() {
		return musicOwner;
	}

	public void setMusicOwner(String musicOwner) {
		this.musicOwner = musicOwner;
	}
	
	@Length(min=0, max=100, message="音乐名称长度必须介于 0 和 100 之间")
	@ExcelField(title="音乐名称",type=1,align=2, sort=20)
	public String getMusicName() {
		return musicName;
	}

	public void setMusicName(String musicName) {
		this.musicName = musicName;
	}
	
	@Length(min=0, max=100, message="艺人长度必须介于 0 和 100 之间")
	@ExcelField(title="艺人",type=1,align=2, sort=30)
	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}
	
	@Length(min=0, max=100, message="专辑长度必须介于 0 和 100 之间")
	@ExcelField(title="专辑",type=1,align=2, sort=40)
	public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}
	
	@Length(min=0, max=10, message="音量长度必须介于 0 和 10 之间")
	public String getVolume() {
		return volume;
	}

	@ExcelField(title="音量",type=1,align=2, sort=50)
	public String getFormatVolume(){
		return StringUtils.isNotBlank(this.volume)?this.volume+"%":"";
	}
	
	@Override
	@ExcelField(title="创建时间",type=1,align=2, sort=50)
	public Date getCreateDate() {
		return super.getCreateDate();
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=2000, message="音乐路径长度必须介于 0 和 2000 之间")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			idArray = Lists.newArrayList();
			String[] idsArray = StringUtils.split(ids, ",");
			for (int i = 0; i < idsArray.length; i++) {
				idArray.add("'"+idsArray[i]+"'");
			}
		}
	}

	public List<String> getIdArray() {
		return idArray;
	}

	public void setIdArray(List<String> idArray) {
		this.idArray = idArray;
	}

	public void setInIds(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			inIdArray = Lists.newArrayList();
			String[] idsArray = StringUtils.split(ids, ",");
			for (int i = 0; i < idsArray.length; i++) {
				inIdArray.add("'"+idsArray[i]+"'");
			}
		}
	}
	
	public List<String> getInIdArray() {
		return inIdArray;
	}

	public void setInIdArray(List<String> inIdArray) {
		this.inIdArray = inIdArray;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}
	
}