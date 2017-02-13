/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.entity;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import jersey.repackaged.com.google.common.collect.Lists;

/**
 * 时段管理Entity
 * @author 朱广成
 * @version 2016-12-13
 */
public class Timestep extends DataEntity<Timestep> {
	
	private static final long serialVersionUID = 1L;
	private Integer timestepNo;		// 时段编号
	private String timestepName;		// 时段名称
	private String starttime;		// 开始时间
	private String endtime;		// 结束时间
	private String status;		// 状态位显示
	private String beginStarttime;		// 开始 开始时间
	private String endStarttime;		// 结束 开始时间
	private String beginEndtime;		// 开始 结束时间
	private String endEndtime;		// 结束 结束时间
	private String ids;
	private List<String> notIncludeIds;
	public Timestep() {
		super();
	}

	public Timestep(String id){
		super(id);
	}
	
	public Timestep(String timestepName, String starttime, String endtime) {
		super();
		this.timestepName = timestepName;
		this.starttime = starttime;
		this.endtime = endtime;
	}

	public Integer getTimestepNo() {
		return timestepNo;
	}

	public void setTimestepNo(Integer timestepNo) {
		this.timestepNo = timestepNo;
	}
	
	@Length(min=0, max=100, message="时段名称长度必须介于 0 和 100 之间")
	public String getTimestepName() {
		return timestepName;
	}

	public void setTimestepName(String timestepName) {
		this.timestepName = timestepName;
	}

	@Length(min=0, max=1, message="状态位显示长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getBeginStarttime() {
		return beginStarttime;
	}

	public void setBeginStarttime(String beginStarttime) {
		this.beginStarttime = beginStarttime;
	}

	public String getEndStarttime() {
		return endStarttime;
	}

	public void setEndStarttime(String endStarttime) {
		this.endStarttime = endStarttime;
	}

	public String getBeginEndtime() {
		return beginEndtime;
	}

	public void setBeginEndtime(String beginEndtime) {
		this.beginEndtime = beginEndtime;
	}

	public String getEndEndtime() {
		return endEndtime;
	}

	public void setEndEndtime(String endEndtime) {
		this.endEndtime = endEndtime;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;

		if (StringUtils.isNotBlank(ids)) {
			notIncludeIds = Lists.newArrayList();
			String[] idsArray = StringUtils.split(ids, ",");
			for (int i = 0; i < idsArray.length; i++) {
				notIncludeIds.add("'" + idsArray[i] + "'");
			}
		}
	}
}