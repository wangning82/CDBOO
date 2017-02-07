/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.channel.entity;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.cdboo.channelmusic.entity.CdbooChannelMusic;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 频道管理Entity
 * 
 * @author 于滨
 * @version 2016-12-17
 */
public class CdbooChannel extends DataEntity<CdbooChannel> {

	private static final long serialVersionUID = 1L;
	private Integer channelNo; // 频道编号
	private String channelName; // 频道名称
	private String photoPath; // 频道图片
	private String themeType; // 风格类型
	private String themeConcreteType; // 风格类型明细
	private String channelVersion; // 频道版本
	private String musicStyle; // 音乐风格
	private String site; // 场所
	private String speed; // 速度
	private String voice; // 人声
	private String element; // 元素
	private String emotion; // 情绪
	private String instrument; // 乐器
	private String status; // 状态
	private String channelType; // 频道类型
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	private List<String> musicIds = Lists.newArrayList();
	
	//子频道列表
	private List<CdbooChannel> childChannelList = Lists.newArrayList();
	private List<CdbooChannelMusic> cdbooChannelMusics = Lists.newArrayList();
	private List<String> sortArray = Lists.newArrayList();
	private List<Integer> sorts = Lists.newArrayList();
	private List<String> channelIds = Lists.newArrayList();
	private Integer childChannelSize; //子频道数量
	private List<String> idArray;
	private List<String> inIdArray;
	private String ids;
	private String userId;
	private String volume;
	private Integer sort;
	
	public CdbooChannel() {
		super();
	}

	public CdbooChannel(String id) {
		super(id);
	}

	public Integer getChannelNo() {
		return channelNo;
	}

	public void setChannelNo(Integer channelNo) {
		this.channelNo = channelNo;
	}

	@Length(min = 0, max = 200, message = "频道名称长度必须介于 0 和 200 之间")
	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	@Length(min = 0, max = 2000, message = "频道图片长度必须介于 0 和 2000 之间")
	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	@Length(min = 0, max = 1, message = "风格类型长度必须介于 0 和 1 之间")
	public String getThemeType() {
		return themeType;
	}

	public void setThemeType(String themeType) {
		this.themeType = themeType;
	}

	@Length(min = 0, max = 2, message = "风格类型明细长度必须介于 0 和 2 之间")
	public String getThemeConcreteType() {
		return themeConcreteType;
	}

	public void setThemeConcreteType(String themeConcreteType) {
		this.themeConcreteType = themeConcreteType;
	}

	@Length(min = 0, max = 100, message = "频道版本长度必须介于 0 和 100 之间")
	public String getChannelVersion() {
		return channelVersion;
	}

	public void setChannelVersion(String channelVersion) {
		this.channelVersion = channelVersion;
	}

	@Length(min = 0, max = 100, message = "音乐风格长度必须介于 0 和 100 之间")
	public String getMusicStyle() {
		return musicStyle;
	}

	public void setMusicStyle(String musicStyle) {
		this.musicStyle = musicStyle;
	}

	@Length(min = 0, max = 100, message = "场所长度必须介于 0 和 100 之间")
	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	@Length(min = 0, max = 100, message = "速度长度必须介于 0 和 100 之间")
	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	@Length(min = 0, max = 100, message = "人声长度必须介于 0 和 100 之间")
	public String getVoice() {
		return voice;
	}

	public void setVoice(String voice) {
		this.voice = voice;
	}

	@Length(min = 0, max = 100, message = "元素长度必须介于 0 和 100 之间")
	public String getElement() {
		return element;
	}

	public void setElement(String element) {
		this.element = element;
	}

	@Length(min = 0, max = 100, message = "情绪长度必须介于 0 和 100 之间")
	public String getEmotion() {
		return emotion;
	}

	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}

	@Length(min = 0, max = 100, message = "乐器长度必须介于 0 和 100 之间")
	public String getInstrument() {
		return instrument;
	}

	public void setInstrument(String instrument) {
		this.instrument = instrument;
	}

	@Length(min = 0, max = 1, message = "状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Length(min = 0, max = 1, message = "频道类型长度必须介于 0 和 1 之间")
	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
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

	@JsonIgnore
	public List<String> getMusicStyleList() {// 音乐风格
		return getTypeList(this.musicStyle);
	}

	@JsonIgnore
	public List<String> getElementTypeList() {// 元素
		return getTypeList(this.element);
	}

	@JsonIgnore
	public List<String> getEmotionTypeList() {// 情绪
		return getTypeList(this.emotion);
	}

	@JsonIgnore
	public List<String> getInstrumentTypeList() {// 乐器
		return getTypeList(this.instrument);
	}

	public List<String> getTypeList(String value) {
		List<String> elementTypeList = Lists.newArrayList();
		if (StringUtils.isNotBlank(value)) {
			String[] elementTypeArray = StringUtils.split(value, ",");
			for (String elementTypeVal : elementTypeArray) {
				elementTypeList.add(elementTypeVal);
			}
		}

		return elementTypeList;
	}

	public void setMusicStyleList(List<String> musicStyleList) {// 音乐风格
		this.musicStyle = StringUtils.join(musicStyleList, ",");
	}

	public void setElementTypeList(List<String> elementTypeList) {// 元素
		this.element = StringUtils.join(elementTypeList, ",");
	}

	public void setEmotionTypeList(List<String> emotionTypeList) {// 情绪
		this.emotion = StringUtils.join(emotionTypeList, ",");
	}

	public void setInstrumentTypeList(List<String> instrumentTypeList) {// 乐器
		this.instrument = StringUtils.join(instrumentTypeList, ",");
	}

	public List<String> getMusicIds() {
		return musicIds;
	}

	public void setMusicIds(List<String> musicIds) {
		this.musicIds = musicIds;
	}

	public List<CdbooChannel> getChildChannelList() {
		return childChannelList;
	}

	public void setChildChannelList(List<CdbooChannel> childChannelList) {
		this.childChannelList = childChannelList;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public List<CdbooChannelMusic> getCdbooChannelMusics() {
		return cdbooChannelMusics;
	}

	public void setCdbooChannelMusics(List<CdbooChannelMusic> cdbooChannelMusics) {
		this.cdbooChannelMusics = cdbooChannelMusics;
	}

	public List<String> getSortArray() {
		return sortArray;
	}

	public void setSortArray(List<String> sortArray) {
		this.sortArray = sortArray;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public List<Integer> getSorts() {
		return sorts;
	}

	public void setSorts(List<Integer> sorts) {
		this.sorts = sorts;
	}

	public List<String> getChannelIds() {
		return channelIds;
	}

	public void setChannelIds(List<String> channelIds) {
		this.channelIds = channelIds;
	}

	public Integer getChildChannelSize() {
		return childChannelSize;
	}

	public void setChildChannelSize(Integer childChannelSize) {
		this.childChannelSize = childChannelSize;
	}
	
}