package com.cdboo.rest;

import java.io.Serializable;

/**
 * 用户时段信息rest实体
 * @author yubin
 *
 */
public class RestTimeStep implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String timestepNo;		// 时段编号
	private String timestepName;		// 时段名称
	private String starttime;		// 开始时间 如果风格是插播，开始时间和结束时间理论上是一样的，取开始时间即可
	private String endtime;		// 结束时间
	public String getTimestepNo() {
		return timestepNo;
	}
	public void setTimestepNo(String timestepNo) {
		this.timestepNo = timestepNo;
	}
	public String getTimestepName() {
		return timestepName;
	}
	public void setTimestepName(String timestepName) {
		this.timestepName = timestepName;
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
	
}
