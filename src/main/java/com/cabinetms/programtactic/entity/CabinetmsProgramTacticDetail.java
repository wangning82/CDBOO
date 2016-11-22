/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.cabinetms.programtactic.entity;

import com.cabinetms.programtactic.entity.CabinetmsProgramTactic;
import com.google.common.collect.Lists;

import java.util.List;

import org.hibernate.validator.constraints.Length;
import com.cabinetms.program.entity.Program;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.StringUtils;

/**
 * 节目策略一对多生成Entity
 * @author 于滨
 * @version 2016-10-19
 */
public class CabinetmsProgramTacticDetail extends DataEntity<CabinetmsProgramTacticDetail> {
	
	private static final long serialVersionUID = 1L;
	private CabinetmsProgramTactic programTactic;		// 节目策略ID 父类
	private String programTacticName;		// 节目策略名称
	private Program program;		// 节目ID
	private String programName;		// 节目名称
	private Integer starttime;		// 开始时间
	private Integer endtime;		// 结束时间
	
	private String starttimeparam;
	private String endtimeparam;
	
	private List<Program> programList = Lists.newArrayList();
	
	public CabinetmsProgramTacticDetail() {
		super();
	}

	public CabinetmsProgramTacticDetail(String id){
		super(id);
	}

	public CabinetmsProgramTacticDetail(CabinetmsProgramTactic programTactic){
		this.programTactic = programTactic;
	}

	public CabinetmsProgramTactic getProgramTactic() {
		return programTactic;
	}

	public void setProgramTactic(CabinetmsProgramTactic programTactic) {
		this.programTactic = programTactic;
	}
	
	@Length(min=0, max=64, message="节目策略名称长度必须介于 0 和 64 之间")
	public String getProgramTacticName() {
		return programTacticName;
	}

	public void setProgramTacticName(String programTacticName) {
		this.programTacticName = programTacticName;
	}
	
	public Program getProgram() {
		return program;
	}

	public void setProgram(Program program) {
		this.program = program;
	}
	
	@Length(min=0, max=64, message="节目名称长度必须介于 0 和 64 之间")
	public String getProgramName() {
		return programName;
	}

	public void setProgram(String programName) {
		this.programName = programName;
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

	public List<Program> getProgramList() {
		return programList;
	}

	public void setProgramList(List<Program> programList) {
		this.programList = programList;
	}

	public String getStarttimeparam() {
		if(this.starttime!=null && this.starttime>0){
			String startTimeStr = String.valueOf(this.starttime);
			if(startTimeStr.length()<6){
				startTimeStr = "0"+startTimeStr;
			}
			this.starttimeparam = startTimeStr.substring(0, 2)+":"+startTimeStr.substring(2, 4)+":"+startTimeStr.substring(4, 6);
		}
		return starttimeparam;
	}

	public void setStarttimeparam(String starttimeparam) {
		this.starttimeparam = starttimeparam;
		if(StringUtils.isNotBlank(starttimeparam)){
			setStarttime(Integer.parseInt(starttimeparam.replace(":", "")));	
		}
	}

	public String getEndtimeparam() {
		if(this.endtime!=null && this.endtime>0){
			String endTimeStr = String.valueOf(this.endtime);
			if(endTimeStr.length()<6){
				endTimeStr = "0"+endTimeStr;
			}
			this.endtimeparam = endTimeStr.substring(0, 2)+":"+endTimeStr.substring(2, 4)+":"+endTimeStr.substring(4, 6);
		}
		return endtimeparam;
	}

	public void setEndtimeparam(String endtimeparam) {
		this.endtimeparam = endtimeparam;
		if(StringUtils.isNotBlank(endtimeparam)){
			setEndtime(Integer.parseInt(endtimeparam.replace(":", "")));	
		}
	}
	
}