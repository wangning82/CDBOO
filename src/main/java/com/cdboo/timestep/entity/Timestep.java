/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * 时段管理Entity
 * @author 朱广成
 * @version 2016-12-13
 */
public class Timestep extends DataEntity<Timestep> {
	
	private static final long serialVersionUID = 1L;
	private String timestepNo;		// 时段编号
	private String timestepName;		// 时段名称
	private Date starttime;		// 开始时间
	private Date endtime;		// 结束时间
	private String status;		// 状态位显示
	private Date beginStarttime;		// 开始 开始时间
	private Date endStarttime;		// 结束 开始时间
	private Date beginEndtime;		// 开始 结束时间
	private Date endEndtime;		// 结束 结束时间

	public Timestep() {
		super();
	}

	public Timestep(String id){
		super(id);
	}

	@Length(min=0, max=100, message="时段编号长度必须介于 0 和 100 之间")
	public String getTimestepNo() {
		return timestepNo;
	}

	public void setTimestepNo(String timestepNo) {
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

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Date getBeginStarttime() {
		return beginStarttime;
	}

	public void setBeginStarttime(Date beginStarttime) {
		this.beginStarttime = beginStarttime;
	}

	public Date getEndStarttime() {
		return endStarttime;
	}

	public void setEndStarttime(Date endStarttime) {
		this.endStarttime = endStarttime;
	}

	public Date getBeginEndtime() {
		return beginEndtime;
	}

	public void setBeginEndtime(Date beginEndtime) {
		this.beginEndtime = beginEndtime;
	}

	public Date getEndEndtime() {
		return endEndtime;
	}

	public void setEndEndtime(Date endEndtime) {
		this.endEndtime = endEndtime;
	}
}