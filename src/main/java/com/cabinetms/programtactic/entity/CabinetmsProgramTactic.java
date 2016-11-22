/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.programtactic.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import java.util.List;

import com.cabinetms.terminal.entity.CabinetmsTerminal;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 节目策略一对多生成Entity
 * @author 于滨
 * @version 2016-10-19
 */
public class CabinetmsProgramTactic extends DataEntity<CabinetmsProgramTactic> {
	private static final long serialVersionUID = 1L;
	private String no;		// 策略编号
	private String name;		// 策略名称
	private Integer starttime;		// 开始时间
	private Integer endtime;		// 结束时间
	private String status;		// 策略状态
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private List<CabinetmsProgramTacticDetail> cabinetmsProgramTacticDetailList = Lists.newArrayList();		// 子表列表
	private List<CabinetmsTerminal> termList = Lists.newArrayList();//策略发布时使用的终端收集列表
	
	private String starttimeparam;		// 开始时间
	private String endtimeparam;		// 结束时间
	
	public CabinetmsProgramTactic() {
		super();
	}

	public CabinetmsProgramTactic(String id){
		super(id);
	}

	@Length(min=0, max=64, message="策略编号长度必须介于 0 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=0, max=64, message="策略名称长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getStarttime() {
		return starttime;
	}

	public void setStarttime(Integer starttime) {
		this.starttime = starttime;
	}
	
	public Integer getEndtime() {
		return endtime;
	}

	public void setEndtime(Integer endtime) {
		this.endtime = endtime;
	}
	
	@Length(min=0, max=1, message="策略状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
		
	public List<CabinetmsProgramTacticDetail> getCabinetmsProgramTacticDetailList() {
		return cabinetmsProgramTacticDetailList;
	}

	public void setCabinetmsProgramTacticDetailList(List<CabinetmsProgramTacticDetail> cabinetmsProgramTacticDetailList) {
		this.cabinetmsProgramTacticDetailList = cabinetmsProgramTacticDetailList;
	}

	public List<CabinetmsTerminal> getTermList() {
		return termList;
	}

	public void setTermList(List<CabinetmsTerminal> termList) {
		this.termList = termList;
	}

	public String getStarttimeparam() {
		
		if(this.starttime!=null && this.starttime>0){
			String startTimeStr = String.valueOf(this.starttime);
			this.starttimeparam = startTimeStr.substring(0, 4)+"-"+startTimeStr.substring(4, 6)+"-"+startTimeStr.substring(6, 8);
		}
		
		return starttimeparam;
	}

	public void setStarttimeparam(String starttimeparam) {
		this.starttimeparam = starttimeparam;
		
		if(StringUtils.isNotBlank(starttimeparam)){
			setStarttime(Integer.parseInt(starttimeparam.replace("-", "")));	
		}
	}

	public String getEndtimeparam() {
		if(this.endtime!=null && this.endtime>0){
			String endTimeStr = String.valueOf(this.endtime);
			this.endtimeparam = endTimeStr.substring(0, 4)+"-"+endTimeStr.substring(4, 6)+"-"+endTimeStr.substring(6, 8);
		}
		
		return endtimeparam;
	}

	public void setEndtimeparam(String endtimeparam) {
		this.endtimeparam = endtimeparam;
		if(StringUtils.isNotBlank(endtimeparam)){
			setEndtime(Integer.parseInt(endtimeparam.replace("-", "")));	
		}
	}

}