/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cdboo.timestep.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 时段管理Entity
 * @author 朱广成
 * @version 2016-12-13
 */
public class Timestep extends DataEntity<Timestep> {
	
	private static final long serialVersionUID = 1L;
	private String timestepNo;		// 时段编号
	private String timestepName;		// 时段名称
	private String starttime;		// 开始时间
	private String endtime;		// 结束时间
	private String status;		// 状态位显示
	private String beginStarttime;		// 开始 开始时间
	private String endStarttime;		// 结束 开始时间
	private String beginEndtime;		// 开始 结束时间
	private String endEndtime;		// 结束 结束时间

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

}